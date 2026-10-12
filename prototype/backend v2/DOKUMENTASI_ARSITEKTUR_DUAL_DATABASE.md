# Dokumentasi Arsitektur Backend v2: Dual-Database Engine, Directus Headless, dan Local AI untuk Flutter

> **Status:** Cetak Biru Arsitektur & Spesifikasi Implementasi  
> **Kompatibilitas:** Flutter Mobile (iOS & Android) & Flutter Web  
> **Target Prototipe:** `prototype/backend v2`  
> **Prinsip Utama:** *Local-First*, *Dual-Database Isolation*, *Dual-Source Knowledge Ingestion*, *Low-Overhead Outbox Sync*, dan *Zero Cloud Leak (Amanah)*.

> **Implementasi fungsional ringan:** `ingestion_worker.py` menyinkronkan WordPress ke `data/alexandrie_curated.json`; compiler mengonsumsi snapshot tersebut atau API Alexandrie. `server.py` mendistribusikan OTA dan menyimpan sinkronisasi akun di `user_sync.db`, terpisah dari database knowledge. Server prototipe menggunakan token akun statis, bukan OAuth/Directus. Stack Docker di bawah tetap merupakan target deployment, bukan prasyarat pengujian E2E lokal. Mode `lexical` menyediakan FTS5; vektor hanya dibuat dalam mode semantik dengan model nyata.

---

## 1. Ringkasan Eksekutif & Latar Belakang

Pada evolusi arsitektur backend PKN Healing, backend dirancang untuk memenuhi dua kebutuhan besar:
1. **Knowledge Database (Konten Publik & Khazanah Edukasi):** Bersifat read-only bagi pengguna, diakses secara luring (*offline-first*), serta mendukung pencarian teks (FTS5) dan semantik vektor lokal.
2. **User Private Store (Data Personal Pengguna):** Bersifat privat di perangkat fisik pengguna (catatan refleksi, bookmark, progres baca modul) yang disinkronkan secara ringan lintas perangkat jika pengguna masuk (*login*).

### Mengapa Menolak Full Database-Level Sync (Turso Replicas / PowerSync / ElectricSQL)?
Dalam evaluasi mendalam, engine replikasi database terdistribusi penuh untuk data pengguna diputuskan **dihindari** karena:
1. **Kasus Penggunaan Berbeda:** Engine sinkronisasi terdistribusi dirancang untuk kolaborasi multi-user konkuren tinggi (seperti Google Docs atau Figma) dengan rekonsiliasi konflik baris/kolom (CRDTs).
2. **Karakter Data Pengguna PKN:** Data pengguna PKN hanya berupa data privat personal (profil, bookmark, progres baca, dan catatan pribadi) milik satu akun.
3. **Kompleksitas Operasional:** Replikasi WAL database terdistribusi menambah overhead memori, kerumitan migrasi skema mobile, dan risiko kegagalan koneksi di jaringan seluler lemah.

### Solusi: Paradigma *Dual-Database Isolation*
Aplikasi menerapkan pemisahan tegas menjadi **dua database lokal independen**:
1. **`knowledge.db` (Public Knowledge Base):** Database SQLite/libSQL baca-saja hasil kompilasi offline (*pre-compiled*), menggabungkan dua aliran sumber: **Wiki AI-Generated** dan **Alexandrie (Wiki Non-AI & Hub Publik)**. Database ini diperbarui berkala via berkas terkompresi Zstandard Over-The-Air (OTA).
2. **`user_local.db` (User Private Store):** Database SQLite lokal (dikelola via pustaka Drift) untuk data pengguna. Menggunakan **Pola Outbox Ringan (*Dirty Flag*)** untuk menyinkronkan data ke backend Directus melalui REST API standar saat online.

---

## 2. Strategi Dual-Source Knowledge Ingestion

Knowledge Base menggabungkan dua sumber konten dengan klasifikasi kredibilitas yang jelas (*provenance*):

```
┌──────────────────────────────────────┐     ┌───────────────────────────────────────────────────┐
│     SUMBER 1: WIKI AI-GENERATED      │     │            SUMBER 2: ALEXANDRIE (NON-AI)          │
│  (wikipkn.insanmustaqbal.or.id /     │     │     (Wiki Tulisan Pakar, Cerita, Doa, Buku)       │
│   /home/abuhafi/Project/wiki-pkn/)   │     └─────────────────────────▲─────────────────────────┘
└──────────────────┬───────────────────┘                               │ Ingest via REST API
                   │                                                   │
                   │ Raw Markdown                               ┌──────┴─────────────────────────┐
                   │                                            │ INGESTION WORKER (Scraper/WP)  │
                   │                                            │ • karakternabawiyah.com        │
                   │                                            │ • WP REST API (/wp/v2/pages)   │
                   │                                            │ • Event & Katalog Buku Publik  │
                   │                                            └────────────────────────────────┘
                   ▼                                                   ▼
┌────────────────────────────────────────────────────────────────────────────────────────────────┐
│                        UNIFIED KNOWLEDGE COMPILER (build_knowledge_db.py)                      │
│                                                                                                │
│  1. Ingest Markdown (Wiki-AI) + Ingest API/JSON (Alexandrie Non-AI & Scraped Data)             │
│  2. Sematkan Tag Kredibilitas / Provenance:                                                    │
│     • `source_type`: 'expert_verified' (Alexandrie) vs 'ai_assisted' (Wiki-AI)                 │
│  3. Chunking Cerdas + 384-dim Dense Vector Embeddings                                          │
│  4. Indeks Kata Kunci SQLite FTS5 (Hybrid Retrieval)                                           │
│  5. Kompresi Zstandard (Level 19) ──► Menghasilkan: `knowledge_v1.db.zst`                        │
└───────────────────────────────────────────────┬────────────────────────────────────────────────┘
                                                │
                                                ▼
                         ┌───────────────────────────────────────────────┐
                         │     DISTRIBUSI OTA (Directus / S3 / R2)       │
                         │                                               │
                         │   Mobile App (Flutter) mengunduh sekali dan   │
                         │   mengekstrak menjadi `knowledge.db` luring   │
                         └───────────────────────────────────────────────┘
```

### 2.1 Sumber 1: `wiki-ai-generated`
* **Lokasi Sumber:** Korpus repositori Markdown lokal `/home/abuhafi/Project/wiki-pkn/` atau mirror `wikipkn.insanmustaqbal.or.id`.
* **Karakteristik:** Luas, kaya konsep taksonomi parenting, hasil sintesis dan bantuan AI.
* **Metadata Provenance:** `provenance = 'ai_assisted'`.

### 2.2 Sumber 2: Alexandrie (Wiki Non-AI & Hub Publik)
* **Peran:** Portal mandiri yang murni memuat tulisan pakar/asatidz terverifikasi tanpa intervensi generasi teks AI.
* **Ruang Lingkup Konten Publik:**
  1. **Doa Penenang Jiwa:** Teks Arab lengkap dengan harakat, terjemahan, dan takhrij/derajat hadits (Hisnul Muslim).
  2. **Cerita & Skenario Adab (Living RPG):** Graf keputusan interaktif parenting nabawiyah.
  3. **Katalog Buku & Pustaka PKN:** Informasi referensi literatur dan modul cetak.
  4. **Event & Majelis Akbar:** Jadwal kegiatan parenting publik.
* **Ingestion Worker (Scraper / WordPress API):** Script pembantu yang secara berkala mengambil data publik dari situs resmi `karakternabawiyah.com` (melalui endpoint REST API `/wp/v2/pages` dan scraping markup Elementor), lalu menormalkannya dan memasukkannya ke kategori terkait di Alexandrie.
* **Metadata Provenance:** `provenance = 'expert_verified'`.

---

## 3. Topologi & Diagram Arsitektur Keseluruhan

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                                   CLIENT LAYER (Flutter)                               │
│                                                                                        │
│   ┌────────────────────────────────────────────────────────────────────────────────┐   │
│   │                         Presentation & UI (Earth-Tree)                         │   │
│   └───────────────────────┬───────────────────────────────┬────────────────────────┘   │
│                           │                               │                            │
│                           ▼                               ▼                            │
│   ┌──────────────────────────────────────┐  ┌──────────────────────────────────────┐   │
│   │      Local AI & Knowledge Engine     │  │          User Data & Session         │   │
│   ├──────────────────────────────────────┤  ├──────────────────────────────────────┤   │
│   │ • ONNX Runtime (384-dim Embedder)    │  │ • Drift / SQLite (`user_local.db`)   │   │
│   │ • llama.cpp (1B–2B SLM Runtime)      │  │ • Chat & Search History (Local-only) │   │
│   │ • `knowledge.db` (Extracted libSQL)  │  │ • Bookmarks & Notes (Outbox Sync)    │   │
│   │ • On-Demand Office Cache (Temp/App)  │  │ • Secure Token Storage (Keychain/Enc)│   │
│   └───────────────────▲──────────────────┘  └───────────────────┬──────────────────┘   │
└───────────────────────┼─────────────────────────────────────────┼──────────────────────┘
                        │                                         │
                        │ HTTP Range / Asset Stream               │ REST API / JWT
                        │ (OTA Database Updates & Office Files)   │ (Sync & OAuth)
                        ▼                                         ▼
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                                  SERVER LAYER (Docker)                                 │
│                                                                                        │
│   ┌────────────────────────────────────────────────────────────────────────────────┐   │
│   │                       Directus Headless Engine (Port 8055)                     │   │
│   │  • OpenID Connect / OAuth Handler (Google & Apple)                             │   │
│   │  • Native Storage Gateway & Presigned URL Provider                             │   │
│   │  • User Data RBAC Enforcer (Automatic `$CURRENT_USER` Sandboxing)              │   │
│   └───────────────────────┬───────────────────────────────┬────────────────────────┘   │
│                           │                               │                            │
│                           ▼                               ▼                            │
│   ┌──────────────────────────────────────┐  ┌──────────────────────────────────────┐   │
│   │         PostgreSQL 16 Engine         │  │       Object Storage (S3 / R2)       │   │
│   ├──────────────────────────────────────┤  ├──────────────────────────────────────┤   │
│   │ • `directus_users`                   │  │ • `knowledge_releases/vX.db.zst`     │   │
│   │ • `user_bookmarks` (Per-user sync)   │  │ • `office_docs/*.docx, *.pdf, *.xlsx`│   │
│   │ • `user_notes`     (Per-user sync)   │  │ • Public CDN Delivery                │   │
│   │ • `knowledge_catalog` (Metadata)     │  │                                      │   │
│   └──────────────────────────────────────┘  └──────────────────────────────────────┘   │
└────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## 4. Server Architecture: Directus, PostgreSQL & Alexandrie Integration

### 4.1 Mengapa Directus?
1. **SQL Murni Tanpa Abstraksi Proprietary:** Directus membaca langsung skema relasional PostgreSQL tanpa mengubah tabel menjadi format tersembunyi.
2. **REST & GraphQL API Otomatis:** Setiap tabel yang dibuat langsung menghasilkan endpoint CRUD berkinerja tinggi lengkap dengan pagination, filtering, dan sorting.
3. **RBAC Berbasis Nilai Dinamis:** Aturan keamanan (*row-level security*) mengisolasi data pengguna dengan filter aturan bawaan: `user_id EQUALS $CURRENT_USER`.
4. **Sistem File & CDN:** Mendukung koneksi transparan ke Cloudflare R2, AWS S3, atau MinIO lokal untuk distribusi rilis knowledge base dan berkas dokumen.
5. **Autentikasi OpenID Connect Bawaan:** Mendukung login sosial (Google & Apple ID) secara bawaan untuk mobile.

### 4.2 Skema Database Relasional PostgreSQL (Directus)

Skema DDL inisial (`schema.sql`):

```sql
-- 1. Katalog Rilis Knowledge Base (Pelacak Berkas OTA Terkompresi Zstandard)
CREATE TABLE knowledge_releases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    version_code INTEGER UNIQUE NOT NULL,
    release_tag VARCHAR(50) NOT NULL,
    file_id UUID,                        -- Merujuk ke directus_files(id) jika ada
    download_url TEXT,                   -- URL langsung jika CDN/S3
    uncompressed_byte_size BIGINT NOT NULL,
    compressed_byte_size BIGINT NOT NULL,
    sha256_checksum VARCHAR(64) NOT NULL,
    changelog TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Katalog Metadata Dokumen Kantor On-Demand (PDF, Word, Excel)
CREATE TABLE knowledge_documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    article_id VARCHAR(100) NOT NULL,    -- Pemetaan ke ID artikel markdown lokal
    title VARCHAR(255) NOT NULL,
    file_type VARCHAR(10) NOT NULL,      -- 'pdf', 'docx', 'xlsx'
    file_id UUID,
    download_url TEXT,
    byte_size BIGINT NOT NULL,
    sha256_checksum VARCHAR(64) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Sinkronisasi Bookmark Pengguna
CREATE TABLE user_bookmarks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,               -- Merujuk ke directus_users(id)
    article_id VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT unique_user_article_bookmark UNIQUE(user_id, article_id)
);

-- 4. Sinkronisasi Catatan Pengguna (Outbox Target)
CREATE TABLE user_notes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,               -- Merujuk ke directus_users(id)
    article_id VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    client_updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_user_notes_sync ON user_notes(user_id, updated_at DESC);
CREATE INDEX idx_user_bookmarks_user ON user_bookmarks(user_id);
CREATE INDEX idx_knowledge_releases_active ON knowledge_releases(is_active, version_code DESC);
```

---

## 5. Pipeline Kompilasi Knowledge Base (`build_knowledge_db.py`)

Seluruh korpus dikompilasi **secara offline di workstation / CI/CD runner** ke dalam satu berkas SQLite biner sebelum didistribusikan ke ponsel:

### 5.1 Skema SQLite Biner di Ponsel (`knowledge.db`)
```sql
CREATE TABLE articles (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    content_type TEXT NOT NULL,     -- 'article', 'doa', 'cerita_rpg', 'buku', 'event'
    provenance TEXT NOT NULL,       -- 'expert_verified' (Alexandrie) | 'ai_assisted' (Wiki-AI)
    source_origin TEXT NOT NULL,    -- 'alexandrie', 'wiki_pkn', 'karakternabawiyah_wp'
    author_or_speaker TEXT,         -- Nama pakar, ustadz, atau penulis
    summary TEXT,
    content TEXT NOT NULL,
    metadata_json TEXT              -- Menyimpan struktur khusus (jadwal event, link registrasi, doa harakat, graf RPG)
);

CREATE TABLE article_chunks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    article_id TEXT NOT NULL,
    chunk_index INTEGER NOT NULL,
    chunk_content TEXT NOT NULL,
    provenance TEXT NOT NULL,       -- Filter semantik: bobot jawaban expert_verified dapat diprioritaskan
    embedding BLOB,                 -- Vektor Float32 384-dimensi
    FOREIGN KEY(article_id) REFERENCES articles(id)
);

CREATE VIRTUAL TABLE articles_fts USING fts5(
    title,
    content,
    content='articles',
    content_rowid='rowid'
);
```

### 5.2 Analisis Ukuran Database & Kompresi
Berdasarkan estimasi $\approx 20\text{ MB}$ teks Markdown mentah ($\approx 20.000$ chunks):

| Komponen Database | Ukuran Biner (Uncompressed) | Peran |
|---|---|---|
| **Teks & Metadata Chunks** | $\approx 28\text{ MB}$ | Judul, slug, teks paragraf, dan struktur B-tree SQLite |
| **Raw Vectors 384-dim (Float32)** | $\approx 31\text{ MB}$ | $20.000\times 384\times 4\text{ byte}$ BLOB |
| **Indeks Graf Vektor / FTS5** | $\approx 10\text{ MB}$ | Indeks pencarian teks cepat FTS5 |
| **Total Database SQLite Mentah** | **$\approx 69\text{ MB}$** | Database lengkap siap query di ponsel |
| **Hasil Kompresi Zstandard (.zst)** | **$\approx 18\text{ – }22\text{ MB}$** | **Ukuran paket unduhan OTA yang dikirim lewat CDN** |

---

## 6. Arsitektur Client Mobile Flutter

### 6.1 Tata Letak Penyimpanan di OS Mobile (iOS & Android)
* `getApplicationSupportDirectory() / knowledge.db`: Wiki gabungan + Vektor + FTS5. **Dikecualikan dari iCloud & Android Auto-Backup**.
* `getApplicationSupportDirectory() / user_local.db`: Database Drift untuk Catatan & Bookmark. Disandbox dan terenkripsi lokal.
* `getTemporaryDirectory() / docs_cache/*`: Cache file Office (PDF, Word, Excel).

### 6.2 Pola Outbox Sinkronisasi Data Pengguna (Drift SQLite)
1. **Local-First Write:** Simpan seketika ke `user_local.db` dengan status `sync_status = 'pending'`. UI terupdate $0\text{ ms}$.
2. **Background Push:** Saat online, kirim mutasi tertunda secara batch via HTTP POST/PATCH ke Directus. Ubah status jadi `synced`.
3. **Delta Pull:** Tarik catatan baru dari Directus dengan filter `updated_at > last_sync_timestamp`.

### 6.3 Local AI & Manhaj Kepatuhan (*Amanah / Zero Cloud Leak*)
1. **Inferensi AI 100% On-Device:**
   * Fitur Curhat AI (*Sanctuary*), Muhasabah, dan dialog refleksi jiwa **tidak pernah mengirimkan teks percakapan pengguna ke server cloud**.
   * Pencarian semantik menggunakan model embedding 384-dimensi via **ONNX Runtime** di Flutter.
   * Respon panduan pengasuhan diproses lokal via model SLM 1B–2B parameter (`llama.cpp` mobile).
2. **Data Anak & Observasi Karakter Tetap Privat:**
   * Skor kalkulator Mizan Fitrah, pemetaan bakat Syakilah TB-40 anak, dan catatan kelemahan anak disimpan eksklusif di `user_local.db` pada perangkat fisik orang tua tanpa endpoint sync ke server.

---

## 7. Integrasi Model Context Protocol (MCP) untuk Knowledge Database

Jika sistem membutuhkan antarmuka **Model Context Protocol (MCP)** agar asisten/agen AI (seperti Claude Desktop, Cursor IDE, Antigravity, atau LLM internal) dapat mengeksplorasi khazanah parenting PKN:

### 7.1 Apakah Perlu Menjalankan Database Terpisah?
> **Jawaban: TIDAK PERLU SAMA SEKALI.**

Pilihan menggunakan pre-compiled SQLite (`knowledge.db`) memberikan keuntungan arsitektural mutlak:
1. **Konkurensi Pembacaan Multi-Proses SQLite (*Concurrent Multi-Reader*):**
   * SQLite secara arsitektural mengizinkan banyak proses berbeda membaca berkas yang sama secara paralel tanpa saling mengunci (*lock-free*), cukup dengan membuka koneksi dalam mode *read-only* URI (`file:knowledge_build.db?mode=ro`).
   * MCP server, pipeline kompilasi, maupun tool analisis lokal dapat mengakses database secara simultan.
2. **Kemampuan AI-Native Sudah Tertanam di File yang Sama:**
   * SQLite virtual table **FTS5** (pencarian kata kunci berkecepatan tinggi) dan kolom **vektor embedding 384-dimensi** sudah tersedia di dalam berkas biner tersebut.
   * Tidak diperlukan database vektor eksternal terpisah (seperti Qdrant, Chroma, atau Pinecone) yang memakan RAM dan proses latar belakang tambahan.
3. **Single Source of Truth:**
   * Data yang diakses oleh agen AI melalui MCP dijamin **100% identik dan konsisten** dengan apa yang dicari dan dibaca oleh pengguna aplikasi mobile Flutter di lapangan.
4. **Jejak Memori Mikro ($\approx 15\text{–}30\text{ MB}$ RAM):**
   * Server MCP berjalan sebagai proses kecil yang ringan tanpa memerlukan daemon database terpisah.

---

### 7.2 Diagram Arsitektur Interfacing MCP

```
┌────────────────────────────────────────────────────────┐
│               AI AGENTS / LLM CLIENTS                  │
│   (Claude Desktop, Cursor IDE, Antigravity, dsb.)      │
└───────────────────────────┬────────────────────────────┘
                            │ Model Context Protocol (MCP)
                            │ (via Stdio atau HTTP/SSE)
                            ▼
┌────────────────────────────────────────────────────────┐
│             PKN KNOWLEDGE MCP SERVER                   │
│             (Python FastMCP / Node.js)                 │
│                                                        │
│  Tersedia Tools:                                       │
│  • search_knowledge(query, provenance, content_type)   │
│  • get_article(article_id)                             │
│  • get_doa_penenang(topik)                             │
│  • get_skenario_adab(masalah)                          │
│  • get_agenda_event()                                  │
└───────────────────────────┬────────────────────────────┘
                            │ Read-Only Direct Query (?mode=ro)
                            ▼
┌────────────────────────────────────────────────────────┐
│                   knowledge.db                         │
│      (SQLite + FTS5 Full-Text + Vektor 384-dim)        │
│                                                        │
│  • Sumber 1: Wiki AI-Generated (Khazanah Luas)         │
│  • Sumber 2: Alexandrie Non-AI (Doa, Cerita, Buku, Event)│
└────────────────────────────────────────────────────────┘
```

---

### 7.3 Katalog Tools Standar yang Disediakan MCP Server

| Nama Tool MCP | Parameter Utama | Tugas & Akses Data |
|---|---|---|
| **`search_knowledge`** | `query`: string<br>`provenance`: `'all'` \| `'expert_verified'` \| `'ai_assisted'`<br>`content_type`: `'all'` \| `'article'` \| `'doa'` \| `'cerita_rpg'` \| `'buku'` \| `'event'`<br>`limit`: int | Melakukan *Hybrid Search* (FTS5 BM25 + cosine distance vektor 384-dim) pada tabel `articles` & `article_chunks`. |
| **`get_article`** | `article_id`: string | Mengambil teks artikel utuh, nama penulis/pakar, kategori, dan metadata. |
| **`get_doa_penenang`** | `topik`: string | Mengambil doa terverifikasi pakar (*expert_verified*) lengkap dengan teks Arab berharakat, terjemahan, dan takhrij/derajat hadits dari Hisnul Muslim. |
| **`get_skenario_adab`** | `masalah`: string | Mengambil pohon skenario interaktif living RPG (opsi pilihan A/B orang tua dan respon adab). |
| **`get_agenda_event`** | `limit`: int | Mengambil agenda daurah, webinar, dan majelis akbar resmi terkini (hasil mirror `karakternabawiyah.com`). |

---

### 7.4 Dua Mode Deployment MCP Server

1. **Mode Lokal (`stdio` Process):**
   * Ditujukan untuk integrasi langsung di workstation pengembang (misalnya di Cursor IDE, Claude Desktop, atau Antigravity CLI).
   * Konfigurasi diatur pada file konfigurasi client (`claude_desktop_config.json` atau `.cursor/mcp.json`):
     ```json
     {
       "mcpServers": {
         "pkn-knowledge": {
           "command": "python3",
           "args": [
             "/home/abuhafi/Project/PKN-healing-mobile-app/prototype/backend v2/mcp/pkn_knowledge_mcp.py",
             "--db",
             "/home/abuhafi/Project/PKN-healing-mobile-app/prototype/backend v2/knowledge_build.db"
           ]
         }
       }
     }
     ```
2. **Mode Jaringan (`SSE` / HTTP Server):**
   * Ditujukan jika agen AI berada di server atau cloud lain yang membutuhkan akses over-the-network.
   * Dijalankan sebagai service kontainer tambahan yang mengekspos endpoint Server-Sent Events (SSE) di port `8090`.

---

## 8. Arsitektur LibSQL Vector Search & On-Device Embedding

Untuk mendukung pencarian semantik berkecepatan tinggi secara luring (*offline-first*) tanpa mengorbankan privasi pengguna (**Zero Cloud Leak / Amanah**), backend v2 mengintegrasikan kapabilitas **LibSQL Vector Search**:

### 8.1 Skema Data & Indeks Vektor DiskANN
Pada database `knowledge.db`, tabel `article_chunks` menggunakan kolom `F32_BLOB(384)` yang menyimpan vektor embedding berdimensi 384 dalam format little-endian IEEE-754 32-bit float (`<f4`, tepat 1.536 byte per chunk):

```sql
CREATE TABLE article_chunks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    article_id TEXT NOT NULL,
    chunk_index INTEGER NOT NULL,
    chunk_content TEXT NOT NULL,
    provenance TEXT NOT NULL,
    embedding F32_BLOB(384),
    FOREIGN KEY(article_id) REFERENCES articles(id)
);

-- Indeks Vektor DiskANN LibSQL
CREATE INDEX IF NOT EXISTS chunks_vector_idx ON article_chunks(
    libsql_vector_idx(embedding, 'metric=cosine')
);
```

### 8.2 Model Embedding & Ekstraksi On-Device
1. **Model Acuan:** `sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2` (384 dimensi, multibahasa Indonesia & Arab).
2. **Kompilasi Backend:** Generator mengekstrak seluruh chunk naskah dan menyimpan representasi vektor L2-normalized ke `F32_BLOB(384)`.
3. **Eksekusi di Mobile (Flutter):** Menggunakan `onnxruntime_flutter` dengan bobot model kuantisasi INT8 (~25-30 MB). Kueri teks pengguna diubah menjadi `Float32List(384)` langsung di CPU/NPU ponsel tanpa dikirim ke server.

### 8.3 Kueri `vector_top_k` & Hybrid Search (RRF)
Klien Flutter mengeksekusi fungsi virtual LibSQL:
```sql
SELECT c.article_id, a.title, c.chunk_content, v.distance
FROM vector_top_k('chunks_vector_idx', vector32(?), ?) AS v
JOIN article_chunks AS c ON c.rowid = v.id
JOIN articles AS a ON a.id = c.article_id
ORDER BY v.distance ASC;
```

Hasil semantik dipadukan dengan leksikal FTS5 menggunakan algoritma **Reciprocal Rank Fusion (RRF)**:
$$RRF(d) = \frac{1}{60 + \text{rank}_{\text{fts}}} + \frac{1}{60 + \text{rank}_{\text{vector}}}$$

Implementasi klien seluler tersedia di:
- [`client_examples/libsql_vector_search_service.dart`](./client_examples/libsql_vector_search_service.dart)
- [`client_examples/on_device_embedder_service.dart`](./client_examples/on_device_embedder_service.dart)

---

## 9. Rangkuman Perbandingan: Backend v1 vs Backend v2

| Aspek | Backend v1 (Implementasi Sebelumnya) | Backend v2 (Arsitektur Baru) |
|---|---|---|
| **Fokus Utama** | Mirror baca-saja Git Wiki & Scraping Event | Platform backend lengkap (Knowledge OTA + User Sync + Auth + MCP + Vector) |
| **Sumber Knowledge** | Tunggal (repositori Markdown `wiki-pkn`) | **Dual-Source:** Wiki-AI + Alexandrie Non-AI/Hub Publik |
| **Klasifikasi Kredibilitas** | Tidak ada pembeda sumber | Metadata **`provenance`** terstruktur (`expert_verified` vs `ai_assisted`) |
| **Dukungan MCP** | Belum ada | **Native MCP Tooling** (FTS5, Vector Cosine, Hybrid RRF, Similar Articles) |
| **Database Server** | Tanpa database server (hanya memori & cache JSON) | PostgreSQL 16 + Directus Headless CMS |
| **Manajemen User** | Murni lokal di client SharedPreferences | Otentikasi OAuth (Google/Apple) + Drift Outbox Sync |
| **Pencarian Semantik** | Pencarian teks kata sederhana di memori | **LibSQL DiskANN Vector Search (384-dim)** + FTS5 Hybrid RRF |
| **Jejak Memori Server** | Sangat kecil ($\approx 50\text{ MB}$) | Tetap sangat hemat ($\approx 200\text{ MB}$ RAM untuk Postgres + Directus + Alexandrie) |


