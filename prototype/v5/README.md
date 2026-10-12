# Prototype v5 — PKN Healing Mobile App (Chart Capabilities, Relasi Qalbiyah, & Daily Task)

> **Prototipe Uji Coba Visualisasi Data Jiwa, Pemantauan Relasi Pengasuhan, dan Manajemen Amanah Harian Berbasis Earth-Tree**  
> *Referensi Desain:* [`prototype/v2/design/my_progress_relasi_pengasuhan`](../v2/design/my_progress_relasi_pengasuhan), [`prototype/v2/design/daily_task_amanah_harian_relasi`](../v2/design/daily_task_amanah_harian_relasi), [`prototype/v2/design/modal_review_kualitas_keberhasilan_todo`](../v2/design/modal_review_kualitas_keberhasilan_todo)  
> *Katalog 32 Layar & Arsitektur:* [`prototype/v2/KATALOG_DAN_ARSITEKTUR_32_LAYAR.md`](../v2/KATALOG_DAN_ARSITEKTUR_32_LAYAR.md)  
> *Spesifikasi Token Warna & Etika:* Earth-Tree (`prototype/v2/design/earth_tree/DESIGN.md`)

---

## 1. Tujuan & Ruang Lingkup Prototipe v5

Prototipe `v5` dibangun sebagai testbed mandiri (*sandbox lab*) untuk mengeksplorasi dan memvalidasi tiga kapabilitas kunci:

1. **Uji Coba Visualisasi Data Jiwa & Charting di Flutter:**
   - Menemukan pendekatan visualisasi data yang selaras dengan prinsip *Calm Tech* dan etika Islam (menghindari grafik komparatif yang memicu rasa bersalah/kecemasan pengasuh).
   - Membandingkan `fl_chart` vs `CustomPainter` vs Segmented Pills native.
2. **Fitur Relasi Qalbiyah & Progres Pengasuhan ([`RelationsProgressScreen`](lib/features/relations/presentation/screens/relations_progress_screen.dart)):**
   - Pemantauan ketercapaian amanah pengasuhan multi-persona (*Ananda Zaid*, *Ananda Maryam*, *Ummu Zaid*).
   - Tracking bakat adab Tazkiyatun Nafs berbasis matriks TB-40 (*Shabr*, *Fathonah*, *Hikmah*).
   - AI Brief Grounding yang menganalisis dinamika keluarga sepekan dan memberikan *Rekomendasi Hikmah*.
3. **Fitur Amanah Harian & Modal Review Adab ([`DailyTaskScreen`](lib/features/daily_task/presentation/screens/daily_task_screen.dart) & [`ModalReviewAdab`](lib/features/daily_task/presentation/widgets/modal_review_adab.dart)):**
   - To-do list berbasis waktu Hijriah & fase shalat (Subuh, Dhuha, Ashar, Maghrib, Isya).
   - Indikator progres thuma'ninah tanpa penalti streak/loss aversion.
   - Modal evaluasi kualitatif pasca-tugas: resonansi jiwa (*Muthma'innah*, *Lawwamah*, *Ammarah*) dan respons anak (*Lembut & Bahagia*, *Netral/Biasa*, *Resisten/Butuh Sabar*).
4. **Integrasi Lintas Fitur (Cross-Feature Wire):**
   - Tombol *"+ Jadwalkan ke Daily Task Besok"* di layar Relasi terhubung langsung ke `dailyTaskProvider` (Riverpod) sehingga agenda hikmah otomatis muncul di tab Amanah Harian.

---

## 2. Hasil Evaluasi & Benchmark Visualisasi Data (Chart) untuk PKN

| Tipe Chart | Pendekatan | Kasus Penggunaan di PKN | Hasil Uji Coba & Rekomendasi |
| :--- | :--- | :--- | :--- |
| **Stacked Bar Chart** | `fl_chart: ^1.1.0` | **Aktivitas Jiwa Sepekan** (Senin–Ahad terbagi porsi *Diri*, *Hati*, *Ilmu*) | **Sangat Direkomendasikan.** Mendukung stacking batang berlapis dengan palet Earth-Tree (`meadowCanopy`, `celestialSky`, `ancientBark`). Event tap menampilkan tooltip detail yang tenang. |
| **Radar / Spider Chart** | `fl_chart: ^1.1.0` | **Peta 6 Klaster Bakat TB-40** (*Syaja'ah*, *Shabr*, *Hikmah*, *Iffah*, *Adl*, *Tawadhu*) | **Sangat Direkomendasikan.** Memberikan gambaran holistik tanpa ranking kuantitatif kaku. Batas poligon halus 2px menyatu dengan kontur Forui. |
| **Mizan Scale (Timbangan Fitrah)** | `CustomPainter` (Dart Canvas) | **Neraca Keseimbangan Jiwa** (*Sakinah & Thuma'ninah* vs *Reaktif / Nafs*) | **Pilihan Utama untuk Metafora Jiwa.** Library chart standar (Cartesian) tidak memiliki konsep tumpuan (*fulcrum*), lengan (*beam*), dan piringan (*pan*). `CustomPainter` memungkinkan simulasi fisika bandul/pegas dinamis saat disentuh dengan zero visual clutter. |
| **Multi-Segment Progress Pill** | Flutter Native `Container` + `Expanded` / `Wrap` | **Tingkat Ketercapaian Amanah** dalam kartu ringkas | **Sangat Ringan & Efisien.** Ideal untuk header kartu atau dashboard tanpa dependensi library eksternal. Sepenuhnya responsif pada viewport sempit 320–360px. |

### Prinsip Anti-Slop Visualisasi Data PKN
- **Menolak "Soul Score 0-100":** Aplikasi tidak menghakimi derajat keimanan orang tua dengan angka desimal kaku.
- **Menolak "Streak Burning / Shame Loop":** Tidak ada peringatan "streak Anda terputus" yang membebani psikologis orang tua yang lelah.
- **Thuma'ninah Touch:** Tooltip dan interaksi chart beranimasi lembut (*easeOutCubic*), tidak agresif.

---

## 3. Arsitektur & Struktur Direktori

```
prototype/v5/
├── lib/
│   ├── app/
│   │   ├── shell.dart                  # Navigation dock 5 tab: Beranda, Amanah, Curhat, Lab Chart, Relasi
│   │   └── theme.dart                  # AppTheme M3 + NoSplash + Earth-Tree palette
│   ├── core/theme/
│   │   ├── earth_tree_colors.dart      # Token warna Earth-Tree (light & dark mode)
│   │   ├── earth_tree_forui.dart       # Skinning Forui FThemeData
│   │   └── typography.dart             # Merriweather & Plus Jakarta Sans
│   ├── features/
│   │   ├── charts/                     # Lab Visualisasi Data & Charting
│   │   │   └── presentation/
│   │   │       ├── screens/
│   │   │       │   └── chart_testbed_screen.dart        # Layar uji coba & benchmark 4 tipe chart
│   │   │       └── widgets/
│   │   │           ├── weekly_stacked_bar_chart.dart    # fl_chart Stacked Bar
│   │   │           ├── tb40_talents_radar_chart.dart    # fl_chart Radar Chart TB-40
│   │   │           ├── mizan_fitrah_balance_scale.dart  # CustomPainter Timbangan Mizan
│   │   │           └── multi_segment_progress_pill.dart # Segmented progress pill
│   │   ├── daily_task/                 # Amanah Harian & Modal Evaluasi
│   │   │   ├── data/models/
│   │   │   │   └── task_model.dart                      # DailyTaskItem, SoulResonance, ChildResponse
│   │   │   └── presentation/
│   │   │       ├── controllers/
│   │   │       │   └── daily_task_controller.dart       # StateNotifierProvider (Riverpod)
│   │   │       ├── screens/
│   │   │       │   └── daily_task_screen.dart           # Layar to-do harian, filter chip, progress bar
│   │   │       └── widgets/
│   │   │           └── modal_review_adab.dart           # Bottom sheet modal evaluasi thuma'ninah
│   │   └── relations/                  # Neraca Relasi & Progres Pengasuhan
│   │       └── presentation/
│   │           └── screens/
│   │               └── relations_progress_screen.dart   # Matriks relasi persona, TB-40, wire ke Daily Task
│   └── main.dart
├── test/
│   ├── charts_and_relations_test.dart  # Widget test chart rendering, daily task, & relations wire
│   ├── daily_task_test.dart            # Unit test DailyTaskController (5 initial tasks, complete, filter, add)
│   ├── theme_contrast_test.dart        # WCAG AAA contrast ratio test
│   └── widget_test.dart                # Shell & responsiveness tests
└── pubspec.yaml                        # fl_chart: ^1.1.0, forui, flutter_riverpod, iconoir_flutter
```

---

## 4. Navigasi & Dock Shell

`AppShell` di `lib/app/shell.dart` menyediakan 5 tab akses cepat:

1. **Tab 0 — Beranda:** Ikhtisar utama PKN Healing, bento grid, krisis P3K, dan serial.
2. **Tab 1 — Amanah Harian:** To-do amanah pengasuhan harian, filter kategori, dan modal refleksi.
3. **Tab 2 — Curhat AI:** AI Sanctuary pendengar empati dengan reduksi animasi thuma'ninah.
4. **Tab 3 — Lab Chart:** Komparasi 4 visualisasi data (Stacked Bar, Radar TB-40, Mizan Scale, Segmented Pill) beserta kartu rekomendasi arsitektur.
5. **Tab 4 — Relasi Jiwa:** Neraca relasi pasangan & anak, radar bakat, dan rekomendasi hikmah harian.

---

## 5. Status Pengujian & Kualitas Kode

- **Unit & Widget Tests:** `23/23 passing` (100% lolos verifikasi).
- **Static Analysis:** `flutter analyze` — **0 issues** (Clean).
- **Responsiveness:** Tahan terhadap viewport sempit 320×640 dan 360×800 px (zero RenderFlex overflow).
- **Aksesibilitas & Kontras:** Lolos audit rasio kontras WCAG AAA.

### Perintah Menjalankan:
```bash
cd prototype/v5

# Menjalankan static analysis
/home/abuhafi/flutter/bin/flutter analyze

# Menjalankan seluruh test suite
/home/abuhafi/flutter/bin/flutter test

# Menjalankan aplikasi di Chrome
/home/abuhafi/flutter/bin/flutter run -d chrome
```
