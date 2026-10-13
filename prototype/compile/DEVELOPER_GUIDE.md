# Panduan Pengembang: Melanjutkan Koding Mandiri (`prototype/compile`)

> **Panduan Teknis Manual Developer**  
> Target Platform: **Flutter (Web, Android, iOS)**  
> Basis Arsitektur: **Modular Feature Flags & Earth-Tree Design System**  
> Lokasi Proyek: [`prototype/compile/`](.)

---

## 1. Prasyarat Lingkungan (Environment Setup)

Pastikan dependensi berikut telah terpasang di sistem pengembang lokal:
- **Flutter SDK:** Version 3.29.0+ (`/home/abuhafi/flutter/bin/flutter` atau sudah di `$PATH`).
- **Dart SDK:** Version 3.7.0+.
- **Android SDK:** Platform 35/36, Build-Tools 36.0.0, Java JDK 17/21.
- **Python:** Python 3.10+ (digunakan untuk `serve_web.py`).
- **Android Studio:** Terpasang di `/opt/android-studio/bin/studio.sh`.
- **Perangkat Pengujian:** 
  - Emulator Android: `Pixel_9_API_37` atau `Medium_Phone`.
  - Browser: Chrome atau Zen Browser.

---

## 2. Alur Kerja Harian (Daily Dev Workflow)

### A. Menjalankan Versi Web dengan Hot-Reload (Mode Dev)
Jika Anda ingin mengubah tampilan UI secara cepat dengan fitur **Hot-Reload (`r`)** dan **Hot-Restart (`R`)**:

```bash
cd prototype/compile

# Jalankan dev server interaktif di browser lokal:
./run_web.sh --dev
```
*Tips:* Pada terminal yang sedang berjalan:
- Tekan **`r`** untuk Hot Reload (perubahan kode widget langsung terlihat).
- Tekan **`R`** untuk Hot Restart (reset state Riverpod).
- Tekan **`q`** untuk berhenti.

---

### B. Menjalankan Versi Web Rilis Produksi (Tanpa Error RequireJS & Siap Tailscale)
Gunakan mode ini jika ingin menguji di HP melalui Tailscale VPN:

```bash
cd prototype/compile

# Kompilasi rilis & jalankan server mandiri:
./run_web.sh --rebuild
```
- **Akses Lokal Host:** `http://localhost:3010`
- **Akses Remote Tailscale:** `http://100.118.34.69:3010`

---

### C. Menjalankan Versi Native Android (Android Studio / CLI)
1. **Via Android Studio (GUI):**
   ```bash
   /opt/android-studio/bin/studio.sh /home/abuhafi/Project/PKN-healing-mobile-app/prototype/compile &
   ```
   - Tunggu Gradle sync selesai.
   - Pilih target device di toolbar atas (misal `Pixel_9_API_37`).
   - Tekan tombol hijau **Run (`Shift+F10`)** atau **Debug (`Shift+F9`)**.

2. **Via Flutter CLI:**
   ```bash
   cd prototype/compile

   # Cek daftar emulator yang tersedia
   flutter emulators

   # Luncurkan emulator
   flutter emulators --launch Pixel_9_API_37

   # Jalankan aplikasi ke emulator
   flutter run -d Pixel_9_API_37
   ```

---

## 3. Peta Direktori & Tanggung Jawab Kode

```
prototype/compile/lib/
├── app/
│   ├── router.dart            # Definisi rute GoRouter + FeatureGate pelindung
│   ├── shell.dart             # Scaffold utama & floating frosted navigation dock
│   └── theme.dart             # Root ThemeData (Light & Dark mode Earth-Tree)
├── core/
│   ├── config/
│   │   └── feature_flags.dart # State FeatureFlagsConfig & Riverpod Notifier
│   ├── theme/
│   │   ├── earth_tree_colors.dart # Token warna kanonikal (Sand Ecru, Basalt, Pine)
│   │   ├── earth_tree_forui.dart  # Adaptasi tema Forui UI library
│   │   ├── theme_extensions.dart  # Context helper (context.earthColors)
│   │   └── typography.dart        # Tipografi (Merriweather, Plus Jakarta, Amiri)
│   └── widgets/
│       └── feature_gate.dart  # Pelindung rute & fallback widget jika fitur OFF
└── features/
    ├── home/                  # Beranda, Header Salam, Bento Features Grid
    ├── developer/             # Panel saklar Feature Flags & preset developer
    ├── curhat_ai/             # Teman Curhat AI, Edge LLM streaming
    ├── walkie_talkie/         # Ruang Qalbu Walkie-Talkie Push-to-Talk
    ├── daily_task/            # Jurnal Adab Harian (BT-MT-BK-MM)
    ├── relations/             # Relasi Qalbiyah & Spider Radar Chart
    ├── charts/                # Testbed Visualisasi Mizan Fitrah Physics
    ├── events/                # Agenda & Majelis Akbar Parenting
    ├── knowledge/             # Khazanah Fitrah (Wiki & Vector Search)
    ├── lessons/               # Micro-Learning Google Primer Player
    ├── crisis/                # P3K Jiwa 10 Detik
    └── stories/               # Serial Kisah Nabawiyah & Adab
```

---

## 4. Panduan Menambahkan Fitur Baru (Langkah demi Langkah)

Agar fitur baru Anda memenuhi standar modular (*zero-breakage*), ikuti 5 langkah berikut:

### Langkah 1: Buat Direktori Fitur Baru
Buat folder di `lib/features/<nama_fitur>/` dengan struktur internal:
```
lib/features/my_feature/
├── models/          # Data class / DTO
├── services/        # Service API / SQLite / Business logic
└── presentation/    # Widget layar & komponen UI
```

### Langkah 2: Daftarkan Flag di `lib/core/config/feature_flags.dart`
Tambahkan properti boolean baru pada `FeatureFlagsConfig`:
```dart
class FeatureFlagsConfig {
  // Flag fitur Anda
  final bool enableMyFeature;

  const FeatureFlagsConfig({
    // ...
    this.enableMyFeature = true, // default status
  });

  // Perbarui copyWith, toJson, fromJson, dan preset:
  // - FeatureFlagsConfig.allEnabled()
  // - FeatureFlagsConfig.minimalCore()
}
```

### Langkah 3: Lindungi Rute di `lib/app/router.dart`
Bungkus layar fitur Anda dengan `FeatureGate`:
```dart
GoRoute(
  path: '/my-feature',
  builder: (context, state) => FeatureGate(
    flagSelector: (flags) => flags.enableMyFeature,
    featureName: 'Nama Fitur Anda',
    child: const MyFeatureScreen(),
  ),
),
```

### Langkah 4: Hubungkan ke Navigasi (Dock atau Bento Grid)
- **Jika ingin muncul sebagai tab di dock bawah:**  
  Edit [`lib/app/shell.dart`](lib/app/shell.dart) di method `_buildNavDestinations()`.
- **Jika ingin muncul sebagai kartu di Beranda:**  
  Edit [`lib/features/home/presentation/widgets/bento_features_grid.dart`](lib/features/home/presentation/widgets/bento_features_grid.dart) dengan membungkus kartunya menggunakan `if (flags.enableMyFeature) ...`.

### Langkah 5: Buat Pengujian Unit & Widget
Tambahkan file test di `test/features/my_feature_test.dart` dan jalankan:
```bash
flutter test
```

---

## 5. Standar Desain & Aturan Visual (Earth-Tree System)

1. **Aturan Warna (Strict No-Hex Hardcoding):**
   - Gunakan token warna dari `EarthTreeColors` atau `Theme.of(context).extension<EarthTreeThemeColors>()`:
     ```dart
     // Contoh benar:
     final colors = context.earthColors;
     final bg = colors.sandLight;
     final text = colors.mineralDeep;
     final accent = colors.pineGreen;
     ```
   - Jangan menulis warna statis sembarang seperti `Color(0xFF123456)`.
2. **Aturan Tipografi:**
   - **Judul Layar / Heading:** Font serif kontemplatif (`Merriweather`).
   - **Body / Antarmuka / Label Tombol:** Font sans-serif modern (`Plus Jakarta Sans`).
   - **Ayat Al-Qur'an / Hadits / Doa:** Font kaligrafi naskh (`Amiri`).
3. **Kontras Aksesibilitas (WCAG 2.2 AA):**
   - Pastikan rasio kontras teks terhadap latar belakang minimal **4.5:1** untuk teks reguler.

---

## 6. Integrasi Backend & Layanan AI

| Layanan | Endpoint Standar | Konfigurasi Runtime (`--dart-define`) |
| :--- | :--- | :--- |
| **Ollama (Edge LLM)** | `http://localhost:11434` | `--dart-define="OLLAMA_URL=http://localhost:11434"` |
| **Backend API (Directus/Alexandrie)** | `http://localhost:8081` | `--dart-define="API_BASE_URL=http://localhost:8081"` |
| **Database Khazanah LibSQL** | Offline Zstandard `knowledge_v4.db.zst` | Otomatis di-mount via client service |

---

## 7. Pemeriksaan Kualitas Sebelum Commit (Quality Gate)

Sebelum melakukan `git commit` dan `git push`, selalu jalankan dua perintah wajib ini di root `prototype/compile/`:

```bash
# 1. Pastikan tidak ada kesalahan sintaks atau warning linter (wajib 0 issues):
flutter analyze

# 2. Pastikan seluruh pengujian otomatis lulus (wajib 100% passing):
flutter test
```

Jika keduanya bersih, lakukan commit dengan konvensi standar:
```bash
git add .
git commit -m "feat(my_feature): implement initial screen and state logic"
git push origin main
```
