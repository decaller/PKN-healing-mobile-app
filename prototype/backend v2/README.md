# PKN Backend v2 — Dual-Database Engine, Directus Headless, & Alexandrie Hub

Backend v2 adalah arsitektur backend komprehensif untuk ekosistem **PKN Healing Mobile App (Flutter)**. Arsitektur ini menggabungkan:

1. **Dual-Source Knowledge Ingestion (`knowledge.db`):**
   * **Sumber 1 (Wiki AI-Generated):** Korpus artikel Markdown di `/home/abuhafi/Project/wiki-pkn/` atau `wikipkn.insanmustaqbal.or.id` (`provenance: 'ai_assisted'`).
   * **Sumber 2 (Alexandrie Non-AI & Hub Publik):** Wiki tulisan murni pakar yang memuat Doa Penenang, Cerita/Skenario Adab (RPG), Pustaka Buku, dan Event Publik (`provenance: 'expert_verified'`).
   * **Ingestion Worker:** Skrip pembantu yang mengekstrak event dan buku dari `karakternabawiyah.com` (WordPress REST API) dan menyimpannya secara terstruktur ke Alexandrie.
   * **Pre-compiled SQLite OTA Bundle:** Hasil gabungan diindeks dengan FTS5 dan vektor embedding 384-dimensi, lalu dikompresi dengan Zstandard (`.db.zst`) untuk distribusi luring ke ponsel.

2. **Directus Headless CMS & PostgreSQL 16 (Port 8055):**
   * Mengelola autentikasi mobile (Google / Apple OAuth via OpenID Connect).
   * Menerima sinkronisasi data personal pengguna (bookmark dan catatan) via pola Outbox ringan.
   * Mengontrol rilis berkas pembaruan Knowledge Base (`knowledge_releases`).

3. **Pola Outbox Ringan (Drift Client Flutter):**
   * Sinkronisasi data pengguna menggunakan pola *dirty flag* (`synced`, `pending`, `deleted`) tanpa kerumitan engine database terdistribusi.

4. **Zero Cloud Leak (Amanah):**
   * Inferensi AI curhat, muhasabah, dan skor observasi anak dijalankan 100% lokal on-device.

5. **Model Context Protocol (MCP) Interface (Zero Extra DB):**
   * Menyediakan antarmuka MCP standar untuk agen AI (Claude Desktop, Cursor, Antigravity) langsung membaca berkas `knowledge.db` secara paralel (read-only) tanpa memerlukan database terpisah.

---

## 📁 Struktur Berkas

```
prototype/backend v2/
├── README.md                                  # Ringkasan cepat & petunjuk pengoperasian
├── RENCANA_IMPLEMENTASI_PROTOTIPE_BERTAHAP.md # Rencana kerja 6 fase bertahap (Server & Client)
├── DOKUMENTASI_ARSITEKTUR_DUAL_DATABASE.md    # Dokumen master spesifikasi arsitektur komprehensif (termasuk Bab 7: MCP & Bab 8: LibSQL)
├── compose.yaml                               # Kontainer Docker terpadu (Postgres 16, Directus, Alexandrie)
├── .env.example                               # Contoh konfigurasi environment
├── schema.sql                                 # Inisialisasi skema relasional PostgreSQL
├── build_knowledge_db.py                      # Pipeline kompilasi offline multi-sumber ke LibSQL/SQLite + Zstandard
├── server.py                                  # Server API distribusi OTA & Sinkronisasi Outbox User
├── ingestion_worker.py                        # Ingestion worker sinkronisasi WordPress ke data kurasi
├── mcp/                                       # Implementasi MCP Server (JSON-RPC stdio: FTS5, Vector, Hybrid RRF)
└── client_examples/                           # Service Dart/Flutter:
    ├── knowledge_database_service.dart        # Pembacaan SQLite FTS5 luring
    ├── libsql_vector_search_service.dart      # LibSQL Vector (DiskANN) + Hybrid Search (RRF)
    ├── on_device_embedder_service.dart        # Inferensi lokal model ONNX INT8 di perangkat (Zero Cloud Leak)
    └── drift_schema_outbox_example.dart       # Skema Drift pola Outbox
```

---

## 🚀 Panduan Memulai

### 1. Menjalankan Server Backend Terpadu (Directus, Postgres, Alexandrie)

```bash
cd "prototype/backend v2"
cp .env.example .env
docker compose up -d
```

* **Directus CMS (User Sync & Auth):** `http://localhost:8055`
* **Alexandrie Wiki (Non-AI Hub):** `http://localhost:8201`
* Skema database PostgreSQL di `schema.sql` akan dieksekusi secara otomatis pada inisialisasi awal.

### 2. Mengompilasi Knowledge Base Terpadu (Wiki-AI + Alexandrie)

Jalankan compiler untuk menggabungkan Markdown Wiki-AI dan Alexandrie menjadi database biner Zstandard:

```bash
cd "prototype/backend v2"
python3 build_knowledge_db.py \
  --wiki-ai /home/abuhafi/Project/wiki-pkn \
  --alexandrie-json data/alexandrie_curated.json \
  --db-out knowledge_build.db \
  --zst-out knowledge_v3.db.zst \
  --embedding-mode lexical --version-code 3 --release-tag v3.0.0
```

Alias `knowledge_v3.db.zst` dan aset immutable berakhiran SHA-256 dihasilkan. Manifest menunjuk aset immutable; naikkan `version_code` pada rilis berikutnya.

Mode `lexical` menggunakan FTS5 tanpa vektor buatan. Mode semantik memerlukan model embedding nyata; instalasi ringan tidak mengklaim pencarian semantik.

### 3. Backend ringan tanpa Docker

Instal dependensi dari folder ini: `python3 -m pip install -r requirements.txt`.

Sinkronkan sumber publik: `python3 ingestion_worker.py --output data/alexandrie_curated.json`. Worker mempertahankan kurasi lain dan memperbarui record WordPress dengan key stabil. Halaman yang hilang dari sumber tidak otomatis dihapus. Label `expert_verified` mengikuti klasifikasi sumber non-AI; bukan bukti audit editorial baru.

Compiler menerima snapshot JSON lokal. Untuk CMS Alexandrie nyata, gunakan `--alexandrie-api URL/api --alexandrie-user-id USER_ID` dengan cookie login pada `ALEXANDRIE_COOKIE`. API node Alexandrie berbeda dari `/api/documents` yang disebut dalam cetak biru. URL ekspor JSON eksplisit juga dapat diberikan sebagai sumber API.

Buat berkas autentikasi privat berformat JSON dengan pemetaan token acak ke ID akun, misalnya `{"TOKEN_ACAK_PANJANG":"akun-1"}`. Jangan masukkan token nyata ke repositori. Jalankan:

```bash
python3 server.py --host 127.0.0.1 --port 8080 --data-dir . --auth-file /path/private/auth.json
python3 mcp/pkn_knowledge_mcp.py --db knowledge_build.db
python3 test_backend_v2.py
```

Endpoint publik: `GET /health`, `GET /api/knowledge/release`, `GET /api/knowledge/download`. Manifest memuat `file_name`, `version_code`, `release_tag`, `sha256`, `compressed_bytes`, dan `uncompressed_bytes`. Verifikasi SHA-256 paket unduhan sebelum ekstraksi Zstandard.

Gunakan `download_url` persis dari manifest: parameter `file` mengunci checksum aset sehingga rilis baru tidak mengganti payload di tengah unduhan. Aset rilis lama dipertahankan.

Sync memerlukan header `Authorization: Bearer TOKEN`. `POST /api/user/sync` menerima `{ "cursor": 0, "outbox": [...] }`; `GET /api/user/sync?cursor=0` menarik delta. Setiap mutasi memiliki `mutation_id`, `collection` (`notes` atau `bookmarks`), `id`, `article_id`, `client_updated_at` ISO8601 berzona waktu, dan `is_deleted`; `notes` juga memerlukan `content`. Respons berisi `acknowledged`, `changes`, dan `cursor`. Ulangi mutasi yang sama bila koneksi terputus; hapus outbox hanya setelah acknowledgement. Simpan cursor respons untuk pull berikutnya. Konflik timestamp atau ID mutasi dengan payload berbeda menghasilkan HTTP 409; batch dibatalkan seluruhnya. Penghapusan dikirim sebagai tombstone, bukan penghapusan fisik.

Data akun disimpan terpisah di `user_sync.db`. Identitas berasal dari token, bukan payload. Chat, skor anak, dan koleksi sensitif tidak diterima. Token statis merupakan mekanisme prototipe, bukan OAuth. Server HTTP ini harus tetap lokal; akses jaringan produksi memerlukan TLS dan autentikasi deployment yang sesuai.

MCP stdio menyediakan 6 tools (`search_knowledge`, `get_article`, `get_doa_penenang`, `get_skenario_adab`, `get_agenda_event`, dan `get_similar_articles`) dengan koneksi SQLite/LibSQL read-only.
- `search_knowledge` mendukung mode `lexical` (FTS5 BM25), `semantic` (Cosine distance pada LibSQL `F32_BLOB(384)`), dan `hybrid` (Reciprocal Rank Fusion - RRF k=60).
- `get_similar_articles` menghitung artikel terdekat berdasarkan kemiripan vektor antar-dokumen.

### 4. Hasil verifikasi — 12 Oktober 2026

- **Ingestion situs nyata:** 70 metadata halaman dibaca; 43 event dan 6 buku ditambahkan. Sebanyak 49 seed dipertahankan, total kurasi 98 record.
- **Suite Pengujian Acceptance (`test_backend_v2.py`):** **7 pengujian lulus 100% tanpa error**:
  1. `test_compiler_sql_compression_api_and_failed_publication`: OK
  2. `test_libsql_vector_embeddings_and_hybrid_search`: OK (Validasi byte-buffer 1536 byte `F32_BLOB(384)`, decoding L2-norm float32, cosine distance, semantic & hybrid search MCP, dan get_similar_articles)
  3. `test_mcp_five_tools_and_live_release_cutover`: OK
  4. `test_paginated_ingestion_is_stable_and_transactional`: OK
  5. `test_rest_detail_failure_uses_public_elementor_and_preserves_on_double_failure`: OK
  6. `test_sync_lifecycle_conflicts_atomicity_isolation_and_restart`: OK
- **Rilis Vektor `v4.0.0`:** 741 artikel, 10.806 chunk ber-embedding 384-dimensi. Database SQLite 59.170.816 byte; paket Zstandard 7.698.726 byte (7.69 MB, kompresi 87%, aman di bawah 25 MB).
- **Client Flutter:** Contoh implementasi [`libsql_vector_search_service.dart`](./client_examples/libsql_vector_search_service.dart) (DiskANN `vector_top_k` dan Hybrid RRF) dan [`on_device_embedder_service.dart`](./client_examples/on_device_embedder_service.dart) (ONNX Runtime Mobile lokal 100% luring).


---

## 📖 Dokumentasi Lengkap

1. 👉 **[DOKUMENTASI_ARSITEKTUR_DUAL_DATABASE.md](./DOKUMENTASI_ARSITEKTUR_DUAL_DATABASE.md)** — Spesifikasi Arsitektur Sistem Master
2. 👉 **[RENCANA_IMPLEMENTASI_PROTOTIPE_BERTAHAP.md](./RENCANA_IMPLEMENTASI_PROTOTIPE_BERTAHAP.md)** — Rencana Kerja Bertahap (Fase 0 – Fase 5)

