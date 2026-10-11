# Prototype v4 — PKN Healing Mobile App (Earth-Tree Native Prototype)

> **Implementasi Prototipe Mobile Native Berbasis Ekosistem Forui & Desain Earth-Tree**  
> *Referensi Konsep & Evaluasi UX:* [`prototype/v2/FLUTTER_ANALISIS_DAN_REKOMENDASI.md`](../v2/FLUTTER_ANALISIS_DAN_REKOMENDASI.md)  
> *Panduan Pengembangan & Batasan:* [`GUIDELINE_PENGEMBANGAN_DAN_BATASAN.md`](./GUIDELINE_PENGEMBANGAN_DAN_BATASAN.md)  
> *Katalog Referensi Desain Stitch:* [`STITCH_DESIGN_REFERENCES.md`](./STITCH_DESIGN_REFERENCES.md)  
> *Spesifikasi Desain Asli:* Earth-Tree (`prototype/v2/design/earth_tree/DESIGN.md`)

---

## 1. Filosofi & Keputusan Arsitektural

Prototipe `v4` dibangun dengan prinsip arsitektural yang tegas:

1. **Pemisahan Konsep dan Implementasi:**
   - Direktori [`prototype/v2`](../v2/) dipertahankan secara utuh sebagai rujukan konsep, mockups HTML/CSS Tailwind, dan catatan evaluasi arsitektural.
   - Direktori [`prototype/v4`](./) adalah basis kode Flutter mobile kanonikal untuk prototipe interaktif native.
2. **Zero-Material & Zero-Cupertino:**
   - Aplikasi tidak menggunakan styling stock Android Material 3 (menghilangkan ripple effect, surface tint, dynamic M3 purple/blue tones, FAB default).
   - Aplikasi tidak menggunakan komponen stock Apple Cupertino (menghindari bias platform iOS).
   - Seluruh UI dibungkus oleh **Forui** (`forui: ^0.11.1`), library UI platform-agnostic terinspirasi dari filosofi `shadcn/ui`, yang di-skinning 100% dengan token palet dan lekukan *Earth-Tree*.
3. **Standar Ikonografi Forui: Iconoir (`iconoir_flutter`):**
   - Menggunakan `iconoir_flutter: ^7.11.0` sebagai standar tunggal ikonografi.
   - Garis stroke tipis 1.5px/2px Iconoir memberikan kesan tenang (*mindful*), tidak membebani mata (*low cognitive noise*), dan menyatu dengan garis batas `1px solid tactileBorder` milik Earth-Tree.
4. **Penolakan `fluttersdk_wind`:**
   - Styling Tailwind pada prototipe web dipetakan langsung ke widget native Dart/Forui.
   - Menghindari overhead parsing string class di runtime mobile serta mempertahankan *compile-time type safety* dan *tree-shaking* penuh.

---

## 2. Fitur yang Aktif di Prototipe v4

Halaman beranda [`HomeScreen`](lib/features/home/presentation/screens/home_screen.dart) di dalam shell navigasi [`AppShell`](lib/app/shell.dart) telah mengimplementasikan 8 komponen utama:

1. 🌿 **Header Salam & Amanah Status ([`HeaderGreeting`](lib/features/home/presentation/widgets/header_greeting.dart)):**
   - Salam personal, foto profil pengasuh, dan badge status *Enkripsi On-Device Amanah* (luring & privat).
   - Quick toggle tema (Light Mode / Dark Mode) langsung dari header.
2. 🔍 **Dynamic Search Ticker & PTT Curhat ([`SearchTickerBar`](lib/features/home/presentation/widgets/search_ticker_bar.dart)):**
   - Ticker teks pertanyaan parenting yang berganti otomatis setiap 15 detik menggunakan transisi fade/slide yang tenang (*thuma'ninah*).
   - Tombol PTT Walkie-Talkie beranimasi denyut lembut (*pulsing*) dengan feedback getar haptic.
   - Bottom sheet modal perekaman suara PTT sekali sentuh.
3. 🌟 **Highlights Carousel 16:9 ([`HighlightsCarousel`](lib/features/home/presentation/widgets/highlights_carousel.dart)):**
   - Banner agenda daurah & webinar rasio 16:9 dengan metadata lokasi/format yang terlindungi dari resiko flex overflow.
4. 📋 **Langkah Harian Carousel ([`DailyActivityCarousel`](lib/features/home/presentation/widgets/daily_activity_carousel.dart)):**
   - Kartu aktivitas harian ringkas dengan indikator progres horizontal dan micro-task audio refleksi.
5. 🍱 **Bento Features Grid ([`BentoFeaturesGrid`](lib/features/home/presentation/widgets/bento_features_grid.dart)):**
   - Tata letak bento 2-kolom asimetris untuk fitur utama (*Ruang Curhat AI Sanctuary*, *Khazanah Syakilah*, *Webinar Interaktif*, dan *SOP Tantrum P3K*).
6. 📖 **Multi-Serial Interactive Story ([`MultiSerialStoryCard`](lib/features/home/presentation/widgets/multi_serial_story_card.dart)):**
   - Kartu serial cerita simulasi pengasuhan (*Pintu Maghrib Zaid*).
   - Matrix indikator milestone adab kualitatif (*Belum Tampak [BT]*, *Mulai Tampak [MT]*, *Berkembang [BK]*, *Membudaya [MM]*).
   - Indikator halaman halus berbasis [`smooth_page_indicator`](https://pub.dev/packages/smooth_page_indicator).
7. 🧰 **P3K & Practical Instrument Grid ([`P3kInstrumentGrid`](lib/features/home/presentation/widgets/p3k_instrument_grid.dart)):**
   - Peluncur cepat 3-kolom untuk instrumen darurat: *SOP Tantrum 10 Detik*, *Kalkulator Mizan Fitrah*, dan *Rapor Bakat TB-40*.
8. 🪟 **Floating Frosted Glass Bottom Dock ([`AppShell`](lib/app/shell.dart)):**
   - Dock navigasi mengambang berkaca (*acrylic frosted blur*) dengan 5 tab Iconoir: *Beranda*, *Agenda*, *Curhat AI*, *Khazanah*, dan *Akun*.

---

## 3. Struktur Direktori

```
prototype/v4/
├── assets/
│   └── data/scenarios/skenario_krisis_shalat_rumah.json
├── lib/
│   ├── app/
│   │   ├── shell.dart            # Frosted glass floating navigation dock
│   │   └── theme.dart            # Root AppTheme (NoSplash, Zero-Material ripple)
│   ├── core/
│   │   └── theme/
│   │       ├── earth_tree_colors.dart   # ThemeExtension palet Earth-Tree
│   │       ├── earth_tree_forui.dart    # Builder tema Forui (FThemeData)
│   │       ├── theme_extensions.dart    # BuildContext syntactic helpers
│   │       └── typography.dart          # Plus Jakarta Sans & Merriweather
│   ├── features/
│   │   └── home/
│   │       └── presentation/
│   │           ├── screens/
│   │           │   └── home_screen.dart # Beranda multi-seksi
│   │           └── widgets/
│   │               ├── bento_features_grid.dart
│   │               ├── daily_activity_carousel.dart
│   │               ├── header_greeting.dart
│   │               ├── highlights_carousel.dart
│   │               ├── multi_serial_story_card.dart
│   │               ├── p3k_instrument_grid.dart
│   │               └── search_ticker_bar.dart
│   └── main.dart                 # Root entrypoint + Riverpod + Forui FTheme
├── test/
│   └── widget_test.dart          # Smoke test widget rendering
└── pubspec.yaml
```

---

## 4. Cara Menjalankan & Pengujian

### Prasyarat
- Flutter SDK (3.29.0+) terpasang di sistem (`/home/abuhafi/flutter/bin/flutter`).

### Verifikasi Statis & Unit Test
```bash
cd prototype/v4
flutter analyze
flutter test
```
*Status saat ini: **0 lint issues**, **100% tests passed**.*

### Menjalankan Aplikasi
```bash
# Web Server
flutter run -d chrome

# Mobile Device / Emulator
flutter run
```
