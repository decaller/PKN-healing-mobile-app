# Analisis Kebutuhan Backend v1 — PKN Healing Mobile App

Tanggal: 11 Oktober 2026. Status: **layanan sinkronisasi event telah diimplementasikan**; rancangan backend produk yang lebih luas di bawah ini tetap analisis dan rekomendasi.

## 1. Kesimpulan

Backend paling dibutuhkan untuk **mengelola dan mendistribusikan konten edukasi terverifikasi**. SOP krisis, dalil, episode, skenario, serta refleksi tetap dijalankan lokal. Server tidak boleh menjadi prasyarat membuka bantuan krisis atau tempat menyimpan curhat.

Analisis mencakup konteks produk dan prototype v0–v4. v4 menjadi acuan alur terbaru; v0 dan v3 menjadi bukti persistensi lokal yang sudah ada. Folder `backend v1` kini juga berisi API baca-saja untuk prototype `Event v1`; bukan implementasi CMS, akun, reservasi, atau E-pass.

Penanda dalam dokumen:
- **Fakta:** ditemukan pada kode atau dokumentasi yang dirujuk.
- **[INFERENCE]:** kebutuhan yang diturunkan dari fitur, belum merupakan implementasi atau keputusan produk.
- **Rekomendasi:** pilihan teknis yang diusulkan untuk implementasi berikutnya.

### Implementasi aktual: Wiki PKN Git mirror

`server.mjs` adalah server Node.js >=22 dengan HTTP bawaan, `marked`, `sanitize-html`, dan `yaml`. Server menyajikan `../wiki v1` pada `/` dan API same-origin. Tidak membutuhkan Quartz build, database, akun, atau artikel dummy. Implementasi ini terpisah dari server event Python di bawah.

Jalankan `cd 'prototype/backend v1'`, `npm install`, lalu `npm start`. Buka `http://127.0.0.1:8787`. `.env` opsional mengikuti `.env.example`: `WIKI_SOURCE_PATH` default `/home/abuhafi/Project/wiki-pkn`, `WIKI_SYNC_INTERVAL_SECONDS` default 300 (integer 1–86400), `PORT` default 8787, `HOST` default `127.0.0.1`, dan `WIKI_GIT_REF` opsional berupa `refs/remotes/origin/<branch>`.

Startup membaca commit `HEAD` lokal tanpa menunggu jaringan; berkas working tree yang belum di-commit tidak dipublikasikan. Manifest menyatakan provenance `source:{path,mode,ref,commit}`. Fetch origin dijalankan segera dan periodik. Ref mengikuti upstream origin cabang aktif (main maupun v5) atau override eksplisit. Tanpa upstream server mempertahankan HEAD dan melaporkan masalah. Fetch memperbarui objek Git/remote-tracking ref saja: tidak pull, reset, checkout, atau mengubah berkas sumber/cabang lokal. Artikel dan media dibaca dari blob commit, bukan working tree. Snapshot pengganti dipublikasikan atomik setelah parse/render berhasil; kegagalan mempertahankan snapshot sebelumnya dan mengisi `lastError`. Job tidak overlap. SIGINT/SIGTERM menghentikan timer/proses Git dan menutup HTTP server.

| GET endpoint | Respons |
|---|---|
| `/api/wiki/manifest` | `{version,articleCount,lastSyncedAt,source,intervalSeconds,lastError}`; version SHA commit |
| `/api/wiki/articles?q=&category=` | `{articles:[{id,title,category,summary,tags}],categories:[string]}` |
| `/api/wiki/articles/:id` | `{article:{id,title,category,summary,tags,html,sourcePath}}` |
| `/api/wiki/media/:id?v=<commit>` | Blob gambar yang direferensikan artikel publik pada snapshot saat ini |

ID adalah SHA-256 base64url path relatif artikel; stabil lintas revisi isi, berubah bila file dipindah. Kategori menggunakan frontmatter `category`, direktori pertama, atau `Umum` untuk root. Judul/ringkasan/tag memakai metadata opsional. Search AND kata meliputi judul, ringkasan, tag, dan teks. Flag draft/private/unpublished, published/publish/public false, atau status draft/unpublished/private/archived/review/pending mengecualikan artikel dari katalog dan resolver.

Markdown GFM serta Obsidian wikilink/alias dinormalisasi menjadi `#article=<id>`; nama ambigu tidak dipilih acak. Gambar relatif Markdown/Obsidian memakai endpoint media opaque (PNG/JPEG/WebP/GIF/AVIF). Raw HTML, script, iframe, atribut event, dan URL berbahaya tidak diteruskan. SVG korpus tidak dilayani. Embed canvas non-gambar menjadi label; link heading antarartikel membuka artikel terkait tanpa pemetaan heading khusus frontend. Static serving dibatasi realpath/ekstensi di frontend; media memakai blob ID dari snapshot, bukan path request.

Error JSON: 400 query/path invalid, 404 resource/route tidak ditemukan, 405 selain GET/HEAD, 503 tanpa snapshot. Query q dibatasi 500 karakter dan category 200; duplikasi/parameter tidak dikenal ditolak.

Verifikasi integrasi 11 Oktober 2026: `npm install` dan `npm start` berhasil; sumber nyata menghasilkan 643 artikel dari `origin/main` dengan interval 300 detik dan `lastError:null`. Browser mobile 390×844 dan desktop 1280×900 menjalankan beranda, pencarian, kategori, detail artikel, serta kembali. Beranda menampilkan 6 artikel; direktori 24 per batch dan tombol berikutnya membuka 48. Pencarian `tiga bahasa` menghasilkan 289 artikel karena AND kata pada isi, bukan pencarian frasa. Filter Panduan menghasilkan 6 artikel. Banner sumber merespons 200, query duplikat 400, ID tidak dikenal 404, POST 405, traversal media 404.

Smoke Git terisolasi lulus 34 assertion pada interval 1 detik: ingest awal 2 artikel dengan draft dikecualikan, push tambahan menjadi 3, update menjaga ID dan mengganti judul/HTML, delete menjadi 2 dan detail 404. Fetch gagal mempertahankan snapshot terakhir serta mengisi `lastError`; setelah pemulihan dan penghapusan seluruh artikel, katalog menjadi kosong dan versi maju. HEAD lokal dan perubahan working tree sumber tetap utuh. Server fixture dan berkas sementara dihapus. Ini verifikasi prototipe, bukan bukti kesiapan deployment produksi.

Frontend menggunakan template warna/tipografi Wiki v2, metadata nyata, daftar isi, dan status sinkronisasi. Tailwind/DaisyUI serta font Google dimuat dari CDN; CSS lokal menjaga layout dasar tanpa CDN. Embed canvas/iframe tidak dirender; tautan heading lintas artikel belum memilih heading tujuan.


### Implementasi aktual: mirror event publik

`event_server.py` menggunakan Python **3.10+**, tanpa dependency pihak ketiga. Data diambil langsung dari [homepage PKN](https://karakternabawiyah.com/) dan endpoint publik [WordPress pages](https://karakternabawiyah.com/wp-json/wp/v2/pages). Tidak ada event contoh, slug acara tetap, atau daftar produk yang disalin sebagai agenda.

Jalankan dari root repositori:

```bash
python3 "prototype/backend v1/event_server.py"
```

Default: `http://127.0.0.1:8081`, sinkronisasi segera di thread latar saat startup, lalu setiap 3.600 detik setelah percobaan terakhir selesai. Server dapat segera menyajikan cache sebelumnya; sebelum sinkronisasi pertama berhasil daftar kosong dan status `waiting` adalah kondisi nyata, bukan data pengganti. Satu worker dan lock mencegah sinkronisasi tumpang tindih.

Konfigurasi flag (mengalahkan environment):

| Flag | Environment | Default |
|---|---|---|
| `--host` | `HOST` | `127.0.0.1` |
| `--port` | `PORT` | `8081` |
| `--interval` | `SYNC_INTERVAL_SECONDS` | `3600` detik |
| `--timeout` | `HTTP_TIMEOUT_SECONDS` | `20` detik per request eksternal |
| `--cache` | `EVENT_CACHE_PATH` | `.cache/events.json` di folder layanan |

Contoh akses perangkat LAN: `python3 "prototype/backend v1/event_server.py" --host 0.0.0.0 --port 8081 --interval 3600`. Ini server development baca-saja, bukan deployment produksi; batasi akses jaringan. Flutter memakai `--dart-define=API_BASE_URL=http://localhost:8081` (ganti hostname untuk emulator/perangkat fisik). CORS `*` disediakan untuk Flutter web, tanpa cookie/auth.

Kontrak HTTP JSON:

- `GET /events`: `{events: [...], sync: {...}}`.
- `GET /events/{id}`: `{event: {...}}`; ID stabil dari hash URL sumber; `404` untuk ID yang tidak ditemukan.
- `GET /events/{id}/image`: byte poster nyata dengan MIME image dan CORS, untuk Flutter web/CanvasKit tanpa bergantung pada CORS situs sumber. URL hanya diambil dari `imageUrl` event yang ada dalam cache, tidak menerima parameter URL arbitrer. URL awal dan setiap redirect dibatasi HTTPS hostname sumber, port standar, tanpa credential; hanya raster PNG/JPEG/WebP/GIF/AVIF, maksimal 8 MiB, memakai timeout eksternal terkonfigurasi. `404` bila event/poster tidak ada; `502` bila sumber poster gagal. Browser dapat menyimpan respons satu jam.
- `GET /health`: `{status: "ok" | "waiting", eventCount: number, sync: {...}}`. `ok` berarti ada snapshot sukses, **bukan** jaminan sumber masih segar; periksa `lastError` dan `lastSuccessAt`.
- `sync`: `lastSuccessAt`, `nextSyncAt`, `lastError`, `intervalSeconds`, `sourceUrl`. Timestamp UTC ISO 8601, nilai waktu belum tersedia `null`. `nextSyncAt` saat startup adalah jadwal percobaan segera; setelah percobaan selesai jadwal berikutnya dihitung kembali.
- Event: `id`, `title`, `summary`, `imageUrl`, `sourceUrl`, `registrationUrl`, `mapUrl`, `dateLabel`, `timeLabel`, `location`, `category`, `speakers`, `facilities`, `prices`, `content`. Field scalar yang tidak ditemukan `null`; koleksi yang tidak ditemukan `[]`. Semua teks berasal dari halaman sumber. Label tanggal/waktu/harga tidak dikonversi menjadi janji ketersediaan atau status tiket.

Penemuan: HTML detail dari tautan homepage yang teksnya persis `Event Terkini` diambil langsung terlebih dahulu. WordPress menjadi sumber penemuan tambahan: semua halaman (20 per request, pagination `X-WP-TotalPages`) dengan heading persis `Event`. Konten rendered WordPress menyediakan panel accordion lengkap dan judul kanonis. Produk dan halaman lain tanpa label event tidak dimasukkan. Acara yang dipromosikan homepage diurutkan pertama; tidak ada filter tanggal buatan.

Normalisasi: judul WordPress, paragraf deskriptif, poster/OG image, tautan registrasi/form dan peta, serta section berlabel tanggal, waktu, tempat, pemateri, fasilitas, dan kontribusi. Struktur accordion `wpr-acc-*`, kartu narasumber, dan kartu harga mengikuti markup situs yang diamati; HTML generik dengan label section tetap dapat menyumbang teks. CSS, script, SVG, header/navigation/footer tidak menjadi konten. `content` mempertahankan baris teks sumber untuk informasi yang tidak tersusun dalam field khusus.

Untuk HTML halaman lengkap, parser memilih konten di dalam `main`/`article` dengan ID artikel WordPress yang cocok dengan `data-elementor-id`; template Elementor yang disisipkan navigasi tidak dijadikan detail acara. Judul memakai judul WordPress bila tersedia, lalu metadata `og:title`, lalu heading pada konten acara.

Ketahanan: seluruh snapshot baru dibangun dahulu, ditulis ke temporary file pada direktori yang sama, di-flush/fsync, lalu `os.replace`. Snapshot memori diganti hanya sesudah cache tersimpan. Bila salah satu sumber penemuan gagal tetapi sumber lain berhasil, event nyata yang berhasil diambil diperbarui dan event cache yang belum ditemukan tetap dipertahankan; `lastError` mencatat sumber penemuan yang gagal. Bila semua sumber gagal, cache write gagal, atau hasil kosong, snapshot terakhir yang baik tidak ditimpa. Worker tetap mencoba pada jadwal berikutnya. Cache terakhir dimuat kembali saat restart. Batas respons eksternal 8 MiB per request, dengan timeout eksternal yang dapat dikonfigurasi.

Batas ekstraksi: WordPress API pages harus dapat diakses untuk scan penuh; outage API tidak menghalangi pengambilan HTML event dari homepage yang masih dapat diakses, tetapi event lain mungkin hanya tersedia dari cache. `lastSuccessAt` dapat terisi bersamaan dengan `lastError` jika refresh sumber berhasil sebagian. Post WordPress, halaman tanpa heading `Event` yang tidak ditautkan homepage, poster yang hanya berisi teks gambar, atau markup yang berubah tidak dapat dijamin terdeteksi/terstruktur. Tidak ada OCR, pembacaan Google Forms, validasi sisa kuota, registrasi internal, pembayaran, E-pass, atau admin CMS. Tautan eksternal tidak disubmit otomatis. Cache kosong saat semua sumber gagal tetap kosong dengan error yang terlihat; layanan tidak membuat data ilustrasi.

Tes deterministik parser, pengecualian produk, field kosong, dan preservasi snapshot/cache:

```bash
python3 -m unittest discover -s "prototype/backend v1" -p 'test_*.py' -v
```

Tes tidak membutuhkan internet. Untuk smoke test integrasi, jalankan layanan lalu baca `/health`, `/events`, dan satu `/events/{id}` aktual; periksa bahwa `lastSuccessAt` terisi dan `lastError` kosong. Rancangan bagian berikut bukan daftar fitur yang sudah diimplementasikan.

### Batas v1 yang direkomendasikan

1. Inti: CMS/editorial, katalog publik, paket konten berversi, aset, pencarian, serta pengelolaan akses admin.
2. Modul bersyarat: akun pengguna dan sinkronisasi bookmark/progres non-sensitif, hanya jika kelanjutan lintas perangkat dibutuhkan.
3. Modul bersyarat: agenda, reservasi, dan E-pass, hanya jika jalur agenda masuk rilis.
4. Tetap lokal: curhat, audio/transkrip, muhasabah pribadi, observasi anak nyata, kalkulator Mizan dan matriks Syakilah pribadi, serta eksekusi RPG.
5. Tidak dibutuhkan untuk inti v1: cloud AI, vector database, pembayaran, push notification, microservices, dan sistem kelas/lembaga. Ini bukan penghapusan roadmap; belum ada bukti kebutuhan operasionalnya pada prototype aktif.

## 2. Kondisi repositori saat ini

| Area | Fakta yang ditemukan | Implikasi |
|---|---|---|
| UI v4 | Flutter/Dart, Riverpod, Forui; navigasi shell berbasis index | Belum ada lapisan API domain pada kode v4 yang ditelusuri |
| Beranda v4 | Nama, rekomendasi, persentase dan aktivitas masih statis | Data tampilan tidak boleh dianggap hasil perhitungan backend |
| P3K/dalil/serial v4 | Konten Dart statis; bookmark dan slot bersifat sesi | Perlu katalog serta persistensi lokal sebelum menjanjikan resume |
| Sanctuary v4 | Refleksi scripted; bukan engine AI atau mikrofon aktif | Tidak membutuhkan endpoint chat cloud |
| Agenda/Wiki/Profil v4 | Placeholder pada shell | Kebutuhan modul berasal dari spesifikasi, bukan fungsi yang sudah hidup |
| Persistensi v0 | `StorageService` memakai SharedPreferences untuk onboarding, role/focus, bookmark dan lesson completion | Ada persistensi lokal nyata; bukan login atau cloud sync |
| Lesson bundle v0 | `rootBundle.loadString` dari aset JSON meskipun berada di folder `network` | Loader tersebut bukan client HTTP |
| v1/v3 | Dokumentasi menjelaskan persistensi lokal; v3 menyebut belum ada login/cloud sync/content backend | Jangan menyamakan localStorage dengan database server |
| Rencana teknologi | PocketBase untuk auth/master sync dan Qdrant untuk hybrid RAG pada TODO teknologi | Masih rancangan; checklist backend belum selesai |

Sebelum penambahan mirror event di folder ini, tidak ditemukan implementasi backend domain aktif pada penelusuran prototype. Saat ini `event_server.py` mengimplementasikan API event publik baca-saja yang dijelaskan di atas; backend domain edukasi, akun, dan reservasi pada analisis berikut belum diimplementasikan. Ini inspeksi repositori, bukan pemeriksaan layanan deployment di luar repositori.

Bukti: [pubspec v4](../v4/pubspec.yaml), [shell v4](../v4/lib/app/shell.dart), [beranda](../v4/lib/features/home/presentation/screens/home_screen.dart), [Sanctuary](../v4/lib/features/sanctuary/presentation/screens/ai_sanctuary_screen.dart), [storage v0](../v0/lib/core/storage/storage_service.dart), [loader bundle v0](../v0/lib/core/network/lesson_bundle_service.dart), [README v3](../v3/README.md), dan [TODO teknologi](../../docs/TODO_TES_TEKNOLOGI.md).

## 3. Pemetaan fitur ke kebutuhan backend

Semua rancangan server berikut berstatus **[INFERENCE]**, kecuali fakta kondisi UI yang disebutkan.

| Fitur/alur | Kebutuhan server | Tanggung jawab perangkat | Prioritas |
|---|---|---|---|
| Beranda | Katalog highlight, taksonomi, urutan editorial | Greeting, progres aktual lokal, rekomendasi berbasis preferensi lokal | Inti |
| P3K krisis dan dalil | SOP, metadata sumber, revisi, review/publikasi | Paket dasar bawaan, akses luring tanpa login, bookmark | Inti |
| Serial dan episode | Daftar serial, urutan episode, teks/media, paket skenario | Membaca, menyimpan posisi dan completion | Inti |
| Living RPG/laporan adab | Distribusi graf dan rubrik berversi | Engine, pilihan, save slot, ledger dan laporan lokal | Konten inti; engine bukan backend |
| Khazanah Wiki | Artikel, enam pilar, topik, relasi dalil | Cache dan pencarian lokal | Inti katalog; UI masih target |
| Mizan Fitrah/Syakilah TB-40 | Distribusi definisi/rubrik edukasi yang disetujui | Input, perhitungan dan hasil pribadi lokal | Konten bersyarat |
| Curhat AI/Muhasabah | Hanya distribusi panduan/model jika kelak diperlukan | Inferensi lokal, penyimpanan catatan privat, penghapusan buffer audio | Tidak ada upload curhat |
| Pencarian | Pencarian teks pada konten publik, filter jenis/pilar/topik | Indeks lokal untuk paket terunduh; hindari mengirim teks curhat sebagai query | Inti |
| Profil dan bookmark | Auth dan sync hanya untuk fitur lintas perangkat | Penggunaan anonim tetap tersedia | Bersyarat |
| Agenda/E-pass | Acara, jadwal, kuota, registrasi, tiket, check-in | Cache detail serta QR tiket | Bersyarat; UI masih placeholder |

Acuan alur A–E: [panduan v4](../v4/GUIDELINE_PENGEMBANGAN_DAN_BATASAN.md). Konteks persona: [README produk](../../README.md) dan [user journeys](../../docs/USER_JOURNEYS.md). Persona ayah/bunda/guru adalah segmentasi produk, **bukan hak akses server**.

## 4. Arsitektur dan pilihan teknologi

### Rekomendasi: satu backend modular, bukan microservices

Gunakan PocketBase sebagai kandidat awal, mengikuti arah repositori, untuk katalog, auth opsional, dan admin editorial. Tambahkan handler server untuk aturan yang tidak cukup diwakili collection rules: publikasi paket, sync berbasis revisi, dan transaksi reservasi bila agenda diaktifkan.

PocketBase belum menjadi keputusan implementasi final. Validasi dukungan versi, model deployment, restore, dan konkurensi terlebih dahulu. Backend relasional seperti PostgreSQL dengan API terpisah menjadi alternatif bila kebutuhan reservasi/multi-instance menuntutnya; tidak perlu mengganti arah stack hanya untuk katalog sederhana.

| Komponen | Peran | Kebutuhan v1 |
|---|---|---|
| PocketBase atau backend relasional ekuivalen | Data katalog, auth, aturan akses dan admin | Inti; pilihan final setelah validasi |
| Penyimpanan aset | Gambar/media/paket publik; metadata hash dan ukuran | Inti; file storage sederhana cukup untuk awal |
| CDN/object storage | Distribusi paket/media ketika trafik membutuhkannya | Opsional; bukan ketergantungan akses offline |
| Database lokal mobile | Konten unduhan, indeks, progress dan data privat | Wajib untuk offline-first; bukan database server |
| Qdrant | Retrieval semantik corpus publik | Tunda; pencarian teks lebih sederhana untuk v1 |
| AI/ASR/TTS lokal | Fitur Sanctuary masa depan | Modul perangkat; tidak lewat backend chat |

Pemisahan data:
- Server menyimpan materi publik dan, bila diaktifkan, data akun minimal atau registrasi acara.
- Perangkat menyimpan curhat, muhasabah dan data anak nyata. Data ini tidak ikut sync, log, crash report, ataupun backup server.
- Aset publik dapat diunduh dari server. Inferensi lokal tidak berarti bobot model harus selalu tertanam dalam binary; unduhan model dapat dirancang terpisah tanpa mengunggah input pribadi.

## 5. Model data yang diusulkan

Seluruh nama tabel/collection berikut adalah **rekomendasi**, bukan skema yang sudah tersedia.

### 5.1 Katalog dan editorial

| Entitas | Field inti | Relasi/aturan |
|---|---|---|
| `content_items` | id, slug, type, title, summary, locale, status, published_revision | Jenis: SOP, dalil, artikel, serial, episode; slug unik per locale |
| `content_revisions` | id, content_id, revision, schema_version, body, author_id, reviewer_id, timestamps | Revisi terpublikasi immutable; unik `(content_id, revision)` |
| `dalil_sources` | id, source_type, reference, narrator, arabic_text, translation, grading, reviewer | Pisahkan kutipan asli dari penjelasan; metadata sesuai jenis Quran/hadits |
| `content_source_links` | content_revision_id, source_id, context | Satu konten dapat merujuk beberapa sumber |
| `taxonomies` / `content_taxonomies` | id, parent_id, kind, label; content_id, taxonomy_id | Pilar/topik/fase edukasi; jangan memerlukan profil anak untuk filter |
| `serials` / `episodes` | content_id; serial_id, position, scenario_id | Urutan episode unik per serial |
| `scenarios` | id, revision, schema_version, graph_asset_id, review_status | Publikasi graf JSON setelah validasi node/choice |
| `assets` | id, storage_key, mime_type, bytes, sha256, license, version | Aset immutable per versi; periksa hak distribusi |
| `content_bundles` | id, version, schema_version, manifest, published_at | Manifest menunjuk revisi dan hash aset yang tepat |
| `editorial_audit` | actor_id, action, entity_id, revision, timestamp | Rekam perubahan/publikasi tanpa data pengguna privat |

Graf skenario dapat disimpan sebagai JSON berversi; tidak perlu memecah semua node menjadi tabel pada awal. Validator harus memeriksa ID unik, target pilihan yang valid, node awal, jalur penyelesaian, prasyarat dan kompatibilitas schema. Jangan mengasumsikan semua graf harus DAG jika mekanik mengizinkan pengulangan.

Bukti struktur domain: [skenario lokal v4](../v4/assets/data/scenarios/skenario_krisis_shalat_rumah.json). Karakter fiksi dalam skenario bukan profil anak nyata.

### 5.2 Akun dan sync opsional

- `users`: ID auth, email bila diperlukan, nama tampilan opsional, status, timestamps. Tidak menyimpan password mentah; gunakan mekanisme auth backend.
- `bookmarks`: `user_id`, `content_id`, `deleted_at`, `revision`; unik `(user_id, content_id)`.
- `reading_progress`: `user_id`, `episode_id`, `position`, `completed`, `revision`. Hanya progres baca non-sensitif yang disetujui untuk sync.
- `sync_operations`: operation ID dan hasil/revisi untuk deduplikasi dengan retensi terbatas.
- Persetujuan sync dipisahkan dari akses konten publik. Preferensi persona lokal tidak memberi izin admin.
- Save slot RPG dan ledger keputusan tetap lokal pada rekomendasi awal; jangan menyamakan progres baca dengan riwayat refleksi atau penilaian anak.

### 5.3 Agenda opsional

- `events`: judul, lokasi/tautan, zona waktu, waktu mulai/selesai, status, aturan pendaftaran.
- `event_sessions`: sesi acara bila memang ada.
- `seat_pools`: event, kategori kuota sesuai spesifikasi acara, capacity; tidak perlu mengumpulkan gender jika kategori pilihan sudah mencukupi.
- `registrations`: user/contact minimal, event, seat_pool, status, operation ID. Batasi pendaftaran aktif ganda sesuai aturan acara.
- `tickets`: registration, token acak atau payload bertanda tangan, status/revocation.
- `check_ins`: ticket, operator, timestamp; check-in sah hanya sekali.
- Akses pengelola dibatasi acara yang ditugaskan. Jangan menyimpan nama/email dalam QR terbuka.

## 6. Kontrak API awal

Endpoint berikut adalah **usulan kontrak**, bukan URL yang telah tersedia. Prefix `/api/v1`; bila memakai PocketBase, API collection bawaan dapat digunakan selama perilaku domain dan aturan akses setara. Jangan membangun wrapper forwarding tanpa kebutuhan.

| Method dan path | Fungsi | Akses |
|---|---|---|
| `GET /content` | Daftar konten terpublikasi, filter type/topic/pillar/locale | Publik |
| `GET /content/{id}` | Konten dan metadata sumber/revisi | Publik |
| `GET /serials/{id}/episodes` | Episode berurutan | Publik |
| `GET /bundles/manifest` | Versi paket, schema, ukuran/hash aset | Publik |
| `GET /bundles/{id}/versions/{version}` | Unduh paket immutable | Publik |
| `GET /search?q=...` | Cari konten publik; query dibatasi panjang | Publik |
| `POST /admin/content` | Buat draft | Editor |
| `POST /admin/content/{id}/reviews` | Catat review dan keputusan | Reviewer |
| `POST /admin/content/{id}/publications` | Publikasi revisi approved | Publisher |
| `POST /auth/registrations` / `POST /auth/sessions` | Registrasi/login bila akun diaktifkan | Publik, rate-limited |
| `DELETE /auth/sessions/current` | Logout/revoke session | Pemilik sesi |
| `GET /me` / `PATCH /me` / `DELETE /me` | Profil minimal dan hapus akun | Pemilik |
| `GET /me/sync?cursor=...` | Perubahan bookmark/progres dan tombstone | Pemilik, opsional |
| `POST /me/sync-operations` | Operasi sync dengan ID unik dan base revision | Pemilik, opsional |
| `GET /events` / `GET /events/{id}` | Agenda terpublikasi | Publik, opsional |
| `POST /events/{id}/registrations` | Reservasi kuota secara transaksional | Pengguna, opsional |
| `GET /me/tickets` | E-pass milik pengguna | Pemilik, opsional |
| `DELETE /registrations/{id}` | Batalkan sesuai aturan acara | Pemilik/operator, opsional |
| `POST /tickets/{id}/check-ins` | Validasi dan check-in sekali | Operator acara, opsional |

Aturan kontrak:
- Koleksi menggunakan pagination; usulan `limit` default 20, maksimum 100. Urutan harus stabil dengan ID sebagai tie-breaker.
- Timestamp server UTC ISO 8601; agenda menyimpan zona waktu untuk tampilan jadwal.
- `ETag`/`If-None-Match` untuk katalog dan manifest; versi lama paket tetap dapat digunakan sampai penggantinya valid.
- Identitas pemilik berasal dari sesi server, bukan `user_id` yang dipercaya dari body.
- Error konsisten: `code`, `message`, `field_errors` bila perlu, `request_id`; tanpa stack trace atau data privat.
- Status utama: `400` request rusak, `401` belum login, `403` tidak berhak, `404` resource tidak tersedia, `409` konflik revisi/kuota, `422` validasi domain, `429` pembatasan request.
- Tidak ada endpoint upload curhat, audio, transkrip, atau skor anak nyata.

## 7. Offline-first dan sinkronisasi

### Paket konten

1. Sertakan paket dasar P3K, dalil, font dan skenario yang diperlukan dalam aplikasi. First launch tanpa internet tetap memiliki bantuan krisis.
2. Saat online, cek manifest tanpa menghalangi UI; unduh perubahan ke area sementara.
3. Verifikasi ukuran, hash, schema dan referensi graf sebelum aktivasi.
4. Ganti versi aktif secara atomik. Unduhan terputus atau paket rusak tidak boleh menghapus paket valid sebelumnya.
5. Kunci sesi RPG ke versi skenario saat sesi dibuat. Update katalog tidak memindahkan node sesi lama secara diam-diam.
6. Pencabutan materi bermasalah ditandai pada manifest berikutnya. **Batas:** perangkat yang terus offline tidak dapat menerima koreksi segera; hindari menjanjikan pencabutan instan.

### Sync opsional

- UI membaca database lokal; perubahan bookmark/progres masuk antrean lokal bila pengguna mengaktifkan sync.
- Setiap operasi membawa ID unik dan base revision. Server menetapkan revision/cursor; jam perangkat tidak menjadi otoritas konflik.
- Operasi ulang tidak menghasilkan duplikasi. Perubahan dengan revision lama menghasilkan konflik eksplisit dan state terkini untuk rekonsiliasi.
- Penghapusan bookmark menghasilkan tombstone agar item tidak muncul kembali dari perangkat lama. Retensi tombstone dan batas umur cursor harus ditetapkan sebelum implementasi; cursor kedaluwarsa memerlukan snapshot ulang.
- Completion dapat bersifat monotonic hanya jika produk memang tidak memiliki reset. Posisi baca/reset harus memiliki aturan konflik terpisah, bukan mengambil nilai terbesar secara buta.
- Logout memutus antrean dari akun sebelumnya. Perpindahan akun tidak boleh mencampur bookmark/progres; impor data anonim harus merupakan tindakan eksplisit.
- Migrasi SharedPreferences memakai ID konten stabil dan pemetaan yang jelas. Persentase mock v4 bukan data yang layak dimigrasikan.

### E-pass opsional

Tiket tersimpan lokal dapat ditampilkan offline. Scanner offline dapat memeriksa tanda tangan dan daftar pencabutan yang terakhir disinkronkan, tetapi **tidak dapat menjamin pencegahan pemakaian ganda lintas scanner yang tidak terhubung**. Untuk jaminan check-in sekali secara global, gunakan server online atau satu otoritas scanner lokal yang tersinkron; ini keputusan operasional sebelum agenda dirilis.

## 8. Aturan domain penting

### Publikasi konten

Alur: draft, review, approved, published, lalu archived bila tidak lagi digunakan. Editor tidak boleh melewati reviewer untuk publikasi. Reviewer memastikan keaslian kutipan, nomor/sumber yang sesuai, keselamatan pengasuhan, dan disclaimer non-klinis. Server memvalidasi metadata dan state transisi; verifikasi kebenaran agama tetap tanggung jawab reviewer manusia, bukan AI.

Kutipan asli tidak diparafrase oleh sistem. Simpan penjelasan terpisah dari teks kutipan. Revisi yang telah published tidak ditimpa; koreksi membuat revisi baru. Materi krisis harus memprioritaskan keselamatan dan tidak mengesankan aplikasi sebagai layanan medis/darurat.

### Reservasi acara

Jika modul diaktifkan, kapasitas dan registrasi harus berubah dalam satu transaksi. Tidak boleh menghitung sisa kursi hanya di client. Permintaan ganda memakai operation ID; pembatalan mengembalikan kursi sekali saja. Check-in menguji status tiket, kewenangan operator, pencabutan, dan keunikan dalam transaksi. Kebijakan deadline, daftar tunggu, serta registrasi tanpa akun belum ditetapkan; jangan mengarang pembayaran atau seat hold tanpa kebutuhan produk.

### Peran dan otorisasi

- Pengunjung: konten published saja, tanpa akun.
- Pengguna: data akun/bookmark/progres/tiket sendiri bila modul aktif.
- Editor: draft dan revisi konten.
- Reviewer/publisher: review dan publikasi sesuai kewenangan.
- Operator acara: registrasi/check-in untuk acara yang ditugaskan.
- Admin: pengaturan akses dan sistem; bukan akses universal ke catatan batin karena catatan tersebut tidak berada di server.

## 9. Privasi, keamanan, dan operasi

Acuan internal: [panduan v4](../v4/GUIDELINE_PENGEMBANGAN_DAN_BATASAN.md) dan [compliance/architecture](../../COMPLIANCE_AND_ARCHITECTURE.md). Dokumen tersebut adalah arahan proyek, bukan sertifikasi kepatuhan hukum atau jaminan layanan darurat masih aktif.

| Data | Lokasi yang direkomendasikan | Batas |
|---|---|---|
| Konten edukasi dan sumber | Server + cache lokal | Publik setelah review |
| Curhat, transkrip, muhasabah | Perangkat | Tidak dikirim ke backend/analytics |
| Audio curhat | Buffer memori sementara | Dokumen compliance melarang audio ke disk; hapus setelah transkripsi |
| Observasi/profil anak nyata | Perangkat | Tidak menjadi profiling server |
| Bookmark/progres baca | Lokal; server hanya dengan sync opt-in | Tidak mencakup ledger refleksi |
| Email/registrasi/tiket | Server jika modul aktif | Minimalkan field dan akses |
| Query pencarian | Lokal jika memungkinkan | Jika server, jangan log query mentah; query dapat sensitif |

Ada ketegangan antara panduan v4 yang menyebut rekaman dapat diakses luring dan compliance yang melarang audio curhat disimpan ke disk. Rekomendasi konservatif: **fitur suara berjalan offline, tetapi rekaman tidak diarsipkan**; catatan teks privat lokal dapat disimpan sesuai pilihan pengguna. Kebijakan final perlu diputuskan sebelum fitur suara dibuat.

Kontrol minimum:
- HTTPS, secret hanya di server, admin tidak membawa superuser credential di aplikasi mobile.
- Aturan akses server untuk setiap koleksi, validasi schema/body/file, batas ukuran upload, dan pembatasan auth/search/admin.
- Proteksi sesi dan penyimpanan token di secure storage perangkat bila auth aktif; pemulihan akun dan pencabutan sesi harus dirancang bersama auth.
- Log metadata request/error tanpa body privat, token, query mentah, atau isi catatan. Crash reporting tidak boleh mengambil isi layar/input Sanctuary.
- Backup database dan aset, enkripsi/akses terbatas, serta latihan restore. Tetapkan target pemulihan dari kebutuhan operasional, bukan angka yang belum diukur.
- Retensi data akun/event, log, tombstone dan backup harus tertulis sebelum produksi. Penghapusan akun menghapus/menganonimkan data terkait sesuai kewajiban yang disetujui; jelaskan masa kedaluwarsa backup.
- Monitoring health, kegagalan distribusi paket, error rate, kapasitas storage, dan konflik reservasi bila ada. Tidak memerlukan telemetry pribadi untuk menjalankan katalog.
- Lingkungan development/staging/production terpisah; data staging sintetis, bukan curhat atau data anak pengguna.

## 10. Urutan implementasi dan kriteria penerimaan

| Tahap | Hasil | Bukti penerimaan yang diperlukan |
|---|---|---|
| 1. Kontrak konten | Taksonomi, ID stabil, schema graf/manifest, review workflow | Draft tidak terlihat publik; kutipan/sumber wajib sebelum publikasi |
| 2. Katalog backend | CMS, API published-only, aset dan paket immutable | Client anonim menerima paket valid; akses admin/editor salah ditolak |
| 3. Integrasi mobile | Repository lokal, paket dasar, downloader dan indeks lokal | Cold start tanpa internet membuka P3K; update terputus mempertahankan versi lama |
| 4. Konten serial/RPG | Paket graf tervalidasi dan versi sesi terkunci | Target node invalid ditolak; sesi lama tetap berjalan setelah update |
| 5. Akun/sync, jika disetujui | Auth dan sync subset non-sensitif | Akun A tidak membaca akun B; operasi ulang tidak duplikat; tombstone tidak menghidupkan bookmark |
| 6. Agenda, jika disetujui | Kuota, registrasi, tiket dan check-in | Dua request untuk satu kursi tidak overbook; scan ganda online ditolak |
| 7. Operasi produksi | Backup/restore, kebijakan retensi dan akses | Restore memulihkan data serta aset; pemeriksaan traffic/log tidak menemukan curhat/audio |

Skenario tambahan sebelum rilis:
- Server tidak tersedia: bantuan krisis dan materi terunduh tetap terbuka.
- Paket rusak/schema tidak didukung: aktivasi ditolak tanpa kehilangan konten valid.
- Konten diarsipkan: bookmark tidak crash; informasi status ditampilkan saat perangkat menerima update.
- Akun dihapus atau diganti: token dan antrean sync tidak dapat mengirim data ke akun yang salah.
- Peninjauan sumber dan safeguarding menghasilkan jejak revisi yang dapat diaudit.

## 11. Keputusan produk yang masih terbuka

Ini prasyarat implementasi, bukan alasan menunda analisis:
1. Apakah rilis pertama hanya katalog atau juga akun/sync dan agenda? Inti katalog tetap bisa berjalan mandiri.
2. Siapa pemilik corpus, reviewer dalil/safeguarding, dan pemegang hak distribusi media?
3. Field apa yang boleh tersinkron dan bagaimana konflik reset/progres diputuskan?
4. Untuk agenda: aturan kuota, pembatalan, registrasi anonim, dan kebutuhan scanner offline versus jaminan anti-duplikasi?
5. Berapa skala konten/unduhan/registrasi bersamaan serta kebutuhan pemulihan? Ini menentukan apakah PocketBase cukup.
6. Berapa retensi akun/event/log/backup dan siapa operator data? Review hukum aktual diperlukan sebelum produksi.
7. Bagaimana definisi akses luring audio diselaraskan dengan zero-retention? Rekomendasi awal tidak menyimpan rekaman.

## 12. Referensi repositori

- [README produk](../../README.md): positioning dan persona.
- [User journeys](../../docs/USER_JOURNEYS.md): kebutuhan lintas segmen.
- [Panduan v4](../v4/GUIDELINE_PENGEMBANGAN_DAN_BATASAN.md): jalur A–E, offline-first, integritas dalil dan zero-cloud-leak.
- [TODO teknologi](../../docs/TODO_TES_TEKNOLOGI.md): arah PocketBase/Qdrant dan status pengujian rencana.
- [Compliance dan architecture](../../COMPLIANCE_AND_ARCHITECTURE.md): sensitivitas data dan batas non-klinis.
- [Storage service v0](../v0/lib/core/storage/storage_service.dart) dan [main v0](../v0/lib/main.dart): persistensi SharedPreferences.
- [Lesson bundle service v0](../v0/lib/core/network/lesson_bundle_service.dart): pemuatan asset lokal.
- [README v1](../v1/README.md) dan [README v3](../v3/README.md): batas prototype dan persistensi lokal.
- [Pubspec v4](../v4/pubspec.yaml) dan [shell v4](../v4/lib/app/shell.dart): dependensi dan placeholder.
- [Home v4](../v4/lib/features/home/presentation/screens/home_screen.dart): data beranda statis.
- [Sanctuary v4](../v4/lib/features/sanctuary/presentation/screens/ai_sanctuary_screen.dart): refleksi scripted.
- [P3K v4](../v4/lib/features/crisis/presentation/screens/p3k_crisis_screen.dart) dan [dalil v4](../v4/lib/features/crisis/presentation/screens/dalil_detail_screen.dart): konten dan state sesi.
- [Serial/episode v4](../v4/lib/features/stories/presentation/screens/serial_detail_episode_screen.dart): serial dan slot sesi.
- [Skenario v4](../v4/assets/data/scenarios/skenario_krisis_shalat_rumah.json): graf naratif lokal.

## 13. Pembaruan instalasi dan corpus desain v2

Backend nyata kini tersedia: `server.mjs` menyediakan mirror Wiki Git (default `127.0.0.1:8787`), sedangkan `event_server.py` menyediakan mirror event publik (default `127.0.0.1:8081`). Analisis kebutuhan di atas tetap merupakan target arsitektur, bukan pernyataan bahwa repositori tidak memiliki backend.

Alexandrie dipasang terpisah di [`alexandrie/`](alexandrie/README.md), frontend `http://localhost:8200`, API `http://localhost:8201`, RustFS `http://localhost:9005`. MySQL tidak diekspos. Semua port host bind `127.0.0.1`; secrets lokal berizin `0600`.

Workspace privat **PKN — Mockup Desain v2** berisi 49 dokumen dalam 11 kategori, meliputi seluruh layar HTML desain, token Earth-Tree, snapshot Wiki desain, dan kartu domain. Data fixture tidak mengganti mirror Wiki/event nyata. Profil/chat sintetis diberi label MOCKUP; kutipan sumber belum dianggap lolos review agama/safeguarding. Tanggal event 2025, harga, rating dan kuota bukan data operasional terkini.

Alexandrie dipakai sebagai knowledge workspace, bukan implementasi transaksi event, checkout buku, engine RPG, diagnosis suara, layanan AI, atau adapter API untuk aplikasi mobile. Kontrak paket dan integrasi client pada bagian sebelumnya belum otomatis dipenuhi oleh instalasi ini.

Gap desain yang tercatat: taxonomy enam rumpun katalog dan Wiki berbeda; progres `65%` versus `14/30`; serial home `Ep 3/8` versus lima episode detail; format/rating buku berbeda antarlayar. Klaim ambang Hz/nafs dan amigdala harus ditinjau sebelum publikasi, bukan dijadikan diagnosis.

