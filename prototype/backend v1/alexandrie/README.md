# Alexandrie lokal

Stack resmi [Smaug6739/Alexandrie](https://github.com/Smaug6739/Alexandrie), berdasarkan [compose upstream](https://raw.githubusercontent.com/Smaug6739/Alexandrie/main/docker-compose.yml) dan [.env.example upstream](https://raw.githubusercontent.com/Smaug6739/Alexandrie/main/.env.example).

- Frontend: http://localhost:8200
- API: http://localhost:8201
- S3/RustFS: http://localhost:9005 (9000 sudah digunakan layanan lain).
- Semua port host hanya bind `127.0.0.1`; MySQL tidak diekspos.
- Compose project: `pkn-alexandrie`; tidak memakai `container_name` global.
- Secrets acak berada di `.env` lokal (mode `0600`, diabaikan Git). Jangan salin isinya ke log atau commit.
- Akun mockup lokal tersimpan di `.seed-account.json` (mode `0600`, diabaikan Git); password tidak dicetak oleh importer.

Jalankan dari folder ini:

```sh
docker compose -p pkn-alexandrie up -d --wait --wait-timeout 240
docker compose -p pkn-alexandrie stop
# Menghapus container/network tanpa menghapus data:
docker compose -p pkn-alexandrie down
# Status dan diagnosis:
docker compose -p pkn-alexandrie ps
docker compose -p pkn-alexandrie logs --tail 100
```

Volume MySQL dan RustFS tetap ada setelah `stop` atau `down`. Jangan gunakan `down -v` kecuali sengaja ingin menghapus data. SMTP tidak dikonfigurasi; pengiriman email/reset password via email tidak tersedia.

## Evidence instalasi

Instalasi 2026-10-11: frontend HTTP `200`, endpoint terproteksi `/api/nodes/user/1` HTTP `401` tanpa login (API aktif), RustFS `/health` HTTP `200`. MySQL dan RustFS healthy; frontend/backend running. `/api/` sendiri bukan route dan mengembalikan `404`.

Image yang benar-benar ditarik dan dijalankan:

| Image tag upstream | Repo digest terpasang |
| --- | --- |
| `ghcr.io/smaug6739/alexandrie-backend:latest` | `sha256:98dc218ea95645c57616f4af6f5af16bb70e8ef02da2963020d0eece901e3a18` |
| `ghcr.io/smaug6739/alexandrie-frontend:latest` | `sha256:6258f0de269145d60982444415ab2a03631935934c0e3845ce5df2c2d3b68c6f` |
| `mysql:8.0` | `sha256:7dcddc01f13bab2f15cde676d44d01f61fc9f99fe7785e86196dfc07d358ae2b` |
| `rustfs/rustfs:latest` | `sha256:1803faef57627e2d9c2e7d89d655d712ddded5389040054987163043fecb6a3c` |

RustFS image metadata menyebut versi `1.0.1`. Release Alexandrie terbaru saat instalasi adalah [v8.14.2](https://github.com/Smaug6739/Alexandrie/releases/tag/v8.14.2); image Alexandrie tidak memiliki label versi, sehingga digest di atas adalah identitas pasti instalasi. Compose mempertahankan tag upstream; menjalankan `pull` kemudian dapat mengganti image.

## Kontrak seed API

Prefix `/api`. Daftar akun melalui `POST /api/users` (JSON `username`, `email`, `password`; nama pengguna 5–30 karakter, password 4–50). Login `POST /api/auth` dengan form-urlencoded `username`/`password`; simpan cookies `Authorization` dan `RefreshToken`.

Node: `POST /api/nodes`, `GET /api/nodes/user/:userId`, `GET /api/nodes/:nodeId`, `PUT /api/nodes/:nodeId`, `DELETE /api/nodes/:nodeId`. `name` wajib, maksimum 50 karakter. `role`: 1 workspace, 2 category, 3 document, 4 resource. Buat parent dahulu lalu gunakan `parent_id`; ID dikirim sebagai string decimal untuk menjaga presisi Snowflake. `content` berisi Markdown, `content_compiled` string opsional, `metadata` objek JSON opsional. `accessibility`: 0 public, 1 private, 2 unlisted. API mengisi ID, pemilik, dan timestamp. Contoh node privat: `{"name":"Workspace","role":1,"accessibility":1,"access":0}`.

Kontrak berasal dari [node model](https://github.com/Smaug6739/Alexandrie/blob/main/backend/models/node.model.go), [node routes](https://github.com/Smaug6739/Alexandrie/blob/main/backend/router/routes/nodes.go), [auth controller](https://github.com/Smaug6739/Alexandrie/blob/main/backend/controllers/authentication.controller.go), dan [Snowflake](https://github.com/Smaug6739/Alexandrie/blob/main/backend/types/Snowflake.go).

## Corpus mockup desain v2

`mockup-data.json` memuat 49 dokumen dalam 11 kategori: seluruh 26 layar HTML, token Earth-Tree, snapshot Wiki yang tersedia di desain, serta kartu event, buku, episode, bakat, dan instrumen. Workspace: **PKN — Mockup Desain v2**. Seluruh node privat.

```sh
python3 seed_mockup.py
```

Importer memakai `metadata.pkn_seed_key` untuk menghindari duplikasi. Kredensial login tersedia hanya dalam `.seed-account.json`; jangan commit atau membagikan file tersebut. Respons API menggunakan envelope `result`. ID Snowflake tetap string.

Corpus ini bukan integrasi backend mobile: reservasi/checkout, engine RPG, generator AI, suara, dan sinkronisasi progres tidak dibuat oleh instalasi Alexandrie. Mirror Wiki Git (`../server.mjs`) dan event publik (`../event_server.py`) tidak diganti atau diisi dengan fixture ini.

Tanggal event 2025, harga, kuota, rating dan progres adalah mock historis. Profil dan percakapan adalah sintetis; tidak ada audio/curhat nyata diunggah. Materi agama disalin dari sumber desain, bukan dinyatakan lolos review. Klaim Hz/nafs dan amigdala bukan kemampuan diagnosis klinis.

Perbedaan yang perlu diselesaikan sebelum produksi: rumpun katalog TB-40 berbeda dari direktori Wiki; progres `65%` tidak sama dengan `14/30`; home menyebut serial `Ep 3/8`, detail serial memuat lima episode; rating dan format buku berbeda antarlayar. Token Earth-Tree disimpan sebagai referensi, bukan dipaksakan ke tampilan Alexandrie.

## Verifikasi corpus

Smoke browser: login akun seed berhasil, dashboard menampilkan 49 dokumen dan satu workspace; dokumen Beranda Carousel — Light menampilkan konten termasuk buku, serial dan rekomendasi generator. Pencarian `Mizan` memfilter navigasi ke dua dokumen instrumen yang berbeda (kartu dan detail). Screenshot diambil; inspeksi visual gambar tidak tersedia pada sesi ini, sehingga bukti render memakai DOM browser aktual.

API detail mengonfirmasi 49 dokumen memiliki `content_compiled`, 61 node seed privat, dan seluruh dokumen memiliki parent kategori valid. Profil sintetis bernama Demo Ayah. Import ulang terakhir: `created=0`, `skipped=61`, `repaired=0`, `renamed=0`; tidak ada duplikasi. Renderer menggunakan dependensi `marked` dan `sanitize-html` yang sudah tersedia di backend v1. Importer hanya memperbaiki compiled HTML kosong pada dokumen milik seed; konten terkompilasi yang sudah ada tidak ditimpa.

