# Skema Database & Sinkronisasi Backend v2 (PKN Mobile)

> **Dokumen Arsitektur Persistensi Data Luring & Daring**  
> Menggabungkan database lokal klien (**Drift SQLite**) dan basis data publik (**Embedded LibSQL**) dengan **Directus CMS / Alexandrie Hub**.

---

## 1. Topologi Dua Database (Dual-Database Architecture)

Aplikasi klien di Flutter memisahkan data menjadi dua basis data independen untuk menjaga privasi mutlak dan efisiensi penyimpanan:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        FLUTTER CLIENT STORAGE                          │
├────────────────────────────────────┬───────────────────────────────────┤
│    1. local_userdata.db (Drift)    │    2. knowledge_v4.db (LibSQL)    │
│    [Privasi Personal & Outbox]     │   [Konten Publik & Khazanah OTA]  │
├────────────────────────────────────┼───────────────────────────────────┤
│ • users                            │ • events                          │
│ • user_job_profiles                │ • books                           │
│ • relations                        │ • entities_persons                │
│ • daily_tasks                      │ • entities_institutions           │
│ • daily_task_reviews               │ • partnership_programs            │
│ • tb40_user_assessments            │ • wiki_articles                   │
│ • curhat_sessions & messages       │ • wiki_articles_fts (FTS5)        │
│ • user_event_badges                │ • wiki_embeddings (384-dim Vector)│
│ • outbox_mutations (Sync Queue)    │ • interactive_stories & scenarios │
└────────────────────────────────────┴───────────────────────────────────┘
```

---

## 2. Skema Database Personal Klien (`local_userdata.db` via Drift)

### A. Tabel `users` & `user_job_profiles`
```sql
CREATE TABLE users (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    kunyah TEXT,
    avatar_id TEXT,
    primary_role TEXT NOT NULL, -- 'ayah', 'bunda', 'guru', 'santri', 'mandiri'
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);

CREATE TABLE user_job_profiles (
    user_id TEXT PRIMARY KEY REFERENCES users(id),
    profession TEXT,
    institution_id TEXT, -- referensi opsional ke entities_institutions
    institution_name TEXT,
    timezone TEXT DEFAULT 'Asia/Jakarta',
    notes TEXT
);
```

### B. Tabel `relations` (Relasi Qalbiyah)
```sql
CREATE TABLE relations (
    id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL REFERENCES users(id),
    name TEXT NOT NULL,
    relation_type TEXT NOT NULL, -- 'anak', 'pasangan', 'santri', 'murid'
    gender TEXT, -- 'L', 'P'
    birth_date INTEGER,
    fitrah_phase TEXT NOT NULL, -- 'thufulah', 'tamyiz', 'murahaqah', 'syabab'
    love_tank_score INTEGER DEFAULT 80, -- skala 0 - 100
    last_dialog_at INTEGER,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);
```

### C. Tabel `daily_tasks` & `daily_task_reviews`
```sql
CREATE TABLE daily_tasks (
    id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL REFERENCES users(id),
    relation_id TEXT REFERENCES relations(id),
    title TEXT NOT NULL,
    category TEXT NOT NULL, -- 'diri', 'relasi', 'belajar', 'ibadah'
    is_completed INTEGER DEFAULT 0,
    scheduled_date TEXT NOT NULL, -- YYYY-MM-DD
    order_index INTEGER DEFAULT 0,
    created_at INTEGER NOT NULL
);

CREATE TABLE daily_task_reviews (
    id TEXT PRIMARY KEY,
    task_id TEXT NOT NULL REFERENCES daily_tasks(id),
    nafs_quality TEXT NOT NULL, -- 'muthmainnah', 'lawwamah', 'ammarah'
    rubric_score TEXT, -- 'BT', 'MT', 'BK', 'MM'
    notes TEXT,
    reviewed_at INTEGER NOT NULL
);
```

### D. Tabel `tb40_user_assessments`
```sql
CREATE TABLE tb40_user_assessments (
    id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL REFERENCES users(id),
    talent_code TEXT NOT NULL, -- misal 'SYAJAAAH', 'RIFQ', 'HIKMAH'
    cluster TEXT NOT NULL, -- 'qiyadah', 'fashahah', 'idarah', 'fikriyyah'
    score_level INTEGER NOT NULL, -- 1 s.d. 5
    is_dominant INTEGER DEFAULT 0,
    evaluated_at INTEGER NOT NULL
);
```

### E. Tabel `curhat_sessions` & `curhat_messages`
*Tersimpan luring di perangkat lokal (zero retention di cloud server).*
```sql
CREATE TABLE curhat_sessions (
    id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL REFERENCES users(id),
    title TEXT NOT NULL,
    initial_topic TEXT,
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL
);

CREATE TABLE curhat_messages (
    id TEXT PRIMARY KEY,
    session_id TEXT NOT NULL REFERENCES curhat_sessions(id) ON DELETE CASCADE,
    sender_type TEXT NOT NULL, -- 'user', 'ai'
    message_text TEXT NOT NULL,
    doa_attached TEXT,
    created_at INTEGER NOT NULL
);
```

### F. Tabel `outbox_mutations` (Antrean Sinkronisasi)
```sql
CREATE TABLE outbox_mutations (
    id TEXT PRIMARY KEY,
    entity_table TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    mutation_type TEXT NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE'
    payload_json TEXT NOT NULL,
    retry_count INTEGER DEFAULT 0,
    created_at INTEGER NOT NULL,
    last_attempt_at INTEGER
);
```

---

## 3. Skema Basis Data Pengetahuan Publik (`knowledge_v4.db` via LibSQL)

*Didistribusikan sebagai arsip Zstandard terkompresi (~7 MB) yang dapat diperbarui OTA.*

### A. Tabel `events` & `event_badges`
```sql
CREATE TABLE events (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    category TEXT NOT NULL, -- 'daurah', 'seminar', 'kajian', 'temu_lembaga'
    speaker_id TEXT,
    institution_id TEXT,
    start_at TEXT NOT NULL, -- ISO-8601
    end_at TEXT NOT NULL,
    location_type TEXT NOT NULL, -- 'online', 'offline', 'hybrid'
    location_detail TEXT,
    cover_image_url TEXT,
    registration_url TEXT,
    is_featured INTEGER DEFAULT 0,
    badge_title TEXT,
    badge_icon_svg TEXT
);
```

### B. Tabel `books` (Katalog Pustaka)
```sql
CREATE TABLE books (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    author_id TEXT NOT NULL,
    category TEXT NOT NULL,
    synopsis TEXT NOT NULL,
    table_of_contents_json TEXT, -- array bab
    page_count INTEGER,
    cover_image_url TEXT,
    purchase_url TEXT,
    pdf_asset_path TEXT,
    is_recommended INTEGER DEFAULT 0
);
```

### C. Tabel `entities_persons` & `entities_institutions`
```sql
CREATE TABLE entities_persons (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    title_prefix TEXT,
    title_suffix TEXT,
    role_description TEXT NOT NULL,
    bio TEXT NOT NULL,
    avatar_url TEXT,
    order_index INTEGER DEFAULT 0
);

CREATE TABLE entities_institutions (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    short_name TEXT NOT NULL,
    type TEXT NOT NULL, -- 'sekolah', 'yayasan', 'kuttab', 'pesantren'
    level_scope TEXT, -- 'TK-SD-SMP-SMA'
    city TEXT,
    address TEXT,
    contact_phone TEXT,
    contact_email TEXT,
    logo_url TEXT,
    is_verified_partner INTEGER DEFAULT 1
);
```

### D. Tabel `partnership_programs` (Kemitraan Lembaga v2)
```sql
CREATE TABLE partnership_programs (
    id TEXT PRIMARY KEY,
    code TEXT UNIQUE NOT NULL, -- 'KONSULTASI_ONLINE', 'VISITASI', 'COACHING', 'PENGADAAN_ACARA'
    title TEXT NOT NULL,
    tagline TEXT NOT NULL,
    description TEXT NOT NULL,
    duration_spec TEXT,
    capacity_spec TEXT,
    deliverables_spec TEXT,
    icon_name TEXT NOT NULL
);
```

### E. Tabel `wiki_articles` & FTS5 / Vector
```sql
CREATE TABLE wiki_articles (
    id TEXT PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    category TEXT NOT NULL, -- 'penulis', 'paradigma', 'bakat', 'doa', 'tips'
    sub_category TEXT,
    summary_tldr TEXT NOT NULL,
    body_markdown TEXT NOT NULL,
    author_id TEXT REFERENCES entities_persons(id),
    audio_stream_url TEXT,
    audio_duration_seconds INTEGER,
    arabic_dalil_json TEXT,
    related_software_links TEXT, -- json [OpenBayan, Qaf, Quran.org, Tafsirweb]
    published_at TEXT NOT NULL
);

-- Virtual Table FTS5 Full-Text Search
CREATE VIRTUAL TABLE wiki_articles_fts USING fts5(
    title, summary_tldr, body_markdown,
    content='wiki_articles', content_rowid='rowid'
);

-- LibSQL Vector Search 384-Dimensi
CREATE TABLE wiki_embeddings (
    article_id TEXT PRIMARY KEY REFERENCES wiki_articles(id),
    embedding F32_BLOB(384)
);
CREATE INDEX wiki_vector_idx ON wiki_embeddings(libsql_vector_idx(embedding));
```

### F. Tabel `interactive_stories` & Skenario Adab
```sql
CREATE TABLE interactive_stories (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    series_name TEXT DEFAULT 'Serial Zaid',
    age_phase TEXT NOT NULL, -- 'thufulah', 'tamyiz', 'murahaqah', 'syabab'
    crisis_situation TEXT NOT NULL,
    scenario_graph_json TEXT NOT NULL, -- node tree pilihan respon & cermin TB-40
    reflection_notes TEXT NOT NULL
);
```

---

## 4. Alur Sinkronisasi & Resolusi Konflik (Sync Outbox Pipeline)

1. **Mutasi Luring Klien:** Setiap kali pengguna membuat atau mengubah Daily Task, Relasi, atau Catatan Adab:
   - Data langsung ditulis ke tabel utama di `local_userdata.db`.
   - Sebuah rekaman dicatat ke `outbox_mutations`.
2. **Pengiriman Latar Belakang:** Ketika koneksi internet aktif, worker HTTP mengirimkan mutasi dalam format antrean FIFO ke endpoint Backend v2 (`POST /api/sync/v2/outbox`).
3. **Resolusi Konflik:**
   - Klien mengirim `updated_at` lokal. Jika server mendeteksi perubahan konkuren dengan timestamp lebih baru di server, server mengembalikan status `409 Stale Mutation`.
   - Kebijakan penyelesaian mengutamakan data lokal klien untuk ranah jurnal adab personal (*Client Wins for Personal Reflections*).
