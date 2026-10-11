# Panduan Pengembangan & Batasan Arsitektural: Prototipe v4 (Earth-Tree)

> **Dokumen Panduan Teknis & Batasan Mutlak Pengkodean (*Coding Standards & Hard Constraints*)**  
> **Basis Kode Target:** [`prototype/v4/`](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/v4)  
> **Referensi Konsep:** [`prototype/v2/`](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/v2)  
> **Katalog Referensi Desain:** [`prototype/v4/STITCH_DESIGN_REFERENCES.md`](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/v4/STITCH_DESIGN_REFERENCES.md)

---

## 1. Batasan Mutlak Proyek (Non-Negotiable Hard Constraints)

Setiap baris kode dan komponen layar baru di `prototype/v4` **WAJIB MEMATUHI** 5 batasan utama berikut:

### ⛔ Batasan 1: Zero-Material & Zero-Cupertino
* **DILARANG MENGGUNAKAN** komponen styling bawaan Material Design 3 (seperti `FloatingActionButton`, efek splash ripple agresif `InkWell`, tonal color ungu/biru M3 default, atau `ElevatedButton` default).
* **DILARANG MENGGUNAKAN** komponen kaku bergaya Apple Cupertino (`CupertinoButton`, `CupertinoNavigationBar`, San Francisco font look).
* **SOLUSI TUNGGAL:** Gunakan pustaka **Forui** (`forui: ^0.11.1`) yang dibungkus dengan `FTheme` dan di-skinning 100% menggunakan token **Earth-Tree** (`earthTreeLight` dan `earthTreeDark`). Semua interaksi sentuh harus tenang, tanpa ripple memantul (*`NoSplash.splashFactory`*).

### ⛔ Batasan 2: Standar Tunggal Ikonografi — Iconoir (`iconoir_flutter`)
* **DILARANG MENGGUNAKAN** ikon bawaan Flutter Material (`Icons.*`), FontAwesome, maupun Material Symbols font.
* **WAJIB MENGGUNAKAN** ikon resmi pilihan Forui: **`iconoir_flutter: ^7.11.0`**.
* **Ketebalan Garis Konsisten:** Seluruh ikon memiliki stroke garis halus 1.5px/2px yang menyatu dengan estetika tactile border 1px Earth-Tree.

### ⛔ Batasan 3: Larangan Keras `fluttersdk_wind`
* **DILARANG MEMASANG** paket `fluttersdk_wind` atau class Tailwind berbasis string ke dalam proyek Flutter.
* **ALASAN ARSITEKTUR:** Menghindari overhead parsing string di runtime mobile, mencegah risiko *typo* yang lolos dari kompilasi (*loss of compile-time type safety*), serta menjaga kemurnian paradigma *Component-Driven Strongly-Typed Dart*.

### ⛔ Batasan 4: Integritas Teks Agama & Kepatuhan Manhaj
* **DILARANG KERAS** mengarang, memparafrase, atau memotong ayat Al-Qur'an dan matan hadits.
* **TIPOGRAFI ARAB:** Seluruh teks Arab wajib menggunakan font **Amiri** dengan harakat lengkap.
* **NOMOR RIWAYAT TERVERIFIKASI:** Setiap kutipan dalil wajib mencantumkan perawi dan nomor hadits shahih/hasan (misal: *HR. Muslim No. 2594*).
* **DISCLAIMER NON-KLINIS:** Aplikasi berfokus pada edukasi karakter dan pendampingan adab Islam, bukan pengganti intervensi psikiatri klinis.

### ⛔ Batasan 5: Privasi On-Device & Offline-First (Zero Cloud Leak)
* Curahan hati, rekaman suara PTT, catatan muhasabah, dan SOP krisis **WAJIB DAPAT DIAKSES LURING (OFFLINE)**.
* Tidak boleh ada data curahan hati yang bocor ke server awan pihak ketiga (*Zero Cloud Leak*).
* Seluruh aset pendukung (font lokal, skenario krisis JSON) disimpan di memori lokal ponsel.

---

## 2. Pedoman Desain Earth-Tree & Anti-Slop Framework

Mengacu pada `DESIGN_SKILLS_ANTI_SLOP.md` dan `panduan_layout_out_of_the_box_non_card_redesign.md`:

### A. Tipografi Bertingkat Tiga
1. **Heading / Display:** Font **Merriweather** (Serif) untuk judul seksi dan kutipan sastra, memberikan ketenangan editorial (*mindful & serene*).
2. **Body & Komponen UI:** Font **Plus Jakarta Sans** (Sans-serif) untuk label, tombol, formulir, dan teks paragraf yang mudah dipindai cepat.
3. **Kutipan Sakral (Arab):** Font **Amiri** untuk ayat Al-Qur'an dan hadits nabawiyah.

### B. Palet Semantik Earth-Tree
Gunakan selalu ekstensi tema `context.earthTree` daripada menulis *hardcoded hex color*:
* `surfaceContainerLowest`: Latar belakang modul terdalam / card container utama.
* `surfaceContainerLow` / `surfaceContainer`: Permukaan elevasi bertingkat.
* `celestialSky`: Aksen biru langit cerah untuk fokus dan status aktif.
* `meadowCanopy`: Aksen hijau kanopi untuk ketenangan dan adab tumbuh.
* `ancientBark`: Warna tanah/kayu purba untuk aksen kontemplatif.
* `tactileBorder`: Garis batas halus 1px (`rgba(118, 116, 109, 0.18)` di Light, `0.24` di Dark).

### C. Tata Letak *Out-of-the-Box* (Non-Card Framework)
* **Hindari "Nested Card Slop":** Jangan membungkus kartu di dalam kartu berulang kali. Gunakan divider tipis, jeda tipografi, dan perubahan kontras permukaan (*surface shifting*).
* **Struktur *Action Spine*:** Letakkan tindakan utama (*action*) di bagian paling atas, diikuti penjelasan ringkas, dan metadata dalil di bagian bawah (*Guidance-First, Metadata-Last*).
* **Kejujuran Data & Zero Manipulative UX:** Tidak ada hitung mundur (*countdown timer*) palsu, tidak ada *streak shaming*, dan tidak ada data sosial palsu.

### D. Aksesibilitas Mobile & Kenyamanan Pengasuh
* **Target Sentuh Minimum:** Minimal **48×48 dp** untuk seluruh tombol interaktif dan aksi primer.
* **Kontras Warna:** Memenuhi rasio kontras **WCAG 2.2 AAA** (minimal 4.5:1 untuk teks biasa, 3:1 untuk teks besar).
* **Dukungan Dynamic Font Scaling:** Tata letak tidak boleh rusak atau melempar *RenderFlex overflow* ketika pengguna mengaktifkan font besar (1.3x–1.5x) di setelan sistem ponsel.

---

## 3. Batasan Teknis & Kinerja Rendering Mobile

1. **Batasi `BackdropFilter`:**  
   Hanya gunakan `BackdropFilter` pada elemen tetap seperti *Floating Bottom Navigation Dock* dan *App Bar Sticky*. Hindari menyematkan efek blur di dalam kartu list scrollable agar tidak memicu *raster thread jank* pada HP spesifikasi menengah ke bawah.
2. **Defensive Layout (Mencegah Overflow):**  
   Setiap `Row` horizontal yang berisi teks dinamis **wajib** membungkus teks dalam widget `Expanded` atau `Flexible` dengan parameter `overflow: TextOverflow.ellipsis`.
3. **Pembersihan Timer (Memory Leak Prevention):**  
   Setiap timer berkala (seperti rotasi teks search ticker) **wajib dibatalkan** pada metode `dispose()` widget atau `ref.onDispose()` pada Riverpod notifier.
4. **Verifikasi Statis Tanpa Pengecualian:**  
   Perintah `/home/abuhafi/flutter/bin/flutter analyze` harus menghasilkan **0 issues (No issues found!)** pada setiap penambahan berkas baru.

---

## 4. Peta Alur Pengguna (Core User Flows)

Setiap halaman baru yang dibuat harus memosisikan dirinya pada salah satu dari 5 jalur berikut:

```
[HOME SCREEN]
  │
  ├── Jalur A (Krisis 10 Detik) ──► P3kCrisisScreen ────────► DalilDetailScreen
  │
  ├── Jalur B (Curhat AI)      ──► AiSanctuaryScreen ──────► MuhasabahCabinetScreen
  │
  ├── Jalur C (Living RPG)     ──► SerialDetailEpisodeScreen ─► LivingRehearsalRpgScreen ─► AdabGrowthReportScreen
  │
  ├── Jalur D (Agenda Daurah)  ──► EventListScreen ────────► EventDetailScreen ──────────► EventEPassScreen
  │
  └── Jalur E (Khazanah Wiki)  ──► KhazanahMocScreen ──────► MizanFitrahScreen ──────────► SyakilahMatrixScreen
```

### Tabel Rujukan Folder Desain Google Stitch

| Layar di Flutter `v4` | Jalur | Folder Acuan Stitch | Peran Utama |
|---|---|---|---|
| `P3kCrisisScreen` | A | `resep_krisis_10_detik_tantrum_publik` | Protokol 10 Detik saat anak mengamuk di depan umum |
| `DalilDetailScreen` | A | `telaah_dalil_kedisiplinan_usia_10_thn` | Matan hadits pendisiplinan usia 10 tahun |
| `AiSanctuaryScreen` | B | `ruang_curhat_ai_sanctuary` | Konseling batin on-device + Barometer Nafs + Resep Doa |
| `MuhasabahCabinetScreen`| B | `kabinet_muhasabah_tb_40_mobile` | Brankas catatan wawasan jiwa |
| `SerialDetailEpisodeScreen`| C | `detail_serial_pemilihan_episode` | Pemilihan episode kisah Zaid & Save Slot manajemen |
| `LivingRehearsalRpgScreen`| C | `living_rehearsal_rpg_mobile` | Arena simulasi RPG isometrik dengan orbs adab |
| `AdabGrowthReportScreen` | C | `laporan_pertumbuhan_adab` | Rubrik evaluasi kualitatif BT-MT-BK-MM |
| `EventListScreen` | D | `agenda_event_daurah_flutter_m3` | Katalog agenda daurah & webinar |
| `EventDetailScreen` | D | `detail_event_kuota_syar_i_pkn` | Rincian acara dengan alokasi kursi ikhwan/akhwat |
| `EventEPassScreen` | D | `detail_event_digital_e_pass` | QR code tiket digital siap pindai luring |
| `KhazanahMocScreen` | E | `peta_induk_khazanah_fitrah_moc` | Peta taksonomi 6 Pilar Fitrah Nabawiyah |
| `MizanFitrahScreen` | E | `timbangan_resonansi_jiwa_mizan_fitrah` | Kalkulator timbangan keselarasan fitrah |
| `SyakilahMatrixScreen` | E | `matriks_syakilah_tb_40_mobile` | Matriks pemetaan 40 bakat anak dalam 6 rumpun |

---

## 5. Pola Standar Pembuatan Layar Baru (Boilerplate Template)

Saat membuat file layar baru di bawah `lib/features/<fitur>/presentation/screens/`, gunakan struktur standar ini:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class NamaScreen extends ConsumerWidget {
  const NamaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface.withValues(alpha: 0.95),
        elevation: 0,
        leading: IconButton(
          icon: iconoir.ArrowLeft(
            width: 20,
            height: 20,
            color: context.colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Judul Layar',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Action Spine / Lead Box
              // 2. Konten Inti
              // 3. Referensi Dalil / Catatan Kaki
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 6. Prosedur Quality Gate Setiap Penambahan Layar

Sebelum sebuah layar dinyatakan selesai dan siap dipresentasikan:
1. Jalankan `flutter analyze` $\rightarrow$ Pastikan **0 issues**.
2. Jalankan `flutter test` $\rightarrow$ Pastikan seluruh pengujian lulus.
3. Sambungkan layar tersebut ke titik sentuh tombol di `HomeScreen` atau widget terkait agar alur navigasinya dapat dieksekusi secara nyata.
