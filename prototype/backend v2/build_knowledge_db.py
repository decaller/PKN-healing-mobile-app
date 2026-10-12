#!/usr/bin/env python3
"""Kompilasi Wiki-AI dan kurasi Alexandrie ke SQLite baca-saja dan rilis OTA."""
import argparse
import glob
import hashlib
import json
import os
from pathlib import Path
import re
import sqlite3
import tempfile
import urllib.request


def chunk_markdown(text: str, chunk_size: int = 1200, overlap: int = 150) -> list[str]:
    """Potong maksimal chunk_size karakter, dengan overlap yang selalu maju."""
    if chunk_size <= 0 or not 0 <= overlap < chunk_size:
        raise ValueError("chunk_size harus positif dan 0 <= overlap < chunk_size")
    text = text.strip()
    chunks = []
    start = 0
    while start < len(text):
        end = min(start + chunk_size, len(text))
        # Pilih batas paragraf/kata hanya jika masih menjamin kemajuan.
        if end < len(text):
            boundary = text.rfind("\n\n", start + overlap + 1, end)
            if boundary == -1:
                boundary = text.rfind(" ", start + overlap + 1, end)
            if boundary != -1:
                end = boundary
        chunk = text[start:end].strip()
        if chunk:
            chunks.append(chunk)
        if end == len(text):
            break
        start = end - overlap
    return chunks


def load_alexandrie_records(json_path, api_url, user_id=None, cookie=None):
    """API node asli atau URL ekspor JSON eksplisit; tanpa fallback tersembunyi."""
    def fetch(url):
        headers = {"Accept": "application/json"}
        if cookie:
            headers["Cookie"] = cookie
        with urllib.request.urlopen(urllib.request.Request(url, headers=headers), timeout=30) as response:
            value = json.load(response)
        return value.get("result", value) if isinstance(value, dict) else value
    if api_url:
        url = api_url.rstrip("/")
        if url.endswith("/api"):
            if not user_id:
                raise ValueError("API /api membutuhkan --alexandrie-user-id dan cookie login")
            url += "/nodes/user/" + str(user_id)
        payload = fetch(url)
        if "/nodes/user/" in url:
            if not isinstance(payload, list):
                raise ValueError("Daftar node Alexandrie harus array")
            parents = {str(node["id"]): node for node in payload}
            records = []
            base = url.split("/nodes/user/", 1)[0]
            for node in payload:
                if node.get("role") != 3:
                    continue
                detail = fetch(base + "/nodes/" + str(node["id"]))
                detail = detail.get("node", detail) if isinstance(detail, dict) else detail
                if not isinstance(detail, dict):
                    raise ValueError("Detail node Alexandrie tidak valid")
                metadata = detail.get("metadata") or {}
                if isinstance(metadata, str):
                    metadata = json.loads(metadata)
                if not isinstance(metadata, dict):
                    raise ValueError("metadata node harus object")
                parent = parents.get(str(detail.get("parent_id")), {})
                records.append({**detail, **metadata,
                                "key": metadata.get("pkn_seed_key") or str(detail["id"]),
                                "title": detail.get("name"),
                                "category": metadata.get("category") or parent.get("name") or "Kurasi Pakar",
                                "body": detail.get("content", ""), "metadata": metadata})
            return records
    elif json_path:
        with open(json_path, encoding="utf-8") as source:
            payload = json.load(source)
    else:
        return []
    if isinstance(payload, dict):
        payload = payload.get("records", payload.get("documents", payload.get("data")))
        if isinstance(payload, dict):
            payload = payload.get("records", payload.get("documents"))
    if not isinstance(payload, list) or any(not isinstance(r, dict) for r in payload):
        raise ValueError("Ekspor Alexandrie harus array dokumen atau {records: [...]}")
    return payload


def _content_type(record):
    if record.get("content_type"):
        return "buku" if record["content_type"] == "book" else record["content_type"]
    label = (str(record.get("key", "")) + " " + str(record.get("category", ""))).lower()
    for words, kind in ((('doa',), 'doa'), (('cerita', 'serial', 'episode'), 'cerita_rpg'),
                        (('buku', 'pustaka'), 'buku'), (('agenda', 'event'), 'event')):
        if any(word in label for word in words):
            return kind
    return "article"


def _sha256(path):
    digest = hashlib.sha256()
    with open(path, "rb") as source:
        for block in iter(lambda: source.read(65536), b""):
            digest.update(block)
    return digest.hexdigest()


def _temporary(target):
    target = Path(target)
    target.parent.mkdir(parents=True, exist_ok=True)
    fd, name = tempfile.mkstemp(prefix="." + target.name + ".", dir=target.parent)
    os.close(fd)
    return Path(name)


class SemanticEmbedder:
    """Embedder 384-dimensi untuk LibSQL vector search dengan fallback deterministik."""
    def __init__(self, model_name="sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"):
        self.model_name = model_name
        self._model = None
        try:
            from sentence_transformers import SentenceTransformer
            self._model = SentenceTransformer(model_name)
        except Exception:
            self._model = None

    def get_sentence_embedding_dimension(self):
        return 384

    def encode(self, text: str, normalize_embeddings: bool = True):
        if self._model is not None:
            return self._model.encode(text, normalize_embeddings=normalize_embeddings)
        import numpy as np
        vec = np.zeros(384, dtype=np.float32)
        tokens = re.findall(r"[\w]+", text.lower())
        for token in tokens:
            h = int(hashlib.md5(token.encode("utf-8")).hexdigest()[:8], 16)
            idx = h % 384
            sign = 1.0 if (h & 0x10000000) else -1.0
            vec[idx] += sign
            for i in range(len(token) - 2):
                tri = token[i:i+3]
                th = int(hashlib.sha256(tri.encode("utf-8")).hexdigest()[:8], 16)
                tidx = th % 384
                tsign = 1.0 if (th & 0x10000000) else -1.0
                vec[tidx] += 0.5 * tsign
        norm = float(np.linalg.norm(vec))
        if norm > 1e-12:
            vec = vec / norm
        else:
            vec[0] = 1.0
        return vec


def build_knowledge_database(wiki_ai_dir: str, alexandrie_json_path: str,
                             alexandrie_api: str, db_output: str, compressed_output: str,
                             *, version_code=1, release_tag="v1.0.0",
                             embedding_mode="lexical", alexandrie_user_id=None,
                             alexandrie_cookie=None):
    """Bangun rilis lengkap sebelum mengganti artefak aktif. Kembalikan manifest."""
    if not isinstance(version_code, int) or isinstance(version_code, bool) or version_code < 1:
        raise ValueError("version_code harus bilangan positif")
    if not release_tag or embedding_mode not in ("lexical", "semantic"):
        raise ValueError("release_tag wajib; embedding_mode harus lexical atau semantic")
    import zstandard as zstd  # Wajib: berkas .zst tidak boleh berisi gzip.
    model_name = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
    embedder = None
    if embedding_mode == "semantic":
        embedder = SemanticEmbedder(model_name)
    records = load_alexandrie_records(alexandrie_json_path, alexandrie_api,
                                     alexandrie_user_id, alexandrie_cookie)
    db_path, compressed_path = Path(db_output), Path(compressed_output)
    if db_path.resolve() == compressed_path.resolve():
        raise ValueError("Output DB dan Zstandard harus berbeda")
    manifest_path = compressed_path.parent / "release_manifest.json"
    staged_db = _temporary(db_path)
    staged_zst = _temporary(compressed_path)
    staged_manifest = _temporary(manifest_path)
    conn = None
    try:
        conn = sqlite3.connect(staged_db)
        conn.executescript("""
            PRAGMA foreign_keys=ON;
            CREATE TABLE articles (
                id TEXT PRIMARY KEY, title TEXT NOT NULL, category TEXT NOT NULL,
                content_type TEXT NOT NULL, provenance TEXT NOT NULL,
                source_origin TEXT NOT NULL, author_or_speaker TEXT, summary TEXT,
                content TEXT NOT NULL, metadata_json TEXT);
            CREATE TABLE article_chunks (
                id INTEGER PRIMARY KEY AUTOINCREMENT, article_id TEXT NOT NULL,
                chunk_index INTEGER NOT NULL, chunk_content TEXT NOT NULL,
                provenance TEXT NOT NULL, embedding F32_BLOB(384),
                FOREIGN KEY(article_id) REFERENCES articles(id));
            CREATE INDEX chunks_article ON article_chunks(article_id);
            CREATE VIRTUAL TABLE articles_fts USING fts5(
                title, content, content='articles', content_rowid='rowid');
        """)
        try:
            conn.execute("CREATE INDEX IF NOT EXISTS chunks_vector_idx ON article_chunks(libsql_vector_idx(embedding, 'metric=cosine'));")
        except sqlite3.OperationalError:
            # Lewati jika fungsi libsql_vector_idx belum tersedia di runtime sqlite3 host.
            pass
        stats = {}
        total_chunks = 0
        def insert_article(aid, title, category, ctype, provenance, origin, author, summary, body, metadata):
            nonlocal total_chunks
            conn.execute("INSERT INTO articles VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                         (aid, title, category, ctype, provenance, origin, author, summary, body,
                          json.dumps(metadata, ensure_ascii=False) if metadata is not None else None))
            for index, chunk in enumerate(chunk_markdown(body)):
                embedding = None
                if embedder is not None:
                    vector = embedder.encode(chunk, normalize_embeddings=True)
                    import numpy as np
                    vector = np.asarray(vector, dtype="<f4")
                    if vector.shape != (384,) or not np.isfinite(vector).all() or not np.any(vector):
                        raise ValueError(f"Embedding tidak valid untuk {aid} chunk {index}")
                    embedding = vector.tobytes()
                    if len(embedding) != 1536:
                        raise ValueError(f"Ukuran F32_BLOB(384) harus tepat 1536 byte, didapat {len(embedding)}")
                conn.execute("INSERT INTO article_chunks(article_id, chunk_index, chunk_content, provenance, embedding) VALUES (?, ?, ?, ?, ?)",
                             (aid, index, chunk, provenance, embedding))
                total_chunks += 1
            stats[provenance] = stats.get(provenance, 0) + 1
        if wiki_ai_dir:
            if not Path(wiki_ai_dir).is_dir():
                raise FileNotFoundError(f"Direktori Wiki tidak ditemukan: {wiki_ai_dir}")
            for filename in sorted(glob.glob(os.path.join(wiki_ai_dir, "**/*.md"), recursive=True)):
                rel = os.path.relpath(filename, wiki_ai_dir)
                body = Path(filename).read_text(encoding="utf-8")
                if not body.strip():
                    continue
                heading = re.search(r"^#\s+(.+)$", body, re.MULTILINE)
                title = heading.group(1).strip() if heading else Path(filename).stem
                insert_article("ai_" + hashlib.sha256(rel.encode()).hexdigest()[:14], title,
                               os.path.dirname(rel) or "Khazanah Parenting", "article", "ai_assisted",
                               "wiki_pkn", "Wiki AI Synthesis", body[:150].replace("\n", " "), body,
                               {"source_path": rel})
        for record in records:
            key = str(record.get("key") or record.get("id") or "")
            body = record.get("body", record.get("content", ""))
            if not key or not isinstance(body, str) or not body.strip():
                raise ValueError("Dokumen Alexandrie wajib memiliki key/id dan body/content nonkosong")
            category = record.get("category") or "Kurasi Pakar"
            # Simpan seluruh atribut ingestion, bukan hanya key dan kategori.
            metadata = {k: v for k, v in record.items() if k not in ("body", "content")}
            supplied_meta = record.get("metadata", record.get("metadata_json"))
            if isinstance(supplied_meta, str):
                supplied_meta = json.loads(supplied_meta)
            if isinstance(supplied_meta, dict):
                metadata.update(supplied_meta)
            insert_article("alex_" + hashlib.sha256(key.encode()).hexdigest()[:12],
                           record.get("title") or key.replace("_", " ").title(), category,
                           _content_type(record), record.get("provenance") or "expert_verified",
                           record.get("source_origin") or record.get("source") or "alexandrie",
                           record.get("author_or_speaker") or record.get("author") or "Tim Asatidz & Pakar PKN",
                           record.get("summary") or body[:150].replace("\n", " "), body, metadata)
        if not stats:
            raise ValueError("Tidak ada artikel untuk dikompilasi")
        conn.execute("INSERT INTO articles_fts(articles_fts) VALUES ('rebuild')")
        conn.commit()
        conn.execute("VACUUM")
        conn.close()
        conn = None
        with open(staged_db, "rb") as source, open(staged_zst, "wb") as destination:
            zstd.ZstdCompressor(level=19, write_checksum=True).copy_stream(source, destination)
        checksum = _sha256(staged_zst)
        # Nama immutable membuat pembaca manifest lama tetap memperoleh payload lama.
        asset_path = compressed_path.with_name(f"{compressed_path.stem}-{checksum}.zst")
        manifest = {
            "version_code": version_code, "release_tag": release_tag, "file_name": asset_path.name,
            "uncompressed_bytes": staged_db.stat().st_size, "compressed_bytes": staged_zst.stat().st_size,
            "sha256": checksum, "total_articles": sum(stats.values()), "total_chunks": total_chunks,
            "provenance_stats": {"ai_assisted": stats.get("ai_assisted", 0),
                                 "expert_verified": stats.get("expert_verified", 0), **stats},
            "embedding_mode": embedding_mode, "embedding_model": model_name if embedder else None,
            "embedding_dimensions": 384 if embedder else None,
        }
        staged_manifest.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        # Fsync setiap berkas sebelum publikasi; manifest adalah commit pointer terakhir.
        for staged in (staged_db, staged_zst, staged_manifest):
            with open(staged, "rb") as file:
                os.fsync(file.fileno())
        if not asset_path.exists():
            # Hard link mempublikasikan payload immutable tanpa salinan byte.
            os.link(staged_zst, asset_path)
        elif _sha256(asset_path) != checksum:
            raise ValueError("Payload checksum-named rusak")
        os.replace(staged_zst, compressed_path)
        os.replace(staged_db, db_path)
        os.replace(staged_manifest, manifest_path)
        print(json.dumps(manifest, ensure_ascii=False, indent=2))
        return manifest
    finally:
        if conn is not None:
            conn.close()
        for staged in (staged_db, staged_zst, staged_manifest):
            staged.unlink(missing_ok=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Build SQLite knowledge dan rilis OTA Zstandard")
    parser.add_argument("--wiki-ai", default="/home/abuhafi/Project/wiki-pkn/content")
    parser.add_argument("--alexandrie-json", default="prototype/backend v2/data/alexandrie_curated.json")
    parser.add_argument("--alexandrie-api", default=None, help="URL /api (node asli) atau ekspor JSON eksplisit")
    parser.add_argument("--alexandrie-user-id", default=os.environ.get("ALEXANDRIE_USER_ID"))
    parser.add_argument("--alexandrie-cookie", default=os.environ.get("ALEXANDRIE_COOKIE"), help="Cookie login; disarankan env agar tidak masuk riwayat shell")
    parser.add_argument("--db-out", default="prototype/backend v2/knowledge_build.db")
    parser.add_argument("--zst-out", default="prototype/backend v2/knowledge_v1.db.zst")
    parser.add_argument("--version-code", type=int, default=1)
    parser.add_argument("--release-tag", default="v1.0.0")
    parser.add_argument("--embedding-mode", choices=("lexical", "semantic"), default="lexical")
    args = parser.parse_args()
    build_knowledge_database(args.wiki_ai, args.alexandrie_json, args.alexandrie_api,
                             args.db_out, args.zst_out, version_code=args.version_code,
                             release_tag=args.release_tag, embedding_mode=args.embedding_mode,
                             alexandrie_user_id=args.alexandrie_user_id,
                             alexandrie_cookie=args.alexandrie_cookie)
