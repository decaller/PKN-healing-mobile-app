-- ========================================================================
-- PKN HEALING BACKEND v2 - INITIAL POSTGRESQL SCHEMA (DIRECTUS COMPATIBLE)
-- ========================================================================

-- Pastikan extension pgcrypto aktif untuk UUID generator
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 1. Katalog Rilis Knowledge Base (Pelacak Berkas OTA Terkompresi Zstandard)
CREATE TABLE IF NOT EXISTS knowledge_releases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    version_code INTEGER UNIQUE NOT NULL,
    release_tag VARCHAR(50) NOT NULL,
    file_id UUID,                        -- Merujuk ke directus_files(id) jika Directus aktif
    download_url TEXT,                   -- URL langsung jika menggunakan CDN/S3
    uncompressed_byte_size BIGINT NOT NULL,
    compressed_byte_size BIGINT NOT NULL,
    sha256_checksum VARCHAR(64) NOT NULL,
    changelog TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Katalog Metadata Dokumen Kantor On-Demand (PDF, Word, Excel)
CREATE TABLE IF NOT EXISTS knowledge_documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    article_id VARCHAR(100) NOT NULL,    -- Pemetaan ke ID artikel markdown lokal
    title VARCHAR(255) NOT NULL,
    file_type VARCHAR(10) NOT NULL,      -- 'pdf', 'docx', 'xlsx'
    file_id UUID,                        -- Merujuk ke directus_files(id)
    download_url TEXT,
    byte_size BIGINT NOT NULL,
    sha256_checksum VARCHAR(64) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Sinkronisasi Bookmark Pengguna
CREATE TABLE IF NOT EXISTS user_bookmarks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,               -- Merujuk ke directus_users(id)
    article_id VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    CONSTRAINT unique_user_article_bookmark UNIQUE(user_id, article_id)
);

-- 4. Sinkronisasi Catatan Pengguna (Outbox Target)
CREATE TABLE IF NOT EXISTS user_notes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,               -- Merujuk ke directus_users(id)
    article_id VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    client_updated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indeks Performa Sinkronisasi Cepat
CREATE INDEX IF NOT EXISTS idx_user_notes_sync ON user_notes(user_id, updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_user_bookmarks_user ON user_bookmarks(user_id);
CREATE INDEX IF NOT EXISTS idx_knowledge_releases_active ON knowledge_releases(is_active, version_code DESC);
