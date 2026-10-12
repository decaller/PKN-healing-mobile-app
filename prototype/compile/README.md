# PKN Mobile App - Compiled Modular Architecture (`prototype/compile`)

> **Master Unified Flutter Prototype**: Penggabungan 12 prototipe PKN menjadi satu aplikasi mobile terintegrasi, modular, dan tangguh. Setiap fitur dapat dihidup-matikan (*feature toggled*) secara independen tanpa menimbulkan runtime error, layout overflow, ataupun app crash.

---

## 1. Ikhtisar Arsitektur Modular

Aplikasi ini menggabungkan seluruh kapabilitas eksplorasi dari repositori:
1. **v0**: Micro-Learning Google Primer player (`LessonPlayerScreen`, kuis interaktif, kartu uji intuisi).
2. **v1**: Sandbox Web & multi-device preview.
3. **v2**: Master Earth-Tree visual tokens, tipografi dual Merriweather/Plus Jakarta Sans.
4. **v3 & v4**: Forui UI framework, floating frosted glass navigation dock, Bento grid, Highlights & Daily carousel.
5. **v5**: Jurnal Adab Harian (`DailyTaskScreen`, evaluasi BT-MT-BK-MM), Relasi Qalbiyah (`RelationsProgressScreen`), dan Mizan Fitrah Balance scale.
6. **AI v1**: Teman Curhat AI (On-device Edge LLM / LiteRT / Gemma 270M/1B/E2B streaming) dan Walkie-Talkie Ruang Qalbu.
7. **Event v1**: Agenda & Majelis Akbar Parenting Nabawiyah (filter kategori, sinkronisasi jadwal).
8. **Wiki v1 & Backend v2**: Khazanah Fitrah dengan metadata provenance (*Pakar Terverifikasi* vs *Wiki-AI*) & LibSQL Vector Search.

---

## 2. Sistem Modular Feature Flags (`FeatureFlagsConfig`)

Setiap modul diisolasi di balik konfigurasi deklaratif `FeatureFlagsConfig` dan dikelola reaktif oleh Riverpod `featureFlagsProvider`:

```dart
class FeatureFlagsConfig {
  final bool enableCurhatAi;           // Teman Curhat AI (Edge LLM)
  final bool enableWalkieTalkie;       // Push-to-talk Walkie Talkie Ruang Qalbu
  final bool enableDailyTask;          // Jurnal Adab Harian (BT-MT-BK-MM)
  final bool enableRelationsProgress;  // Relasi Qalbiyah & Mizan Balance
  final bool enableEvents;             // Agenda & Majelis Parenting
  final bool enableKnowledgeWiki;      // Khazanah Fitrah (Wiki PKN)
  final bool enablePrimerLessons;      // Micro-learning Google Primer
  final bool enableP3kCrisis;          // Bantuan Darurat P3K Jiwa
  final bool enableChartsTestbed;      // Lab Visual Mizan & TB40
  final bool enableStories;            // Serial Kisah Pengasuhan
}
```

### Preset Cepat Tersedia:
- **`FeatureFlagsConfig.allEnabled()`**: Seluruh 10 modul aktif (10/10).
- **`FeatureFlagsConfig.minimalCore()`**: Hanya Beranda & P3K Jiwa aktif (1/10).
- **`FeatureFlagsConfig.aiFocused()`**: Beranda + Teman Curhat AI + Walkie-Talkie.
- **`FeatureFlagsConfig.learningFocused()`**: Beranda + Khazanah Wiki + Micro-Learning + Agenda.
- **`FeatureFlagsConfig.parentingAdabFocused()`**: Beranda + Jurnal Adab + Relasi Qalbiyah + Lab Mizan.

---

## 3. Ketahanan Modularitas (*Zero-Crash Guarantee*)

Ketika fitur dinonaktifkan:
1. **Dynamic Navigation Dock (`lib/app/shell.dart`)**:
   - Menghitung destinasi secara dinamis.
   - Mengeliminasi out-of-bounds index error dengan auto-clamp ke index 0 (Beranda).
   - Jika seluruh fitur opsional dimatikan, dock beralih ke mode 2 tab: `Beranda` dan `Modul` (Pengaturan).
2. **Dynamic Bento Grid (`lib/features/home/presentation/widgets/bento_features_grid.dart`)**:
   - Kartu untuk fitur yang non-aktif otomatis disembunyikan secara anggun (*graceful collapse*).
   - Label counter `X Modul Aktif` diperbarui secara real-time.
3. **Feature Gate & Route Guards (`lib/core/widgets/feature_gate.dart`)**:
   - Jika user menavigasi ke rute fitur yang sedang mati (misal `/curhat` atau `/events`), aplikasi menampilkan `FeatureDisabledScreen` yang informatif dengan tombol aktivasi instan tanpa melempar pengecualian unhandled.

---

## 4. Struktur Direktori Proyek

```
prototype/compile/
├── lib/
│   ├── app/
│   │   ├── router.dart             # GoRouter dengan guard pelindung modul
│   │   ├── shell.dart              # Floating frosted glass dock adaptif
│   │   └── theme.dart              # Earth-Tree ThemeData (Light/Dark)
│   ├── core/
│   │   ├── config/
│   │   │   └── feature_flags.dart  # Master state & notifier feature flags
│   │   ├── theme/
│   │   │   ├── earth_tree_colors.dart
│   │   │   ├── earth_tree_forui.dart
│   │   │   ├── theme_extensions.dart
│   │   │   └── typography.dart
│   │   └── widgets/
│   │       └── feature_gate.dart   # FeatureGate & FeatureDisabledScreen
│   ├── features/
│   │   ├── developer/              # Control panel Feature Flags interaktif
│   │   ├── home/                   # Beranda modular & Bento features
│   │   ├── curhat_ai/              # Teman Curhat on-device streaming
│   │   ├── walkie_talkie/          # Ruang Qalbu push-to-talk audio
│   │   ├── daily_task/             # Jurnal adab harian (BT-MT-BK-MM)
│   │   ├── relations/              # Pertumbuhan relasi & radar chart
│   │   ├── charts/                 # Mizan balance scale & visualisasi
│   │   ├── events/                 # Agenda & majelis akbar parenting
│   │   ├── knowledge/              # Khazanah Fitrah (Wiki & hybrid search)
│   │   ├── lessons/                # Micro-learning Google Primer player
│   │   ├── crisis/                 # P3K Jiwa & dalil thuma'ninah
│   │   └── stories/                # Serial kisah nabawiyah
│   └── main.dart                   # Entry point aplikasi terkompilasi
├── test/
│   ├── core/
│   │   └── feature_flags_test.dart # 7 unit test config, serialization, preset
│   ├── widgets/
│   │   └── feature_gate_test.dart  # 3 widget test conditional rendering
│   └── shell/
│       └── modular_shell_test.dart # 4 integration test dynamic dock & presets
├── MODULAR_CHECKLIST_OMP.md        # Checklist verifikasi modularitas oleh OMP
└── pubspec.yaml
```

---

## 5. Panduan Menjalankan & Verifikasi

### Jalankan Seluruh Test Suite:
```bash
flutter test
```
*Hasil:* **14/14 test lulus (100% passing)**.

### Periksa Integritas Lint & Statis:
```bash
flutter analyze
```
*Hasil:* **0 Errors, 0 Warnings**.

### Menjalankan Aplikasi di Emulator/Device:
```bash
flutter run
```
Akses tombol **Pengaturan Modul (ikon gerigi)** di pojok kanan atas Beranda untuk mencoba mematikan dan menghidupkan modul secara langsung dan melihat respon antarmuka secara *real-time*.
