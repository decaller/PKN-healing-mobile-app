#!/usr/bin/env python3
"""
PKN Knowledge Base - Model Context Protocol (MCP) Server
Menyediakan akses AI (Claude Desktop, Cursor IDE, Antigravity) ke knowledge_build.db
tanpa memerlukan database terpisah (Read-Only direct SQLite query).
"""

import os
import sys
import json
import sqlite3
import argparse
import hashlib
import re
from pathlib import Path
import numpy as np


def _encode_text(text: str) -> np.ndarray:
    """Encode query ke embedding 384-dimensi L2 normalized."""
    try:
        from sentence_transformers import SentenceTransformer
        model = SentenceTransformer("sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2")
        return model.encode(text, normalize_embeddings=True)
    except Exception:
        pass
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

# -----------------------------------------------------------------------------
# Konfigurasi Database Read-Only
# -----------------------------------------------------------------------------
DEFAULT_DB = os.path.abspath(os.path.join(os.path.dirname(__file__), "../knowledge_build.db"))

def get_db_connection(db_path: str):
    # Koneksi baru setiap tool melihat penggantian atomik database terbaru.
    conn = sqlite3.connect(Path(db_path).resolve().as_uri() + "?mode=ro", uri=True)
    conn.execute("PRAGMA query_only=ON")
    conn.row_factory = sqlite3.Row
    return conn

# -----------------------------------------------------------------------------
# Definisi Tools MCP
# -----------------------------------------------------------------------------
TOOLS = [
    {
        "name": "search_knowledge",
        "description": "Cari materi parenting nabawiyah, adab, fitrah, dalil, dan SOP krisis di PKN Knowledge Base menggunakan Full-Text Search (FTS5) atau LibSQL Vector Search.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "query": {
                    "type": "string",
                    "description": "Kata kunci pencarian (misal: 'thuma\'ninah', 'tantrum', 'maghrib', 'adab makan')"
                },
                "search_mode": {
                    "type": "string",
                    "enum": ["lexical", "semantic", "hybrid"],
                    "default": "lexical",
                    "description": "Mode pencarian: 'lexical' (FTS5 BM25), 'semantic' (LibSQL Vector Cosine), atau 'hybrid' (Reciprocal Rank Fusion FTS5 + Vector)"
                },
                "provenance": {
                    "type": "string",
                    "enum": ["all", "expert_verified", "ai_assisted"],
                    "default": "all",
                    "description": "Saring berdasarkan kredibilitas sumber: 'all', 'expert_verified' (murni kurasi pakar/Alexandrie), atau 'ai_assisted' (Wiki-AI)"
                },
                "content_type": {
                    "type": "string",
                    "enum": ["all", "article", "doa", "cerita_rpg", "buku", "event"],
                    "default": "all",
                    "description": "Saring berdasarkan tipe konten"
                },
                "limit": {
                    "type": "integer",
                    "default": 5,
                    "description": "Jumlah hasil maksimal (default: 5)"
                }
            },
            "required": ["query"]
        }
    },
    {
        "name": "get_article",
        "description": "Ambil naskah lengkap artikel PKN berdasarkan ID dokumen.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "article_id": {
                    "type": "string",
                    "description": "ID unik artikel (misal: 'alex_9876...', 'ai_1234...')"
                }
            },
            "required": ["article_id"]
        }
    },
    {
        "name": "get_doa_penenang",
        "description": "Ambil doa penenang jiwa terverifikasi pakar (teks Arab berharakat, terjemahan, dan takhrij derajat hadits dari Hisnul Muslim).",
        "inputSchema": {
            "type": "object",
            "properties": {
                "topik": {
                    "type": "string",
                    "description": "Topik emosi atau kondisi (misal: 'marah', 'gelisah', 'kesempitan', 'anak')"
                }
            },
            "required": ["topik"]
        }
    },
    {
        "name": "get_skenario_adab",
        "description": "Ambil skenario interaktif living RPG pengasuhan adab (opsi keputusan orang tua dan panduan adab).",
        "inputSchema": {
            "type": "object",
            "properties": {
                "kata_kunci": {
                    "type": "string",
                    "description": "Kata kunci skenario (misal: 'pintu maghrib', 'meja makan', 'shalat')"
                }
            },
            "required": ["kata_kunci"]
        }
    },
    {
        "name": "get_agenda_event",
        "description": "Ambil agenda daurah parenting, webinar, dan majelis akbar resmi terkini.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "limit": {
                    "type": "integer",
                    "default": 5,
                    "description": "Jumlah agenda yang ditampilkan"
                }
            }
        }
    },
    {
        "name": "get_similar_articles",
        "description": "Cari artikel yang serupa/relevan dengan artikel acuan menggunakan kemiripan vektor LibSQL embeddings.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "article_id": {
                    "type": "string",
                    "description": "ID unik artikel acuan"
                },
                "limit": {
                    "type": "integer",
                    "default": 5,
                    "description": "Jumlah rekomendasi maksimal"
                }
            },
            "required": ["article_id"]
        }
    }
]
for tool in TOOLS:
    tool["annotations"] = {"readOnlyHint": True, "destructiveHint": False,
                           "idempotentHint": True, "openWorldHint": False}
    schema = tool["inputSchema"]
    schema["additionalProperties"] = False
    for definition in schema["properties"].values():
        if definition.get("type") == "string" and "enum" not in definition:
            definition["minLength"] = 1
        if definition.get("type") == "integer":
            definition.update({"minimum": 1, "maximum": 100})


# -----------------------------------------------------------------------------
# Eksekutor Logika Tools
# -----------------------------------------------------------------------------
def _limit(args):
    value = args.get("limit", 5)
    if not isinstance(value, int) or isinstance(value, bool) or not 1 <= value <= 100:
        raise ValueError("limit harus integer 1–100")
    return value


def _query(text):
    if not isinstance(text, str) or not text.strip():
        raise ValueError("Kata kunci wajib berupa teks nonkosong")
    # Kata biasa, bukan ekspresi FTS: apostrof/hyphen tidak menjadi operator SQL.
    words = re.findall(r"[^\W_]+", text, re.UNICODE)
    return " AND ".join('"' + word + '"' for word in words)


def _article(row):
    result = dict(row)
    result.pop("embedding", None)
    result["metadata"] = json.loads(result.pop("metadata_json")) if result.get("metadata_json") else None
    if "author_or_speaker" in result:
        result["author"] = result["author_or_speaker"]
    return result


def execute_tool(name: str, args: dict, db_path: str) -> dict:
    conn = None
    try:
        if not isinstance(args, dict):
            raise ValueError("arguments harus object")
        if name not in {tool["name"] for tool in TOOLS}:
            raise ValueError(f"Tool '{name}' tidak dikenal")
        conn = get_db_connection(db_path)
        if name == "get_article":
            article_id = args.get("article_id")
            if not isinstance(article_id, str) or not article_id:
                raise ValueError("article_id wajib")
            row = conn.execute("SELECT * FROM articles WHERE id = ?", (article_id,)).fetchone()
            return _article(row) if row else {"error": f"Artikel dengan ID '{article_id}' tidak ditemukan."}
        if name == "get_agenda_event":
            rows = conn.execute("SELECT * FROM articles WHERE content_type='event' ORDER BY id LIMIT ?",
                                (_limit(args),)).fetchall()
            return {"events": [_article(row) for row in rows]}
        if name == "get_similar_articles":
            article_id = args.get("article_id")
            if not isinstance(article_id, str) or not article_id:
                raise ValueError("article_id wajib")
            limit = _limit(args)
            chunks = conn.execute("SELECT embedding FROM article_chunks WHERE article_id=? AND embedding IS NOT NULL", (article_id,)).fetchall()
            if not chunks or not chunks[0][0]:
                return {"similar_articles": [], "message": f"Embedding artikel '{article_id}' belum tersedia"}
            target_vec = np.frombuffer(chunks[0][0], dtype="<f4")
            other_rows = conn.execute("""
                SELECT c.article_id, c.embedding, a.*
                FROM article_chunks c
                JOIN articles a ON a.id = c.article_id
                WHERE c.article_id != ? AND c.embedding IS NOT NULL
            """, (article_id,)).fetchall()
            scores = {}
            articles_map = {}
            for row in other_rows:
                aid = row["article_id"]
                vec = np.frombuffer(row["embedding"], dtype="<f4")
                sim = float(np.dot(target_vec, vec))
                if aid not in scores or sim > scores[aid]:
                    scores[aid] = sim
                    art = _article(row)
                    art["similarity_score"] = round(sim, 4)
                    articles_map[aid] = art
            ranked = sorted(articles_map.values(), key=lambda x: x["similarity_score"], reverse=True)[:limit]
            return {"similar_articles": ranked}
        if name == "search_knowledge":
            raw_query = args.get("query", "")
            query = _query(raw_query)
            search_mode = args.get("search_mode", "lexical")
            provenance = args.get("provenance", "all")
            content_type = args.get("content_type", "all")
            if provenance not in ("all", "expert_verified", "ai_assisted"):
                raise ValueError("provenance tidak dikenal")
            if content_type not in ("all", "article", "doa", "cerita_rpg", "buku", "event"):
                raise ValueError("content_type tidak dikenal")
            if search_mode not in ("lexical", "semantic", "hybrid"):
                raise ValueError("search_mode tidak dikenal")
            limit = _limit(args)
            output_key = "results"

            if search_mode == "lexical" or not raw_query.strip():
                if not query:
                    results = []
                else:
                    sql = """SELECT a.* FROM articles_fts
                             JOIN articles a ON a.rowid=articles_fts.rowid
                             WHERE articles_fts MATCH ?"""
                    params = [query]
                    if provenance != "all":
                        sql += " AND a.provenance=?"
                        params.append(provenance)
                    if content_type != "all":
                        sql += " AND a.content_type=?"
                        params.append(content_type)
                    sql += " ORDER BY bm25(articles_fts), a.id LIMIT ?"
                    params.append(limit)
                    results = [_article(row) for row in conn.execute(sql, params).fetchall()]
            elif search_mode == "semantic":
                q_vec = _encode_text(raw_query)
                sql = """SELECT c.article_id, c.embedding, a.*
                         FROM article_chunks c
                         JOIN articles a ON a.id = c.article_id
                         WHERE c.embedding IS NOT NULL"""
                params = []
                if provenance != "all":
                    sql += " AND a.provenance=?"
                    params.append(provenance)
                if content_type != "all":
                    sql += " AND a.content_type=?"
                    params.append(content_type)
                rows = conn.execute(sql, params).fetchall()
                if not rows:
                    sql = """SELECT a.* FROM articles_fts
                             JOIN articles a ON a.rowid=articles_fts.rowid
                             WHERE articles_fts MATCH ?"""
                    params = [query]
                    if provenance != "all":
                        sql += " AND a.provenance=?"
                        params.append(provenance)
                    if content_type != "all":
                        sql += " AND a.content_type=?"
                        params.append(content_type)
                    sql += " ORDER BY bm25(articles_fts), a.id LIMIT ?"
                    params.append(limit)
                    results = [_article(row) for row in conn.execute(sql, params).fetchall()]
                else:
                    scores = {}
                    articles_map = {}
                    for row in rows:
                        aid = row["article_id"]
                        vec = np.frombuffer(row["embedding"], dtype="<f4")
                        sim = float(np.dot(q_vec, vec))
                        if aid not in scores or sim > scores[aid]:
                            scores[aid] = sim
                            art = _article(row)
                            art["similarity_score"] = round(sim, 4)
                            articles_map[aid] = art
                    results = sorted(articles_map.values(), key=lambda x: x["similarity_score"], reverse=True)[:limit]
            else:
                fts_sql = """SELECT a.id, a.* FROM articles_fts
                             JOIN articles a ON a.rowid=articles_fts.rowid
                             WHERE articles_fts MATCH ?"""
                fts_params = [query]
                if provenance != "all":
                    fts_sql += " AND a.provenance=?"
                    fts_params.append(provenance)
                if content_type != "all":
                    fts_sql += " AND a.content_type=?"
                    fts_params.append(content_type)
                fts_sql += " ORDER BY bm25(articles_fts), a.id LIMIT 50"
                fts_rows = conn.execute(fts_sql, fts_params).fetchall() if query else []
                fts_ranks = {row["id"]: rank for rank, row in enumerate(fts_rows)}
                articles_map = {row["id"]: _article(row) for row in fts_rows}

                q_vec = _encode_text(raw_query)
                sem_sql = """SELECT c.article_id, c.embedding, a.*
                             FROM article_chunks c
                             JOIN articles a ON a.id = c.article_id
                             WHERE c.embedding IS NOT NULL"""
                sem_params = []
                if provenance != "all":
                    sem_sql += " AND a.provenance=?"
                    sem_params.append(provenance)
                if content_type != "all":
                    sem_sql += " AND a.content_type=?"
                    sem_params.append(content_type)
                sem_rows = conn.execute(sem_sql, sem_params).fetchall()
                sem_scores = {}
                for row in sem_rows:
                    aid = row["article_id"]
                    vec = np.frombuffer(row["embedding"], dtype="<f4")
                    sim = float(np.dot(q_vec, vec))
                    if aid not in sem_scores or sim > sem_scores[aid]:
                        sem_scores[aid] = sim
                        if aid not in articles_map:
                            articles_map[aid] = _article(row)
                sem_ranked_ids = sorted(sem_scores.keys(), key=lambda x: sem_scores[x], reverse=True)[:50]
                sem_ranks = {aid: rank for rank, aid in enumerate(sem_ranked_ids)}

                all_candidate_ids = set(fts_ranks.keys()) | set(sem_ranks.keys())
                rrf_scores = {}
                k = 60.0
                for aid in all_candidate_ids:
                    score = 0.0
                    if aid in fts_ranks:
                        score += 1.0 / (k + fts_ranks[aid])
                    if aid in sem_ranks:
                        score += 1.0 / (k + sem_ranks[aid])
                    rrf_scores[aid] = score

                sorted_ids = sorted(all_candidate_ids, key=lambda x: rrf_scores[x], reverse=True)[:limit]
                results = []
                for aid in sorted_ids:
                    art = articles_map.get(aid)
                    if art is not None:
                        art["rrf_score"] = round(rrf_scores[aid], 6)
                        results.append(art)
        elif name == "get_doa_penenang":
            query = _query(args.get("topik"))
            provenance, content_type, limit, output_key = "expert_verified", "doa", 3, "doa_list"
            if not query:
                results = []
            else:
                sql = """SELECT a.* FROM articles_fts
                         JOIN articles a ON a.rowid=articles_fts.rowid
                         WHERE articles_fts MATCH ? AND a.provenance=? AND a.content_type=?
                         ORDER BY bm25(articles_fts), a.id LIMIT ?"""
                results = [_article(row) for row in conn.execute(sql, (query, provenance, content_type, limit)).fetchall()]
        else:
            query = _query(args.get("kata_kunci"))
            provenance, content_type, limit, output_key = "expert_verified", "cerita_rpg", 3, "skenario_list"
            if not query:
                results = []
            else:
                sql = """SELECT a.* FROM articles_fts
                         JOIN articles a ON a.rowid=articles_fts.rowid
                         WHERE articles_fts MATCH ? AND a.provenance=? AND a.content_type=?
                         ORDER BY bm25(articles_fts), a.id LIMIT ?"""
                results = [_article(row) for row in conn.execute(sql, (query, provenance, content_type, limit)).fetchall()]
        result = {output_key: results}
        if name == "search_knowledge":
            result["total_found"] = len(results)
        return result
    except Exception as error:
        return {"error": str(error)}
    finally:
        if conn is not None:
            conn.close()

# -----------------------------------------------------------------------------
# JSON-RPC 2.0 Stdio Transport (Standar Resmi MCP)
# -----------------------------------------------------------------------------
def run_stdio_server(db_path: str):
    """MCP stdio: satu pesan JSON-RPC per baris, tanpa log di stdout."""
    sys.stderr.write(f"[PKN MCP] Database baca-saja: {db_path}\n")
    for line in sys.stdin:
        if not line.strip():
            continue
        request_id = None
        try:
            try:
                request = json.loads(line)
            except json.JSONDecodeError:
                response = {"jsonrpc": "2.0", "id": None,
                            "error": {"code": -32700, "message": "Parse error"}}
            else:
                if not isinstance(request, dict) or request.get("jsonrpc") != "2.0" or not isinstance(request.get("method"), str):
                    response = {"jsonrpc": "2.0", "id": None,
                                "error": {"code": -32600, "message": "Invalid Request"}}
                else:
                    request_id = request.get("id")
                    # Semua notifikasi JSON-RPC tidak menerima balasan.
                    if "id" not in request:
                        continue
                    method = request["method"]
                    params = request.get("params", {})
                    if not isinstance(params, dict):
                        raise ValueError("params harus object")
                    if method == "initialize":
                        requested = params.get("protocolVersion")
                        version = requested if requested in ("2024-11-05", "2025-03-26", "2025-06-18") else "2024-11-05"
                        result = {"protocolVersion": version,
                                  "serverInfo": {"name": "pkn-knowledge-mcp", "version": "2.0.0"},
                                  "capabilities": {"tools": {}}}
                    elif method == "tools/list":
                        result = {"tools": TOOLS}
                    elif method == "tools/call":
                        data = execute_tool(params.get("name"), params.get("arguments", {}), db_path)
                        result = {"content": [{"type": "text", "text": json.dumps(data, ensure_ascii=False)}],
                                  "structuredContent": data, "isError": "error" in data}
                    elif method == "ping":
                        result = {}
                    else:
                        response = {"jsonrpc": "2.0", "id": request_id,
                                    "error": {"code": -32601, "message": f"Method '{method}' not found"}}
                        sys.stdout.write(json.dumps(response) + "\n")
                        sys.stdout.flush()
                        continue
                    response = {"jsonrpc": "2.0", "id": request_id, "result": result}
        except (TypeError, ValueError) as error:
            response = {"jsonrpc": "2.0", "id": request_id,
                        "error": {"code": -32602, "message": str(error)}}
        sys.stdout.write(json.dumps(response, ensure_ascii=False) + "\n")
        sys.stdout.flush()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PKN Knowledge Base MCP Server")
    parser.add_argument("--db", default=DEFAULT_DB, help="Path ke knowledge_build.db")
    args = parser.parse_args()

    if not os.path.exists(args.db):
        sys.stderr.write(f"[Error] Database file {args.db} tidak ditemukan! Jalankan build_knowledge_db.py terlebih dahulu.\n")
        sys.exit(1)

    run_stdio_server(args.db)
