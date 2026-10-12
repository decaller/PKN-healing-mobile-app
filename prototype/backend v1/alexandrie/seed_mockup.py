#!/usr/bin/env python3
"""Isi workspace Alexandrie lokal dengan corpus mockup desain PKN."""
import http.cookiejar
import json
import os
from pathlib import Path
import secrets
import subprocess
import urllib.error
import urllib.parse
import urllib.request

BASE = Path(__file__).resolve().parent
API = os.environ.get("ALEXANDRIE_API", "http://localhost:8201/api")
CREDENTIALS = BASE / ".seed-account.json"
DATA = BASE / "mockup-data.json"
COMPILER = """
import { Marked, Renderer } from 'marked';
import sanitizeHtml from 'sanitize-html';
let input = '';
for await (const chunk of process.stdin) input += chunk;
const renderer = new Renderer();
renderer.html = () => '';
const parser = new Marked({ renderer, gfm: true });
console.log(JSON.stringify(JSON.parse(input).map(body => sanitizeHtml(parser.parse(body), {
  allowedTags: [...sanitizeHtml.defaults.allowedTags, 'img'],
  allowedAttributes: { ...sanitizeHtml.defaults.allowedAttributes, img: ['src', 'alt'] },
  allowedSchemes: ['http', 'https', 'mailto'],
  allowProtocolRelative: false,
}))));
"""


def compile_markdown(bodies):
    if not bodies:
        return {}
    result = subprocess.run(
        ["node", "--input-type=module", "-e", COMPILER],
        cwd=BASE.parent, input=json.dumps(bodies), text=True,
        capture_output=True, check=False,
    )
    if result.returncode:
        raise RuntimeError("Kompilasi Markdown gagal; pastikan dependensi npm backend v1 terpasang.")
    return dict(zip(bodies, json.loads(result.stdout), strict=True))


def main():
    jar = http.cookiejar.CookieJar()
    client = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(jar))

    def request(method, path, payload=None, form=False):
        body = None
        headers = {}
        # urllib tidak mengirim domain-cookie localhost pada host tanpa titik.
        if jar:
            headers["Cookie"] = "; ".join(f"{cookie.name}={cookie.value}" for cookie in jar)
        if payload is not None:
            body = (urllib.parse.urlencode(payload) if form else json.dumps(payload)).encode()
            headers["Content-Type"] = "application/x-www-form-urlencoded" if form else "application/json"
        req = urllib.request.Request(API + path, body, headers, method=method)
        try:
            with client.open(req, timeout=30) as response:
                result = json.load(response)
        except urllib.error.HTTPError as error:
            raise RuntimeError(f"{method} {path}: HTTP {error.code}") from error
        return result["result"] if isinstance(result, dict) and "result" in result else result

    if CREDENTIALS.exists():
        account = json.loads(CREDENTIALS.read_text())
    else:
        account = {"username": "pkn_mockup", "email": "pkn.mockup@example.test", "password": secrets.token_urlsafe(24), "firstname": "PKN", "lastname": "Mockup"}
        with CREDENTIALS.open("x") as file:
            os.chmod(CREDENTIALS, 0o600)
            json.dump(account, file, indent=2)
        request("POST", "/users", account)
    user = request("POST", "/auth", {"username": account["username"], "password": account["password"]}, form=True)
    user_id = str(user["id"])
    nodes = request("GET", "/nodes/user/" + user_id) or []
    by_key = {node.get("metadata", {}).get("pkn_seed_key"): node for node in nodes if isinstance(node.get("metadata"), dict)}
    records = json.loads(DATA.read_text())
    records = records["records"] if isinstance(records, dict) else records
    created = 0
    skipped = 0
    repaired = 0
    renamed = 0
    profile_key = "document:profil_pengguna_aktivitas_bookmark"
    pending_bodies = set()
    for record in records:
        key = "document:" + record["key"]
        node = by_key.get(key)
        if node is None:
            pending_bodies.add(record["body"])
            continue
        if (node["metadata"].get("mockup") is not True
                or str(node.get("user_id")) != user_id or node.get("role") != 3):
            continue
        # List responses omit document bodies; preserve the complete node on PUT.
        detail = request("GET", "/nodes/" + str(node["id"]))
        node = detail["node"]
        by_key[key] = node
        if not (node.get("content_compiled") or "").strip():
            body = node.get("content") or record["body"]
            if key == profile_key and body == record["body"].replace("# Demo Ayah\n", "# Abu Hafi\n", 1):
                body = record["body"]
            pending_bodies.add(body)
    compiled = compile_markdown(list(pending_bodies))

    def ensure(key, name, role, parent=None, body="", category="", source="", fields=None):
        nonlocal created, skipped, repaired, renamed
        if key in by_key:
            node = by_key[key]
            owned_document = (role == 3 and node.get("role") == 3
                              and node["metadata"].get("mockup") is True
                              and str(node.get("user_id")) == user_id)
            updates = {}
            if owned_document and not (node.get("content_compiled") or "").strip():
                current_body = node.get("content") or body
                if key == profile_key and current_body == body.replace("# Demo Ayah\n", "# Abu Hafi\n", 1):
                    current_body = body
                updates["content_compiled"] = compiled[current_body]
                if current_body != node.get("content"):
                    updates["content"] = current_body
                repaired += 1
            if owned_document and key == profile_key and node.get("name") == "Abu Hafi":
                updates["name"] = name
                renamed += 1
            if updates:
                # PUT replaces fields, so include every current field rather than defaults.
                request("PUT", "/nodes/" + str(node["id"]), {**node, **updates})
            skipped += 1
            return str(node["id"])
        payload = {"name": name, "role": role, "accessibility": 1, "access": 0, "description": "MOCKUP PKN — data desain, bukan data operasional.", "metadata": {"pkn_seed_key": key, "mockup": True, "source": source, "fields": fields or {}}}
        if parent:
            payload["parent_id"] = parent
        if body:
            payload["content"] = body
            payload["content_compiled"] = compiled[body]
        if category:
            payload["tags"] = "mockup,pkn," + category
        node = request("POST", "/nodes", payload)
        by_key[key] = node
        created += 1
        return str(node["id"])

    root = ensure("workspace:pkn-v2", "PKN — Mockup Desain v2", 1)
    categories = {}
    for record in records:
        category = record["category"]
        if category not in categories:
            categories[category] = ensure("category:" + category, category, 2, root)
        ensure("document:" + record["key"], record["title"], 3, categories[category], record["body"], category, record["source"], record.get("fields"))
    final_nodes = request("GET", "/nodes/user/" + user_id)
    keys = {n.get("metadata", {}).get("pkn_seed_key") for n in final_nodes if isinstance(n.get("metadata"), dict)}
    expected = {"document:" + r["key"] for r in records}
    if not expected <= keys:
        raise RuntimeError("Dokumen seed belum lengkap: " + repr(expected - keys))
    print(json.dumps({"created": created, "skipped": skipped, "repaired": repaired, "renamed": renamed, "documents": len(records), "categories": len(categories), "workspace_id": root}, ensure_ascii=False))


if __name__ == "__main__":
    main()
