"""Lightweight knowledge OTA and account-isolated notes/bookmarks sync API."""
from __future__ import annotations

import argparse
from contextlib import closing
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
import json
import hashlib
import os
from pathlib import Path
import re
import shutil
import sqlite3
import stat
from urllib.parse import parse_qs, quote, urlsplit

MAX_BODY_BYTES = 1024 * 1024
MAX_OUTBOX = 200
MAX_PULL = 500
MAX_CONTENT = 65536
MAX_CURSOR = 2**63 - 1


class ApiError(Exception):
    def __init__(self, status: int, code: str, message: str):
        self.status, self.code, self.message = status, code, message
        super().__init__(message)


def _unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError("Duplicate JSON field")
        result[key] = value
    return result


def _json_loads(value):
    return json.loads(value, object_pairs_hook=_unique_object,
                      parse_constant=lambda value: (_ for _ in ()).throw(ValueError("Invalid JSON constant")))


def _cursor(value):
    if type(value) is not int or not 0 <= value <= MAX_CURSOR:
        raise ApiError(400, "invalid_cursor", "cursor must be a nonnegative integer")
    return value


def _identifier(value, field):
    if not isinstance(value, str) or not value.strip() or len(value) > 256:
        raise ApiError(400, "invalid_mutation", f"{field} must be a nonempty string of at most 256 characters")
    if any(ord(char) < 32 for char in value):
        raise ApiError(400, "invalid_mutation", f"{field} must not contain control characters")
    try:
        value.encode("utf-8")
    except UnicodeEncodeError:
        raise ApiError(400, "invalid_mutation", f"{field} must contain valid Unicode") from None
    return value


def _mutation(value):
    if not isinstance(value, dict):
        raise ApiError(400, "invalid_mutation", "Every outbox entry must be an object")
    collection = value.get("collection")
    if collection not in ("notes", "bookmarks"):
        raise ApiError(400, "invalid_collection", "Only notes and bookmarks may be synced")
    required = {"mutation_id", "collection", "id", "article_id", "client_updated_at", "is_deleted"}
    if collection == "notes":
        required.add("content")
    if set(value) != required:
        raise ApiError(400, "invalid_mutation", "Mutation fields do not match the collection schema")
    for field in ("mutation_id", "id", "article_id"):
        _identifier(value[field], field)
    if type(value["is_deleted"]) is not bool:
        raise ApiError(400, "invalid_mutation", "is_deleted must be a boolean")
    if collection == "notes" and (not isinstance(value["content"], str) or len(value["content"]) > MAX_CONTENT):
        raise ApiError(400, "invalid_mutation", "content must be a string of at most 65536 characters")
    timestamp = value["client_updated_at"]
    try:
        if not isinstance(timestamp, str) or len(timestamp) > 64 or "T" not in timestamp:
            raise ValueError()
        parsed = datetime.fromisoformat(timestamp.replace("Z", "+00:00"))
        if parsed.tzinfo is None or parsed.utcoffset() is None:
            raise ValueError()
        normalized = parsed.astimezone(timezone.utc).isoformat(timespec="microseconds")
    except (ValueError, OverflowError):
        raise ApiError(400, "invalid_mutation", "client_updated_at must be an ISO8601 timestamp with timezone") from None
    payload = json.dumps(value, ensure_ascii=True, sort_keys=True, separators=(",", ":"))
    record = {key: item for key, item in value.items() if key != "mutation_id"}
    record["client_updated_at"] = normalized
    return value["mutation_id"], payload, record


class SyncStore:
    def __init__(self, path):
        self.path = path
        with closing(self.connect()) as db:
            db.executescript("""
                PRAGMA journal_mode=WAL;
                CREATE TABLE IF NOT EXISTS records (
                    account_id TEXT NOT NULL, collection TEXT NOT NULL, id TEXT NOT NULL,
                    timestamp TEXT NOT NULL, payload TEXT NOT NULL,
                    PRIMARY KEY(account_id, collection, id)
                );
                CREATE TABLE IF NOT EXISTS mutations (
                    account_id TEXT NOT NULL, mutation_id TEXT NOT NULL, payload TEXT NOT NULL,
                    PRIMARY KEY(account_id, mutation_id)
                );
                CREATE TABLE IF NOT EXISTS changes (
                    revision INTEGER PRIMARY KEY AUTOINCREMENT,
                    account_id TEXT NOT NULL, payload TEXT NOT NULL
                );
                CREATE INDEX IF NOT EXISTS changes_account_revision ON changes(account_id, revision);
            """)

    def connect(self):
        return sqlite3.connect(self.path, timeout=15, isolation_level=None)

    def sync(self, account, cursor, outbox):
        prepared = [_mutation(entry) for entry in outbox]
        with closing(self.connect()) as db:
            db.execute("BEGIN IMMEDIATE" if prepared else "BEGIN")
            try:
                latest = db.execute("SELECT COALESCE(MAX(revision),0) FROM changes WHERE account_id=?", (account,)).fetchone()[0]
                if cursor > latest:
                    raise ApiError(400, "invalid_cursor", "cursor is ahead of this account's server revision")
                acknowledged = []
                for mutation_id, payload, record in prepared:
                    previous = db.execute("SELECT payload FROM mutations WHERE account_id=? AND mutation_id=?", (account, mutation_id)).fetchone()
                    if previous:
                        if previous[0] != payload:
                            raise ApiError(409, "mutation_collision", "mutation_id already has a different payload")
                        acknowledged.append(mutation_id)
                        continue
                    key = (account, record["collection"], record["id"])
                    current = db.execute("SELECT timestamp,payload FROM records WHERE account_id=? AND collection=? AND id=?", key).fetchone()
                    state = json.dumps(record, ensure_ascii=True, sort_keys=True, separators=(",", ":"))
                    if current and (record["client_updated_at"] < current[0] or
                                    (record["client_updated_at"] == current[0] and state != current[1])):
                        raise ApiError(409, "stale_mutation", "Mutation timestamp is older than or conflicts with the stored record")
                    if not current or state != current[1]:
                        db.execute("INSERT INTO records VALUES (?,?,?,?,?) ON CONFLICT(account_id,collection,id) DO UPDATE SET timestamp=excluded.timestamp,payload=excluded.payload",
                                   (*key, record["client_updated_at"], state))
                        db.execute("INSERT INTO changes(account_id,payload) VALUES (?,?)", (account, state))
                    db.execute("INSERT INTO mutations VALUES (?,?,?)", (account, mutation_id, payload))
                    acknowledged.append(mutation_id)
                rows = db.execute("SELECT revision,payload FROM changes WHERE account_id=? AND revision>? ORDER BY revision LIMIT ?", (account, cursor, MAX_PULL)).fetchall()
                changes = [dict(json.loads(payload), revision=revision) for revision, payload in rows]
                next_cursor = rows[-1][0] if rows else cursor
                db.execute("COMMIT")
                return {"acknowledged": acknowledged, "changes": changes, "cursor": next_cursor}
            except BaseException:
                db.execute("ROLLBACK")
                raise


class KnowledgeServer(ThreadingHTTPServer):
    daemon_threads = True

    def __init__(self, address, data_dir, tokens):
        self.data_dir = data_dir
        self.tokens = tokens
        self.store = SyncStore(data_dir / "user_sync.db")
        super().__init__(address, ApiHandler)


class ApiHandler(BaseHTTPRequestHandler):
    server_version = "PKNBackend/2"

    def setup(self):
        super().setup()
        self.connection.settimeout(15)

    def log_message(self, format, *args):
        # Do not log request paths, bearer tokens, or private payloads.
        pass

    def _send_json(self, status, value):
        data = json.dumps(value, ensure_ascii=True, allow_nan=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.send_header("Cache-Control", "no-store")
        if status == 401:
            self.send_header("WWW-Authenticate", "Bearer")
        self.end_headers()
        self.wfile.write(data)

    def _account(self):
        headers = self.headers.get_all("Authorization", [])
        if len(headers) != 1:
            raise ApiError(401, "unauthorized", "A valid bearer token is required")
        scheme, separator, token = headers[0].partition(" ")
        account = self.server.tokens.get(token) if scheme.lower() == "bearer" and separator else None
        if account is None:
            raise ApiError(401, "unauthorized", "A valid bearer token is required")
        return account

    def _manifest(self):
        try:
            path = self.server.data_dir / "release_manifest.json"
            if path.stat().st_size > MAX_BODY_BYTES:
                raise ValueError("Manifest is too large")
            manifest = _json_loads(path.read_text(encoding="utf-8"))
            name = manifest.get("file_name") if isinstance(manifest, dict) else None
            if (not isinstance(name, str) or len(name) > 255 or
                    not re.fullmatch(r"[A-Za-z0-9_.-]+-[0-9a-f]{64}\.zst", name) or
                    manifest.get("sha256") != name[-68:-4]):
                raise ValueError("Invalid asset name")
            manifest["download_url"] = "/api/knowledge/download?file=" + quote(name, safe="")
            return manifest
        except (OSError, ValueError, UnicodeError):
            raise ApiError(503, "release_unavailable", "No valid knowledge release is available") from None

    def _download(self, query_string):
        if query_string:
            query = parse_qs(query_string, keep_blank_values=True)
            if set(query) != {"file"} or len(query["file"]) != 1:
                raise ApiError(400, "invalid_asset", "Supply one file query parameter")
            name = query["file"][0]
            if len(name) > 255 or not re.fullmatch(r"[A-Za-z0-9_.-]+-[0-9a-f]{64}\.zst", name):
                raise ApiError(400, "invalid_asset", "Asset must be an immutable checksum-named Zstandard file")
        else:
            name = self._manifest()["file_name"]
        asset = self.server.data_dir / name
        try:
            if asset.is_symlink() or asset.resolve().parent != self.server.data_dir:
                raise OSError("Unsafe asset")
            descriptor = os.open(asset, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
            stream = os.fdopen(descriptor, "rb")
        except OSError:
            raise ApiError(503, "release_unavailable", "Knowledge release asset is unavailable") from None
        with stream:
            if not stat.S_ISREG(os.fstat(stream.fileno()).st_mode):
                raise ApiError(503, "release_unavailable", "Knowledge release asset is not a regular file")
            if query_string:
                checksum = hashlib.sha256()
                for block in iter(lambda: stream.read(65536), b""):
                    checksum.update(block)
                if checksum.hexdigest() != name[-68:-4]:
                    raise ApiError(503, "release_unavailable", "Immutable knowledge asset checksum does not match")
                stream.seek(0)
            size = os.fstat(stream.fileno()).st_size
            self.send_response(200)
            self.send_header("Content-Type", "application/zstd")
            self.send_header("Content-Length", str(size))
            self.send_header("Content-Disposition", 'attachment; filename="' + name.replace('"', '') + '"')
            self.send_header("Cache-Control", "no-store")
            self.end_headers()
            shutil.copyfileobj(stream, self.wfile, 65536)

    def _body(self):
        lengths = self.headers.get_all("Content-Length", [])
        if self.headers.get("Transfer-Encoding") or len(lengths) != 1:
            raise ApiError(400, "invalid_body", "A single Content-Length is required; transfer encoding is not supported")
        try:
            length = int(lengths[0])
        except ValueError:
            raise ApiError(400, "invalid_body", "Invalid Content-Length") from None
        if not 0 < length <= MAX_BODY_BYTES:
            raise ApiError(413, "body_too_large", "Body must contain at most 1048576 bytes")
        if self.headers.get_content_type() != "application/json":
            raise ApiError(415, "unsupported_media_type", "Content-Type must be application/json")
        raw = self.rfile.read(length)
        if len(raw) != length:
            raise ApiError(400, "invalid_body", "Incomplete request body")
        try:
            body = _json_loads(raw.decode("utf-8"))
        except (ValueError, UnicodeError, RecursionError):
            raise ApiError(400, "invalid_body", "Body must be valid UTF-8 JSON") from None
        if not isinstance(body, dict) or set(body) != {"cursor", "outbox"}:
            raise ApiError(400, "invalid_body", "Body must contain only cursor and outbox")
        cursor = _cursor(body["cursor"])
        outbox = body["outbox"]
        if not isinstance(outbox, list) or len(outbox) > MAX_OUTBOX:
            raise ApiError(400, "invalid_body", "outbox must be an array of at most 200 mutations")
        return cursor, outbox

    def _dispatch(self, method):
        try:
            target = urlsplit(self.path)
            if method == "GET" and target.path == "/health" and not target.query:
                self._send_json(200, {"status": "ok"})
            elif method == "GET" and target.path == "/api/knowledge/release" and not target.query:
                self._send_json(200, self._manifest())
            elif method == "GET" and target.path == "/api/knowledge/download":
                self._download(target.query)
            elif target.path == "/api/user/sync":
                account = self._account()
                if method == "GET":
                    query = parse_qs(target.query, keep_blank_values=True)
                    if set(query) != {"cursor"} or len(query["cursor"]) != 1 or not query["cursor"][0].isascii() or not query["cursor"][0].isdecimal():
                        raise ApiError(400, "invalid_cursor", "Supply one cursor=N query parameter")
                    cursor, outbox = _cursor(int(query["cursor"][0])), []
                else:
                    if target.query:
                        raise ApiError(400, "invalid_body", "POST sync does not accept query parameters")
                    cursor, outbox = self._body()
                self._send_json(200, self.server.store.sync(account, cursor, outbox))
            else:
                raise ApiError(404, "not_found", "Endpoint not found")
        except ApiError as error:
            self._send_json(error.status, {"error": error.code, "message": error.message})
        except (BrokenPipeError, ConnectionResetError, TimeoutError):
            self.close_connection = True
        except (sqlite3.Error, OSError):
            self._send_json(503, {"error": "storage_unavailable", "message": "Storage is temporarily unavailable"})
        except ValueError:
            self._send_json(400, {"error": "invalid_request", "message": "Invalid request"})

    def do_GET(self):
        self._dispatch("GET")

    def do_POST(self):
        self._dispatch("POST")


def create_server(host="127.0.0.1", port=8080, data_dir=".", auth_file=None):
    """Create an unstarted HTTP server; callers own serve_forever/shutdown/server_close."""
    if auth_file is None:
        raise ValueError("auth_file is required")
    tokens = _json_loads(Path(auth_file).read_text(encoding="utf-8"))
    if not isinstance(tokens, dict):
        raise ValueError("Auth file must map opaque bearer tokens to account IDs")
    for token, account in tokens.items():
        if (not isinstance(token, str) or not token or any(char.isspace() or ord(char) < 32 for char in token)
                or not isinstance(account, str) or not account.strip() or len(account) > 256):
            raise ValueError("Auth file must map nonempty opaque tokens to nonempty account IDs")
    directory = Path(data_dir).resolve()
    directory.mkdir(parents=True, exist_ok=True)
    return KnowledgeServer((host, port), directory, tokens)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8080)
    parser.add_argument("--data-dir", type=Path, default=Path(__file__).resolve().parent / "data")
    parser.add_argument("--auth-file", type=Path, required=True)
    args = parser.parse_args()
    try:
        server = create_server(args.host, args.port, args.data_dir, args.auth_file)
    except (OSError, ValueError) as error:
        parser.error(str(error))
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()


if __name__ == "__main__":
    main()
