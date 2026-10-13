# Roadmap Implementasi 4 Fase Menuju `/home/abuhafi/Project/pkn-mobile`

> **Rencana Kerja Eksekusi Modular Bertahap (Sprint Execution Guide)**  
> Mengarahkan transisi dari cetak biru arsitektur v2 menuju basis kode nyata yang bersih, modular, dan teruji.

---

## 1. Ikhtisar Pembagian 4 Fase

```
┌────────────────────────────────────────────────────────────────────────┐
│               ROADMAP IMPLEMENTASI 4 FASE (PKN MOBILE)                 │
├─────────────────┬─────────────────┬─────────────────┬──────────────────┤
│     FASE 1      │     FASE 2      │     FASE 3      │      FASE 4      │
│  Fondasi &      │  Identitas &    │  Instrumen      │  Pendampingan    │
│  Katalog Publik │  Khazanah Ilmu  │  Personal       │  Batin & Narasi  │
├─────────────────┼─────────────────┼─────────────────┼──────────────────┤
│ • Init Project  │ • Modul 5: User │ • Modul 7:      │ • Modul 11:      │
│ • Shell 5 Tab   │ • Badges System │   Tafsir Bakat  │   Curhat AI      │
│ • Modul 1:      │ • Modul 6: Wiki │ • Modul 8:      │ • PTT Waveform   │
│   Event         │   (Penulis &    │   Ceklist       │ • Modul 12:      │
│ • Modul 2: Buku │    AI/Dalil)    │ • Modul 9:      │   Cerita         │
│ • Modul 3:      │                 │   Relasi        │   Interaktif     │
│   Tokoh/Lembaga │                 │ • Modul 10:     │ • Evaluasi Akhir │
│ • Modul 4:      │                 │   Onboarding    │   Build Rilis    │
│   Kemitraan     │                 │   4 Langkah     │                  │
└─────────────────┴─────────────────┴─────────────────┴──────────────────┘
```

---

## 2. Fase 1: Inisialisasi Proyek, Shell 5 Tab & Modul Katalog Publik

*Fokus: Membangun fondasi proyek baru `/home/abuhafi/Project/pkn-mobile`, tema Earth-Tree, sistem navigasi 5 tab, serta merampungkan modul katalog yang paling mudah dan siap pakai.*

### Task List Fase 1:
- [ ] **Task 1.1 — Scaffold Flutter Proyek Baru:**
  - Buat proyek Flutter di `/home/abuhafi/Project/pkn-mobile` dengan Dart 3.7+ dan Flutter 3.29+.
  - Setup dependensi inti: `flutter_riverpod`, `go_router`, `forui`, `iconoir_flutter`, `intl`, `flutter_svg`.
  - Pasang sistem tema kanonikal **Earth-Tree Design System** (*Sand Ecru, Mineral Basalt, Pine Green*).
- [ ] **Task 1.2 — Core Shell & Floating Navigation Dock:**
  - Implementasi scaffold utama dengan **Floating Frosted Acrylic Dock 5 Tab** (Beranda, Event, Wiki, Curhat AI, Profil).
  - Implementasi sistem **Feature Flags Dinamis** (`featureFlagsProvider`) untuk menjamin zero runtime breakage.
- [ ] **Task 1.3 — Modul 1 (Event / Agenda Daurah):**
  - Buat `EventHomeWidget` (Bento card hitung mundur event terdekat di Beranda).
  - Buat `EventListPage` dengan filter kategori (`Daurah`, `Seminar`, `Temu Lembaga`).
  - Buat `EventDetailPage` dengan informasi lokasi, pemateri, dan pendaftaran.
  - Sediakan slot untuk badge keikutsertaan (`EventProfileBadge`).
- [ ] **Task 1.4 — Modul 2 (Buku / Pustaka Nabawiyah):**
  - Buat `BukuHomeWidget` (Carousel horizontal buku pilihan).
  - Buat `BukuListPage` dengan filter tema buku PKN dan pencarian.
  - Buat `BukuDetailPage` lengkap dengan sinopsis, daftar isi, kutipan, dan tombol pemesanan.
- [ ] **Task 1.5 — Modul 3 (Profil & Rekan — Tokoh & Lembaga):**
  - Buat `TokohLembagaHomeWidget` (Avatar strip figur teladan di Beranda).
  - Buat `TokohLembagaListPage` dengan segmented switcher `[Tokoh Pakar | Lembaga Mitra]`:
    - 4 Tokoh Asatidzah: Ust. Abdul Kholiq, Ust. Bayu, Prof Iman, Ummu Khusna.
    - 6 Lembaga: SKIS, HU, SOTAB, Darul Atsar, YBIT, YBIM.
  - Buat `TokohDetailPage` dan `LembagaDetailPage`.
- [ ] **Task 1.6 — Modul 4 (Kemitraan Lembaga):**
  - Buat `KemitraanHomeWidget` (Grid 2x2: Konsultasi Online, Visitasi, Coaching Guru, Daurah).
  - Buat `KemitraanListPage` katalog spesifikasi 4 layanan resmi.
  - Buat `KemitraanDetailPage` & form pengajuan kerjasama.
- [ ] **Task 1.7 — Pengujian & Validasi Fase 1:**
  - Tulis widget test untuk Home Bento Grid, Event List, Buku List, dan Tokoh/Lembaga (target 100% lulus, 0 linter issues).

---

## 3. Fase 2: Identitas Pengguna & Khazanah Ilmu Lengkap

*Fokus: Mengukuhkan profil akun pengguna, sistem lencana, dan perpustakaan ilmu Wiki (penulis & AI).*

### Task List Fase 2:
- [ ] **Task 2.1 — Modul 5 (User & Profil Pengguna):**
  - Hubungkan `UserBottomBarButton` (Tab 5).
  - Buat `UserHomeWidget` (Header salam hangat & avatar di pucuk Beranda).
  - Buat `UserDetailPage` yang menampilkan profil diri, peranan keluarga, pengaturan aplikasi, dan rak koleksi `EventProfileBadge`.
- [ ] **Task 2.2 — Modul 6.1 (Wiki Penulis & Media Pembelajaran):**
  - Tampilkan 6 sub-format konten penulis: Artikel/Postingan, Rekaman Kajian (dengan floating audio bar), Slide Presentasi, Modul Kurikulum, Lembar Kerja (Worksheet), dan Case Study.
- [ ] **Task 2.3 — Modul 6.2 (Wiki AI, Paradigma & Software Bantuan):**
  - Tampilkan direktori paradigma: Insan, Pendidikan Ideal, Implementasi, Tazkiyatun Nafs, Ensiklopedi Bakat, Referensi, Perbandingan.
  - Tampilkan Tips Cepat P3K dan Dzikir & Doa harian.
  - Sediakan integrasi Software Bantuan (OpenBayan, Qaf, Quran.org, Tafsirweb, yufid).
- [ ] **Task 2.4 — Wiki Explore, Reader & Search:**
  - Buat `WikiExplorePage` dengan navigasi tab segmented.
  - Buat `WikiDetailPage` dengan kenyamanan baca teks (font Merriweather, Amiri Arabic, takhrij dalil).
  - Integrasi pencarian FTS5 lokal.
  - Sediakan `WikiUserWidget` (Bookmark & riwayat baca) di Profil User.

---

## 4. Fase 3: Instrumen Personal, Neraca Adab & Onboarding Terpandu

*Fokus: Menghadirkan instrumen muhasabah harian, evaluasi bakat, hubungan keluarga, dan setup data awal.*

### Task List Fase 3:
- [ ] **Task 3.1 — Setup Drift Database Lokal (`local_userdata.db`):**
  - Pasang `drift`, `drift_flutter`, `sqlite3_flutter_libs`.
  - Compile tabel-tabel Drift sesuai `DATABASE_AND_BACKEND_SCHEMA.md`.
- [ ] **Task 3.2 — Modul 7 (Tafsir Bakat 40 / TB-40):**
  - Buat `Tb40HomeWidget` (Kartu bakat aktif).
  - Buat `Tb40ToolPage` (Dashboard bakat & radar chart 4 rumpun via `fl_chart`).
  - Buat `Tb40ListPage` (Katalog 40 bakat fitrah).
  - Buat `Tb40DetailPage` (Ulasan makna, sisi Ihsan vs sisi Afat/over-investment, peran peradaban syakilah).
  - Buat `Tb40UserWidget` (Radar chart bakat di Profil User).
- [ ] **Task 3.3 — Modul 8 (Ceklist Harian & Review Kualitas Amalan):**
  - Buat `CeklistHomeWidget` (Progress bar amanah hari ini).
  - Buat `CeklistToolPage` dan `CeklistListPage` (Amanah Diri, Keluarga, Belajar, Ibadah).
  - Buat `CeklistReviewModal` (Muhasabah non-gamified: Muthma'innah, Lawwamah, Ammarah).
  - Buat `CeklistUserWidget` (Neraca istiqomah sepekan di Profil User).
- [ ] **Task 3.4 — Modul 9 (Relasi Qalbiyah):**
  - Buat `RelasiHomeWidget` (Status Tangki Cinta relasi aktif).
  - Buat `RelasiToolPage` (Neraca qalbiyah & tadabbur AI).
  - Buat `RelasiListPage` dan `RelasiDetailPage` (Profil anggota keluarga, fase fitrah usia, catatan adab, dan rekomendasi hikmah).
  - Buat `RelasiUserWidget` di Profil User.
- [ ] **Task 3.5 — Modul 10 (Onboarding 4 Langkah):**
  - Bangun Wizard interaktif 4 langkah: Data Diri -> Data Pekerjaan -> Data Relasi -> Data Ceklist Harian.
  - Sediakan tombol "Lewati / Nanti Saja".
  - Pastikan pengisian onboarding langsung menginisialisasi Profil User, relasi pertama, dan ceklist default.
  - Sediakan opsi edit ulang onboarding di Pengaturan Profil User.

---

## 5. Fase 4: Pendampingan Batin AI, Cerita Interaktif & Peluncuran Rilis

*Fokus: Fitur batin kontemplatif tingkat lanjut dan validasi rilis multiplatform.*

### Task List Fase 4:
- [ ] **Task 4.1 — Modul 11 (Curhat AI & Ruang Qalbu):**
  - Hubungkan `CurhatBottomBarButton` (Tab 4).
  - Buat `CurhatHomeWidget` (Kartu ajakan kontemplasi).
  - Buat `CurhatToolPage` (Pijakan topik, tombol Walkie-Talkie Push-to-Talk dengan animasi living waveform).
  - Buat `CurhatListPage` (Riwayat percakapan tersimpan aman secara luring).
  - Buat `CurhatDetailPage` (Dialog tenang, doa penenang, ekspor RPP Adab).
- [ ] **Task 4.2 — Modul 12 (Cerita Interaktif & Serial Zaid):**
  - Buat `CeritaHomeWidget` (Kartu episode aktif).
  - Buat `CeritaToolPage` (Katalog skenario krisis pengasuhan per fase usia anak).
  - Buat `CeritaListPage` dan `CeritaDetailPage` (Simulasi dialog bercabang, monolog cermin batin bakat TB-40, ulasan adab nabawiyah).
- [ ] **Task 4.3 — Standalone Web Release & Android Validation:**
  - Build produksi rilis Web (`flutter build web --release`).
  - Verifikasi akses lokal (`localhost:3010`) dan remote Tailscale.
  - Uji jalankan di Android Studio / perangkat fisik Android.
  - Jalankan seluruh automated test suite (0 failures, 0 lint warnings).
