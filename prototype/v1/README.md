# v1 — PKN Microlearning Web Prototype & Device Preview

Prototipe web interaktif aplikasi **PKN Healing Mobile App** yang dijalankan di browser dengan wrapper [`device_preview`](https://pub.dev/packages/device_preview). Memungkinkan evaluasi antarmuka, pengujian alur persona, dan iterasi cepat lintas perangkat (iPhone 13, iPad, Android) secara langsung tanpa emulator fisik.

Basis kode mobile kanonikal native tetap dipertahankan di [`prototype/v0/`](../v0/).

---

## Fitur yang Aktif di Prototipe v1

1. 🎯 **Alur Onboarding JTBD 4 Langkah**: Diagnostik amanah peran tarbiyah (Ayah, Ibu, Guru Karakter, Mudir, Santri, Mandiri) dengan komputasi arketipe otomatis.
2. 💡 **Kartu Wawasan Aktivasi (`ActivationalInsightScreen`)**: Rekomendasi pilar MOC awal pasca-diagnostik.
3. 📰 **Feed Penjelajahan Berbasis Kartu (*Deepstash Model*)**: Filter 6 Pilar MOC (`P1` s.d. `P6`), pencarian teks, dan bookmarking luring.
4. 📚 **Pemain Pelajaran Interaktif 5 Langkah (*Google Primer Model*)**: Dukungan `TextStepView`, `MultipleChoiceStepView`, `SwipePollStepView`, dan `FillInBlankStepView`.
5. 📊 **Laporan Pertumbuhan Adab Kualitatif (`AdabGrowthReportScreen`)**: Rubrik evaluasi adab non-gamifikasi (`BT - MT - BK - MM`).
6. 📱 **Mobile Device Preview Toolbar**:
   - Pemilihan bingkai perangkat (Apple iPhone 13 default, Android, Tablet).
   - Pengalihan orientasi (Portrait / Landscape).
   - Pratinjau tema (Dark Mode / Light Mode).
   - Simulasi keyboard virtual dan accessibility font scaling.
7. 💾 **Persistensi Luring**: Menggunakan `SharedPreferences` yang terpetakan otomatis ke browser `localStorage`.
8. 🔬 **Minimal Sandbox Demo**: Tersedia modul hello-world terisolasi di [`lib/demo/hello_world_app.dart`](lib/demo/hello_world_app.dart).

---

## Menjalankan Pratinjau Lokal & Tailscale

Dari root repositori:

```bash
cd prototype/v1
flutter pub get

# Opsi 1: Menggunakan skrip terintegrasi Tailscale (port 3001)
./run_web.sh

# Opsi 2: Perintah manual Flutter
flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8181
```

### URL Akses

| Jalur Akses | Alamat URL | Keterangan |
| :--- | :--- | :--- |
| 🔒 **Tailscale MagicDNS (HTTPS)** | [**`https://cachyos-5600gt.tail0faa6b.ts.net/`**](https://cachyos-5600gt.tail0faa6b.ts.net/) | Akses dari HP / iPad / PC di tailnet via Tailscale Serve (SSL valid otomatis) |
| 📶 **Tailscale Direct IP** | `http://100.118.34.69:8181/` | Akses IP Tailscale perangkat (`cachyos-5600gt`) |
| 🌐 **Local Workstation** | `http://localhost:8181/` atau `http://localhost:3001/` | Akses langsung di mesin lokal |

> **Catatan:**
> - Di mesin lokal ini, biner SDK berada di `/home/abuhafi/flutter/bin/flutter`.
> - Untuk hot restart, tekan `r` pada terminal yang sedang menjalankan flutter.
> - Pada mode rilis (`kReleaseMode`), wrapper `DevicePreview` dinonaktifkan secara otomatis dan aplikasi merender layar penuh.

---

## Pratinjau Material & Cupertino

Satu `MaterialApp.router`, router, dan state Riverpod tetap digunakan. Komponen Flutter bawaan mengadaptasi bilah navigasi, tab, tombol, pencarian, pilihan, switch, slider, dan modal; tidak ada dependensi `adaptive_platform_ui` atau duplikasi layar.

- **Automatic** mengikuti platform Flutter: Cupertino pada iOS/macOS, Material pada platform lain. Dalam DevicePreview, platform perangkat simulasi digunakan; iPhone default menampilkan Cupertino.
- Toolbar web menyediakan **Automatic / Material / Cupertino** dan **Light / Dark / System** tanpa mereset state aplikasi. Default warna adalah **Dark**.
- Palet Earth-Tree dan tipografi berasal dari token bersama `lib/app/theme/`; `AppTheme.create` memetakannya ke Material dan Cupertino. `FTheme` menggunakan token yang sama di dalam builder DevicePreview, mengikuti brightness efektif dan pilihan tema/style yang sudah ada.
- Query URL mengatur pilihan awal. Letakkan query sebelum rute hash:

```text
http://localhost:8181/?style=material&theme=light#/feed
http://localhost:8181/?style=cupertino&theme=dark#/feed
http://localhost:8181/?style=auto&theme=system
```

Wrapper adaptif berada di `lib/core/widgets/pkn_adaptive.dart`. Konten, controller, persistensi, dan alur pelajaran tetap dibagikan; hanya presentasi platform yang berbeda. Umpan balik Cupertino menggunakan dialog dengan tombol **OK**, sedangkan Material menggunakan snackbar. Audio dan berbagi tetap simulasi prototipe.

---

## Tema Earth-Tree & Forui

Perintah setup yang didukung Forui CLI terpasang (`forui: ^0.11.1`), dijalankan dari `prototype/v1`:

```bash
flutter pub add forui
dart run forui --no-input init
dart run forui theme ls
dart run forui theme create blue --output lib/core/theme/earth_tree_forui.dart
```

`dart run forui init --preset bowded` tidak didukung: CLI ini tidak menyediakan opsi `--preset`, dan `bowded` tidak terdapat dalam daftar tema. Tema yang tersedia adalah blue, green, orange, red, rose, slate, violet, yellow, dan zinc. Setup memakai blue sebagai sumber generator, bukan pemasangan bowded. Jangan menjalankan ulang `theme create` pada file kustom tanpa menyimpan perubahan Earth-Tree.

`lib/core/theme/earth_tree_forui.dart` telah dikustomisasi menjadi `earthTreeLight` / `earthTreeDark` dan dipasang melalui `FTheme` pada app builder. Warna light mengikuti token frontmatter desain Earth-Tree; fondasi dark memakai basalt `#161A1D`, slate `#1E2328`, granite `#262D34`, chalk `#EFECE6`, dan bone `#D3CEC4`. Heading menggunakan Merriweather, UI menggunakan Plus Jakarta Sans melalui dependensi `google_fonts` yang sudah ada; teks Arab tetap Amiri. Font belum dibundel sebagai aset, sehingga pengunduhan pertama memerlukan jaringan (cache Google Fonts dipakai pada pemakaian berikutnya).

Material dan Cupertino tetap menggunakan widget adaptif yang sama, dengan tombol/input radius 8px, kartu 16px, modal 24px, dan chip kapsul. Router, state Riverpod, pilihan Automatic/Material/Cupertino, serta Light/Dark/System tidak diganti. Token v1 ini dikustomisasi untuk Earth-Tree; generator lama `design/sync-tokens.mjs` berasal dari desain sebelumnya dan tidak boleh digunakan untuk menimpa tema v1 ini.

---

## Verifikasi Kualitas & Pengujian Otomatis

```bash
# 1. Analisis statis linter (target: 0 issues)
flutter analyze

# 2. Rangkaian uji otomatis (target: 13/13 passing)
flutter test
```

