# Event v1 — Agenda Karakter Nabawiyah

Prototype Flutter mandiri (`event_v1`) untuk agenda dan detail event. Desain mengikuti `prototype/v2/design/agenda_seluruh_event` dan `detail_majelis_daurah_akbar_parenting_nabawiyah`: palet Earth-Tree, font lokal Merriweather / Plus Jakarta Sans, ikon Iconoir, poster landscape, kartu membulat, serta aksi pendaftaran tetap di bagian bawah detail.

## Menjalankan web

Prasyarat: Flutter 3.29+ / Dart 3.7+ dan backend Event aktif pada port 8081. Dari root repositori:

```bash
cd "prototype/Event v1"
./run_web.sh
```

Buka `http://localhost:3011`. Launcher mencari Flutter di PATH, lalu `/home/abuhafi/flutter/bin`. Dependensi diambil otomatis oleh `flutter run`.

Konfigurasi opsional:

```bash
PORT=3011 HOST=0.0.0.0 API_BASE_URL=http://localhost:8081 ./run_web.sh
```

`API_BASE_URL` harus dapat dijangkau dari perangkat/browser, bukan hanya dari mesin yang menjalankan Flutter. Untuk akses LAN, gunakan alamat IP backend dan pastikan backend menerima koneksi serta mengizinkan CORS. Untuk web HTTPS, gunakan backend HTTPS agar tidak diblokir sebagai mixed content.

## Menjalankan mobile

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8081
```

Alamat di atas untuk emulator Android. Pada perangkat fisik gunakan IP LAN backend; simulator iOS dapat menggunakan `http://localhost:8081`. Android mengaktifkan izin internet dan HTTP cleartext; iOS mengaktifkan akses jaringan lokal dan pengecualian transport HTTP. Pengecualian ini hanya untuk prototype lokal: hapus sebelum rilis produksi dan gunakan HTTPS. Scaffold Android, iOS, dan web disertakan.

## Data dan interaksi

- `GET /events` memuat agenda dan status sinkronisasi; `GET /events/{id}` memuat detail.
- Poster dimuat melalui `GET /events/{id}/image` pada backend agar Flutter web dapat membacanya dengan CORS; endpoint hanya menggunakan poster milik event sumber yang tersimpan.
- Polling setiap 30 detik membaca hasil sinkronisasi backend, tanpa mengambil situs sumber langsung dari Flutter. Halaman agenda menampilkan waktu sinkronisasi terakhir dan berikutnya dalam zona waktu perangkat.
- Pencarian berdasarkan judul, ringkasan, pemateri, dan lokasi. Kategori berasal dari data API, bukan daftar kategori rekaan.
- Loading, gagal/koneksi terputus dengan tombol coba lagi, agenda kosong, serta hasil pencarian kosong memiliki tampilan tersendiri. Data terakhir tetap terlihat ketika refresh gagal.
- Detail mengambil informasi sumber terbaru; tombol peta, sumber resmi, dan pendaftaran hanya muncul jika tersedia URL HTTP/HTTPS yang valid. Kegagalan membuka tautan ditampilkan melalui pesan.
- Teks backend tampil sebagai teks biasa; markup dihapus dan tidak ada WebView/HTML renderer. Tidak ada event contoh, tanggal, kuota, status ketersediaan, harga, atau nama pemateri yang dibuat sendiri.
- Navigasi kembali menggunakan stack Flutter. Header dan area aksi menghormati safe area. Konten dibatasi lebarnya di desktop dan dapat di-scroll pada mobile.

## Struktur

- `lib/main.dart`: tema, agenda, detail, status UI, dan tautan eksternal.
- `lib/event_api.dart`: kontrak API, model sumber, dan pembatasan URL.
- `assets/fonts/`: font lokal dan lisensi dari prototype v4.
- `run_web.sh`: launcher web port 3011.
- `test/widget_test.dart`: tes model field kosong, teks biasa, dan URL eksternal.

## Verifikasi

```bash
flutter pub get
flutter analyze
flutter test
flutter build web --dart-define=API_BASE_URL=http://localhost:8081
```

Uji manual dengan backend aktif: cari event, pilih kategori, buka detail dan semua tautan yang tersedia; matikan backend untuk memastikan retry/data terakhir; periksa viewport mobile kecil, landscape, desktop, keyboard, dan teks sistem besar. Tidak ada hasil build atau pengujian yang diklaim dalam implementasi ini.
