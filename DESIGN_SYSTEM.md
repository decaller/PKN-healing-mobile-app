# 🎨 PKN Mobile Design System Specification
## *(Pendidikan Karakter Nabawiyah & Tafsir Bakat 40)*
### Version: 1.0.0 • Target: Flutter M3 & OpenPencil Vector Architecture

---

## 1. Visi, Nilai Inti & Prinsip Desain

Desain antarmuka PKN Mobile dibangun di atas perpaduan antara **keanggunan eksekutif Nabawiyah**, **rekayasa kognitif ramah pengguna (*zero-fluff*)**, dan **kepatuhan syar'i manhaj**.

| Pilar Filosofi | Prinsip Penerapan dalam Desain UI/UX |
|---|---|
| **Fitrah-First, Bukan Peringkat** | Menghilangkan angka mati (*ranking*), persaingan toksik (*leaderboard*), dan komparasi sosial. Digantikan oleh pelacakan kualitatif adab (**BT - MT - BK - MM**), keunikan syakilah (TB-40), serta apresiasi proses. |
| **Koneksi Sebelum Koreksi** | Hierarki visual memprioritaskan sentuhan hati (*Bahasa Hati*) dan validasi emosi sebelum menyajikan konsekuensi kedisiplinan atau aturan teknis. |
| **Rekayasa Kognitif Zero-Fluff** | Menekan beban mental (*extraneous cognitive load*) orang tua yang lelah setelah bekerja dan guru yang terburu-buru menyiapkan KBM. Menyajikan solusi instan 10 detik (*Lead TL;DR*) paling atas (*above the fold*). |
| **Keselamatan Manhaj & Batas Klinis** | Perlindungan anak: larangan sanksi fisik pada balita, batas sanksi disiplin mendidik hanya setelah usia 10 tahun (tidak memukul wajah/tidak melukai), serta penegasan bahwa asesmen adalah panduan fitrah, bukan vonis psikometrik permanen. |
| **Aksesibilitas Universal (WCAG 2.1 AA)** | Rasio kontras $\ge 4.5:1$, target sentuh minimal $48 \times 48\text{ dp}$, font Arab berharakat proporsional ($\ge 22\text{ sp}$, RTL), dan dukungan penuh TalkBack / VoiceOver. |

---

## 2. Sistem Warna (Color Tokens)

### 2.1 Warna Utama & Merek Nabawiyah
- **Fitrah Emerald (Brand Primary):** `#0D9488` (Teal 600) — Melambangkan kesuburan fitrah, ketenangan, dan keseimbangan spiritual.
- **Fitrah Emerald Dark:** `#0F766E` (Teal 700) — Varian gelap untuk kontras tinggi pada latar terang.
- **Nabawi Gold (Accent / Secondary):** `#D4AF37` — Emas elegan yang melambangkan kemuliaan akhlak dan khazanah ilmu kenabian.
- **Emerald Green (Success / Thriving):** `#10B981` (Green 500) — Indikator kemajuan positif dan keberhasilan adab.
- **Deep Indigo:** `#6366F1` (Indigo 500) — Aksen navigasi dan pondasi manhaj (P1).

### 2.2 Warna Permukaan & Mode Tampilan
| Token | Dark Mode (`ThemeMode.dark`) | Light Mode (`ThemeMode.light`) | Peruntukan |
|---|---|---|---|
| `background` | `#0B132B` (Deep Nabawi Slate) | `#F8FAFC` (Slate 50) | Latar belakang seluruh layar |
| `surface` | `#151D3B` (Elevated Slate) | `#FFFFFF` (Pure White) | Kartu konten, dialog, bottom sheet |
| `surfaceElevated` | `#1C274C` | `#F1F5F9` (Slate 100) | Chip terpilih, pill filter, input |
| `border` | `#2A3764` | `#E2E8F0` (Slate 200) | Garis pemisah, outline kartu ($1\text{ dp}$) |
| `textPrimary` | `#F8FAFC` (White 95%) | `#0F172A` (Slate 900) | Judul, ayat Al-Qur'an, teks primer |
| `textSecondary` | `#94A3B8` (Slate 400) | `#475569` (Slate 600) | Teks penjelas, deskripsi, terjemahan |
| `textMuted` | `#64748B` (Slate 500) | `#94A3B8` (Slate 400) | Placeholder, meta data, durasi baca |

### 2.3 Rubrik Adab Kualitatif (BT - MT - BK - MM)
Menggantikan sistem nilai angka/peringkat dengan 4 status perkembangan fitrah:
- 🔴 **BT (Belum Terlihat):** `#EF4444` (Red 500) — Membutuhkan bimbingan intensif dan keteladanan fisik (*Bahasa Tangan*).
- 🟡 **MT (Mulai Terlihat):** `#F59E0B` (Amber 500) — Muncul sesekali bila diingatkan; membutuhkan pembiasaan teratur.
- 🟢 **BK (Berkembang Konsisten):** `#10B981` (Emerald 500) — Dilakukan mandiri dengan kesadaran hati tanpa perlu dipaksa.
- 🔵 **MM (Membudaya Mandiri):** `#3B82F6` (Blue 500) — Telah menjadi karakter spontan dan mampu mengajak orang lain berbuat adab.

### 2.4 Warna 6 Pilar MOC (Maps of Content)
Setiap pilar taksonomi memiliki identitas warna visual konsisten:
- **P1: Mulai di Sini (Manhaj & Glosarium):** `#6366F1` (Indigo)
- **P2: Fase Tumbuh Kembang (Pedoman Usia):** `#0EA5E9` (Sky Blue)
- **P3: Fitrah & Bakat TB-40 (Syakilah):** `#8B5CF6` (Violet / Purple)
- **P4: Praktik Keluarga (Parenting & Rumah):** `#F43F5E` (Rose / Coral)
- **P5: Lembaga & Guru (Pedagogi & KBM):** `#10B981` (Emerald)
- **P6: Khazanah Dalil (Takhrij & Turats):** `#D4AF37` (Nabawi Gold)

### 2.5 Wadah Callout Khusus (Callout Containers)
- `[!summary]` **Lead TL;DR 10 Detik:** Latar `#0D9488` dengan opasitas 12%, border kiri `#0D9488` ($4\text{ dp}$).
- `[!warning]` **Batas Toleransi Syar'i:** Latar `#F59E0B` dengan opasitas 12%, border kiri `#F59E0B` ($4\text{ dp}$).
- `[!tip]` **Resep Praktis Lapangan:** Latar `#10B981` dengan opasitas 12%, border kiri `#10B981` ($4\text{ dp}$).

---

## 3. Sistem Tipografi (Typography Scale)

Tipografi memadukan **Plus Jakarta Sans / Poppins** untuk kejelasan eksekutif modern, **Inter** untuk keterbacaan artikel panjang berkecepatan tinggi (*speed reading*), dan **Amiri / Uthman Taha** untuk teks suci Al-Qur'an dan Hadits Nabawiyah.

| Level Tipografi | Ukuran (`sp`) | Bobot (`FontWeight`) | Font Family | Tinggi Baris (`height`) | Kegunaan |
|---|---|---|---|---|---|
| `headlineLarge` | 28 | 800 (Bold) | Plus Jakarta Sans | 1.20 | Judul utama layar & nama modul |
| `headlineMedium`| 22 | 700 (Bold) | Plus Jakarta Sans | 1.25 | Judul kartu Lead TL;DR & kuis |
| `headlineSmall` | 18 | 700 (Bold) | Plus Jakarta Sans | 1.30 | Subjudul bab & pertanyaan kuis |
| `titleLarge`    | 17 | 600 (SemiBold) | Plus Jakarta Sans | 1.35 | Judul kartu rekomendasi feed |
| `titleMedium`   | 15 | 600 (SemiBold) | Plus Jakarta Sans | 1.40 | Pilihan jawaban kuis / opsi |
| `titleSmall`    | 13 | 600 (SemiBold) | Plus Jakarta Sans | 1.40 | Judul seksi & step counter |
| `bodyLarge`     | 16 | 400 (Regular) | Inter | 1.55 | Teks isi nasehat & narasi adab |
| `bodyMedium`    | 14 | 400 (Regular) | Inter | 1.50 | Teks umum, penjelasan soal |
| `bodySmall`     | 12 | 400 (Regular) | Inter | 1.40 | Waktu baca, takhrij dalil, takarir |
| `labelLarge`    | 14 | 600 (SemiBold) | Plus Jakarta Sans | 1.20 | Tombol aksi utama ($48\text{ dp}$) |
| `labelMedium`   | 12 | 600 (SemiBold) | Plus Jakarta Sans | 1.20 | Chip pilar MOC & filter |
| `labelSmall`    | 10 | 700 (Bold) | Plus Jakarta Sans | 1.20 | Badge Adab (BT/MT/BK/MM) |
| **Arabic Dalil**| **$\ge 22$** | **600 (Bold)** | **Amiri / Uthmanic** | **1.85** | **Matan Hadits & Ayat Al-Qur'an (RTL)** |

---

## 4. Sistem Spasial, Grid & Geometri (Layout Foundations)

### 4.1 Grid 8-Point Standar
Semua dimensi, margin, dan jarak antar elemen adalah kelipatan dari **8dp** (atau 4dp untuk jarak mikro):
- `spacing.xxs` = 4 dp
- `spacing.xs` = 8 dp
- `spacing.sm` = 12 dp
- `spacing.md` = 16 dp (Margin sisi ponsel standar / padding kartu)
- `spacing.lg` = 20 dp (Padding layar luar ponsel)
- `spacing.xl` = 24 dp (Jarak antar blok seksi)
- `spacing.xxl` = 32 dp (Jarak pemisah besar)
- `spacing.xxxl` = 48 dp (Tinggi target sentuh minimum)

### 4.2 Sudut Lengkung (Border Radius)
- **Kecil (Pill / Badge):** `20.0 dp` — Chip pilar MOC, badge Adab, indikator fase.
- **Sedang (Button & Input):** `14.0 dp` — Tombol aksi utama, text field, audio scrubber card.
- **Besar (Content Card):** `16.0 dp` — Kartu Feed Deepstash, opsi pilihan kuis.
- **Ekstra Besar (Container / Hero):** `24.0 dp` — Kartu Hero TL;DR, Bottom Sheet modal.

### 4.3 Target Sentuh Ergonomis (Touch Targets)
Sesuai standar WCAG 2.1 AA dan pengoperasian satu tangan orang tua/guru di lapangan:
- **Minimum Target Area:** $48 \times 48\text{ dp}$.
- **Tombol Navigasi Bawah:** Tinggi $64\text{ dp}$ (area aman sentuh).
- **Opsi Kuis:** Tinggi minimal $56\text{ dp}$ dengan padding internal lapang.

---

## 5. Spesifikasi Komponen Utama (Component Specifications)

### 5.1 Kartu Lead TL;DR 10 Detik (`PknCalloutBox`)
- **Tujuan:** Memberikan jawaban instan bagi orang tua yang panik menghadapi krisis balita atau guru yang terburu-buru menyiapkan kelas.
- **Tata Letak:**
  - Border kiri tebal $4\text{ dp}$ warna aksen pilar.
  - Latar belakang lembut (opasitas 10%).
  - Ikon penanda di kiri atas (⚡ untuk TL;DR, ⚠️ untuk Batas Syar'i, 💡 untuk Resep Lapangan).
  - Teks kata kunci tebal di depan (*Front-Loaded*).

### 5.2 Lencana Adab Kualitatif (`AdabBadge`)
- **Tujuan:** Menampilkan status pertumbuhan adab tanpa memicu perbandingan toksik.
- **Varian:**
  - `BT`: 🔴 Belum Terlihat (Latar merah lembut, teks merah pekat)
  - `MT`: 🟡 Mulai Terlihat (Latar kuning lembut, teks amber pekat)
  - `BK`: 🟢 Berkembang Konsisten (Latar hijau lembut, teks emerald pekat)
  - `MM`: 🔵 Membudaya Mandiri (Latar biru lembut, teks royal blue)
- **Aksesibilitas:** Wajib menyertakan atribut `semanticsLabel` agar dibacakan tuntas oleh TalkBack/VoiceOver.

### 5.3 Blok Teks Dalil & Takhrij Turats (`ArabicDalilCard`)
- **Tujuan:** Menyajikan rujukan Al-Qur'an dan Hadits dengan penghormatan tertinggi terhadap kaidah turats.
- **Tata Letak:**
  - Latar belakang berhias pola emas halus atau sudut melengkung $18\text{ dp}$.
  - Teks Arab menggunakan font *Amiri* $\ge 22\text{ sp}$, `textDirection: TextDirection.rtl`, harakat lengkap.
  - Tombol aksi collapsible: *"Lihat Takhrij & Sanad Lengkap"* (mencegah beban kognitif berlebih bagi pembaca awam).
  - Terjemahan bahasa Indonesia di bawah teks Arab dengan font *Inter* 14sp italic.

### 5.4 5-Minute Primer Microlearning Deck
- **Tujuan:** Pelatihan kilat 5 menit berbasis kartu geser interaktif (Google Primer format).
- **Jenis Kartu:**
  1. `TextInsightCard`: Paragraf padat $< 50$ kata + Key Takeaway badge.
  2. `SwipePollCard`: Pertanyaan intuisi ya/tidak dengan gestur geser & umpan balik instan.
  3. `MultipleChoiceCard`: Studi kasus nyata dengan 3–4 opsi + penjelasan hikmah.
  4. `FillInBlankCard`: Rekonstruksi kalimat kunci fitrah dengan bank kata interaktif.
- **Indikator Kemajuan:** Segmented Progress Bar di AppBar atas (menunjukkan posisi step $N$ dari total langkah).

### 5.5 Kartu Donut Refleksi Pertumbuhan Adab (`AdabGrowthReport`)
- **Tujuan:** Laporan selesai belajar yang merayakan perkembangan karakter, bukan skor angka.
- **Elemen:**
  - Donut Chart interaktif 4 segmen (persentase sebaran adab yang tersentuh).
  - Ringkasan waktu belajar (e.g. 5 Menit).
  - Butir adab yang diperkuat hari ini (dengan badge BK / MM).
  - Rekomendasi aksi nyata di rumah / kelas (*Action Checklist*).
  - Do'a penutup reflektif berharakat.

### 5.6 Pemutar Audio Sirah & Tazkiyah (`PknAudioPlayerSheet`)
- **Tujuan:** Pendampingan audio riang bagi ibu saat menyusui/menidurkan anak, serta podcast daurah Ustadz Abdul Kholiq.
- **Elemen:**
  - Mini-player melayang di atas bottom navigation bar.
  - Full-screen sheet dengan tombol Play/Pause besar ($64\times 64\text{ dp}$), slider durasi, pengatur kecepatan baca ($1.0\times, 1.25\times, 1.5\times$), dan daftar bab/sirah.

---

## 6. Pemetaan Template Figma (`template/*.fig`) ke Aplikasi PKN

Menggunakan **OpenPencil**, layar aplikasi ditransformasikan dari template yang tersedia:

| Layar PKN | Sumber Template Figma | Node ID | Penyelarasan Desain PKN |
|---|---|---|---|
| **JTBD Onboarding & Persona** | `14 Screen Education Apps.fig` | `0:1182` (Level) & `0:1555` (Welcome) | Stepper peran vertikal: Ayah, Bunda, Guru (Fase 2-7, 7-10, 10-14, 14+), Siswa/Santri. |
| **Discovery Feed & Lead TL;DR** | `14 Screen Education Apps.fig` | `0:774` (Home) | Chip 6 Pilar MOC di atas, Banner Respon Krisis Cepat, Feed Kartu Deepstash. |
| **5-Min Primer Interactive Deck**| `14 Screen Education Apps.fig` | `0:429` (Test) | Segmented progress bar, kartu pertanyaan interaktif, umpan balik seketika. |
| **Adab Growth & Reflection Report**| `14 Screen Education Apps.fig` | `0:379` (Test Report) | Mengganti skor persentase ujian dengan Donut Chart Adab, waktu muhasabah, dan action steps. |
| **Audio Sirah & Tazkiyah Player**| `13 Screen Online Course.fig` | `0:142` (Learning) | Player audio melayang, scrubber waktu, dan playlist kajian/sirah shahabat. |

---

## 7. Rambu Manhaj & Batas Keamanan Anak (*Safety Guardrails*)

1. **Larangan Sanksi Fisik Balita:** UI tidak boleh menampilkan opsi atau saran sanksi fisik pada anak usia di bawah 7 tahun.
2. **Batas Sanksi Usia 10 Tahun:** Peringatan tegas (*Callout Warning*) muncul pada modul anak tamyiz bahwa sanksi mendidik hanya boleh setelah 10 tahun penuh bila membangkang shalat, tanpa melukai dan haram memukul wajah.
3. **Tanpa Label Permanen Anak:** Pada asesmen TB-40 anak/remaja, hasil berupa eksplorasi kecenderungan fitrah, dilarang memberi label anak "tidak berbakat", "nakal", atau "sulit diatur".
4. **Bukan Pengganti Terapi Klinis:** Seluruh layar memuat catatan kaki bahwa aplikasi merupakan pendamping edukasi karakter nabawiyah, bukan diagnosis medis psikologis atau terapi psikiatri.
