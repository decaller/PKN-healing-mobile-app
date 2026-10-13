# Roadmap Implementasi 4 Fase Menuju `/home/abuhafi/Project/pkn-mobile`

> **Rencana Kerja Eksekusi Modular Bertahap & Desain Komposisi Antarmuka**  
> Mengarahkan transisi dari cetak biru arsitektur v2 menuju basis kode nyata yang bersih, modular, dan teruji di [`/home/abuhafi/Project/pkn-mobile`](file:///home/abuhafi/Project/pkn-mobile).

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

## 2. Desain Komposisi Aplikasi Secara Teks (Textual Wireframe & Layout Architecture)

Bagian ini memvisualisasikan susunan hierarki antarmuka, tata letak visual (*wireframe layout*), dan interaksi komponen di seluruh layar aplikasi.

---

### A. Komposisi Shell Navigasi Utama & Floating Frosted Dock (5 Tab)

```
┌──────────────────────────────────────────────────────────────────────┐
│ [TOP STATUS BAR: Waktu Shalat, Sinyal, Jam 09:41]                    │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│                    AREA KONTEN DINAMIS (ROUTER VIEW)                 │
│         (Beranda | Event | Wiki | Curhat AI | Profil User)           │
│                                                                      │
│                                                                      │
├──────────────────────────────────────────────────────────────────────┤
│  ┌────────────────────────────────────────────────────────────────┐  │
│  │       FLOATING FROSTED ACRYLIC NAVIGATION DOCK (BLUR 20PX)     │  │
│  │ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────┐ │  │
│  │ │    🏠    │ │    📅    │ │    📖    │ │    🤍    │ │   👤   │ │  │
│  │ │ Beranda  │ │  Event   │ │   Wiki   │ │  Curhat  │ │ Profil │ │  │
│  │ └──────────┘ └──────────┘ └──────────┘ └──────────┘ └────────┘ │  │
│  └────────────────────────────────────────────────────────────────┘  │
│ [BOTTOM SAFE AREA PADDING: 24PX]                                     │
└──────────────────────────────────────────────────────────────────────┘
```

---

### B. Komposisi Halaman Beranda (HomeScreen Modular Wireframe)

```
┌──────────────────────────────────────────────────────────────────────┐
│ 👤 Ahlan wa Sahlan, Abu Zaid           [🌙/☀️ Theme] [⚙️ Pengaturan] │
│ 🌿 Jiwa Hari Ini: Tenang (Nafs Muthma'innah)                         │
├──────────────────────────────────────────────────────────────────────┤
│ 🔍 [ Cari khazanah dalil, sirah, bakat...     ] [🎙️ PTT Ruang Qalbu] │
│ 📜 Ticker Dalil: "Barangsiapa menyucikan jiwanya, sungguh ia menang" │
├──────────────────────────────────────────────────────────────────────┤
│ 🌟 HIGHLIGHTS CAROUSEL (Horizontal Snap Scroll)                      │
│ ┌───────────────────────────┐ ┌───────────────────────────┐          │
│ │ 📅 Daurah Parenting H-3   │ │ 📖 Artikel Pilihan:       │ ➔ Geser   │
│ │ "Mendidik Tanpa Membentak"│ │ "Koneksi Sebelum Koreksi" │          │
│ └───────────────────────────┘ └───────────────────────────┘          │
├──────────────────────────────────────────────────────────────────────┤
│ 📝 AMANAH & AMALAN HARI INI (Collapsible List / Carousel)             │
│ [Progress: ●●●○○ 3/5 Ditunaikan]                      [Buka Semua ↗] │
│ • [✓] Shalat Dhuha & Doa Ketenangan Jiwa                             │
│ • [✓] Dekap Ananda Zaid 3 Menit (Bahasa Tubuh & Mata)                │
│ • [ ] Tilawah 1 Maqra' & Tadabbur QS. Luqman                         │
├──────────────────────────────────────────────────────────────────────┤
│ 🧩 BENTO FEATURES HUB (Modular Navigation Grid)                      │
│ ┌─────────────────────────┬────────────────────────────────────────┐ │
│ │ 🎯 Tafsir Bakat 40      │ 👥 Relasi & Tangki Cinta               │ │
│ │ Spider Radar 4 Rumpun   │ Zaid (95%) • Maryam (80%) • Ummu (90%) │ │
│ │ [Buka Dashboard Bakat ↗]│ [Cek Neraca Qalbiyah ↗]                │ │
│ ├─────────────────────────┴────────┬───────────────────────────────┤ │
│ │ 🚑 P3K SOP Tantrum 10 Detik      │ 📚 Buku Pustaka Nabawiyah     │ │
│ │ Panduan Redam Emosi Kilat        │ Katalog Karya Asatidzah PKN   │ │
│ └──────────────────────────────────┴───────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ 🎬 SERIAL ZAID — SIMULASI REHEARSAL ADAB (Multi-Serial Carousel)     │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ Episode 4: "Ketika Zaid Menolak Shalat Saat Bermain"             │ │
│ │ Fase Tamyiz (8 Th) • Latih Respon Tanpa Bentakan • [Mulai ➔]     │ │
│ └──────────────────────────────────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ 🤝 KERJASAMA LEMBAGA (Grid 2x2 Action Tiles)                         │
│ ┌────────────────────────────┬─────────────────────────────────────┐ │
│ │ 💬 Konsultasi Online       │ 🏫 Visitasi Lapangan                │ │
│ ├────────────────────────────┼─────────────────────────────────────┤ │
│ │ 🎓 Coaching Guru Karakter  │ 📢 Pengadaan Daurah / Seminar       │ │
│ └────────────────────────────┴─────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ 👥 TOKOH ASATIDZAH & LEMBAGA MITRA (Avatar Strip Horizontal)         │
│ (Ust. Abdul Kholiq) (Prof Iman) (Ust. Bayu) [SKIS] [SOTAB] [HU] ➔    │
├──────────────────────────────────────────────────────────────────────┤
│ [SPACER DOCK 100PX]                                                  │
└──────────────────────────────────────────────────────────────────────┘
```

---

### C. Komposisi Tab 2: Event (Agenda & Majelis Akbar)

```
┌──────────────────────────────────────────────────────────────────────┐
│ ← Agenda Daurah & Majelis Akbar                       [🔔 Pengingat] │
├──────────────────────────────────────────────────────────────────────┤
│ [Semua] [Daurah Parenting] [Seminar Karakter] [Temu Lembaga] [Kajian]│
├──────────────────────────────────────────────────────────────────────┤
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🖼️ BANNER ACARA (Landscape 16:9)                                  │ │
│ │ 🏷️ Daurah Akbar Nasional PKN 2026                 [Badge Resmi]  │ │
│ │ 🎙️ Pemateri: Ust. Abdul Kholiq & Prof Iman                       │ │
│ │ 📅 Sabtu, 24 Oktober 2026 • 08.00 - 15.00 WIB                    │ │
│ │ 📍 Masjid Jami' Kuttab / Daring Zoom                             │ │
│ │ [Detail Acara & Kuota ↗]                 [Daftar & Klaim Badge ➔]│ │
│ └──────────────────────────────────────────────────────────────────┘ │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🖼️ Seminar Online: "Memulihkan Luka Pengasuhan Masa Lalu"        │ │
│ │ 🎙️ Pemateri: Ust. Bayu & Ummu Khusna                             │ │
│ │ 📅 Ahad, 1 November 2026 • 09.00 WIB                             │ │
│ │ [Detail Acara ↗]                                      [Daftar ➔] │ │
│ └──────────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────┘
```

---

### D. Komposisi Tab 3: Wiki Khazanah Ilmu PKN (Explore & Reader)

```
┌──────────────────────────────────────────────────────────────────────┐
│ 📖 Khazanah Intelektual PKN                     [🔍 Search FTS5]     │
├──────────────────────────────────────────────────────────────────────┤
│ [TAB SWITCHER: ✍️ Penulis & Media | 🧠 Paradigma & AI | 🛠️ Software] │
├──────────────────────────────────────────────────────────────────────┤
│ • MODE 1: PENULIS & MEDIA                                            │
│   [Artikel] [Rekaman Audio] [Slide] [Modul Ajar] [Lembar Kerja]      │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 📄 "Hakikat Tiga Bahasa Mendidik dalam Menautkan Jiwa Anak"    │ │
│   │ ⏱️ Baca < 10 detik • Tesis Ringkas • Oleh: Ust. Abdul Kholiq   │ │
│   │ 🎧 Tersedia Audio Kajian Hands-Free (24:15)                    │ │
│   └────────────────────────────────────────────────────────────────┘ │
│ • MODE 2: PARADIGMA & TAZKIYATUN NAFS                                │
│   [P1 Hakikat Insan] [P2 Tiga Bahasa] [P3 Bakat 40] [P4 4 Fase Usia] │
│ • MODE 3: SOFTWARE BANTUAN DIGITAL                                   │
│   ┌───────────────┬───────────────┬────────────────┬───────────────┐ │
│   │ [OpenBayan ↗] │   [Qaf ↗]     │  [Quran.org ↗] │ [Tafsirweb ↗] │ │
│   │ Semantik Quran│ Nahwu Sharaf  │ Mushaf Digital │ Tafsir Mu'tabar││
│   └───────────────┴───────────────┴────────────────┴───────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ 🎧 FLOATING MINI AUDIO BAR (Jika memutar rekaman kajian sirah):      │
│ [▶ Play/Pause] Kajian Tazkiyatun Nafs — Ust. Abdul Kholiq [12:00/24] │
└──────────────────────────────────────────────────────────────────────┘
```

---

### E. Komposisi Tab 4: Curhat AI (Ruang Qalbu & Walkie-Talkie PTT)

```
┌──────────────────────────────────────────────────────────────────────┐
│ 🤍 Ruang Qalbu (Teman Curhat Amanah)           [🔒 Zero-Cloud Luring]│
├──────────────────────────────────────────────────────────────────────┤
│ "Ceritakan gundahmu tanpa takut dihakimi. Setiap jiwa pernah lelah." │
├──────────────────────────────────────────────────────────────────────┤
│ 💡 PIJAKAN PERMULAAN (Pilih Topik Dialog):                           │
│ [💔 Lelah Menghadapi Anak] [⚡ Menahan Amarah Ego] [🤝 Konflik Pasutri]│
├──────────────────────────────────────────────────────────────────────┤
│ 💬 THREAD DIALOG BATIN:                                              │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 👤 User: "Bunda tadi siang membentak Maryam karena susu tumpah,  │ │
│ │           sekarang hati terasa sangat bersalah dan pedih..."     │ │
│ └──────────────────────────────────────────────────────────────────┘ │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🕊️ Asisten Ruang Qalbu:                                          │ │
│ │   "Tarik nafas perlahan, Bunda. Rasa bersalah ini adalah tanda   │ │
│ │   Nafs Lawwamah yang hidup. Amarah tadi adalah letupan ego fisik,│ │
│ │   bukan kebencian. Rasulullah ﷺ bersabda: 'Bukanlah orang kuat   │ │
│ │   itu yang pandai bergulat, tetapi yang menahan marahnya.'       │ │
│ │   Malam ini, dekap Maryam saat tertidur dan bacakan doa ini..."  │ │
│ │   [📌 Sematkan Doa ke Ceklist]  [📄 Ekspor RPP Keluarga PDF]     │ │
│ └──────────────────────────────────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ 🎙️ PUSH-TO-TALK LIVING WAVEFORM BUTTON (Tekan & Bicara Hangat):      │
│               [   ((((  🎙️ TEKAN UNTUK CURHAT  ))))   ]              │
│                 Gelombang Suara Hidup Berdenyut Lembut               │
└──────────────────────────────────────────────────────────────────────┘
```

---

### F. Komposisi Tab 5: Profil User (Agregator Capaian & Identitas)

```
┌──────────────────────────────────────────────────────────────────────┐
│ 👤 Profil Pejuang Fitrah                            [⚙️ Pengaturan]  │
├──────────────────────────────────────────────────────────────────────┤
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ [Avatar Fitrah]  Abu Zaid (Harridi)               [Peran: Ayah]  │ │
│ │ Aktivitas: Pendidik & Kepala Keluarga • Zona: Asia/Jakarta       │ │
│ └──────────────────────────────────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ 🎖️ EVENT BADGES RACK (Koleksi Lencana Daurah & Majelis Resmi)        │
│ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐               │
│ │ 🏅 Daurah B1  │ │ 🏅 SOTAB 2026 │ │ 🏅 Adab Syaraf│ +2 Lainnya ➔  │
│ │ Lulus Kurikulum│ │ Peserta Aktif │ │ Verifikasi    │               │
│ └───────────────┘ └───────────────┘ └───────────────┘               │
├──────────────────────────────────────────────────────────────────────┤
│ 🎯 TB-40 RADAR USER WIDGET (Profil Bakat Dominan Diri)               │
│ Spider Chart 4 Rumpun: Qiyadah (85%) • Fashahah (90%) • Idarah (70%) │
│ Bakat Dominan: ⚡ Syajaa'ah (Ketegasan) • 🕊️ Rifq (Kelembutan)       │
│ [Buka Alat Asesmen Lengkap ↗]                                        │
├──────────────────────────────────────────────────────────────────────┤
│ 👥 LINGKARAN RELASI USER WIDGET (Keluarga & Sahabat Dekat)           │
│ • Ananda Zaid (8 Th, Tamyiz) — Tangki Cinta: 95% (Hangat)            │
│ • Ummu Zaid (Pasangan) — Tangki Cinta: 90% (Harmonis)                │
│ • Sahabat Abu Bakar (Rekan Dakwah) — Ukhuwah: Terjalin Erat          │
│ [Kelola Relasi & Catatan Adab ↗]                                     │
├──────────────────────────────────────────────────────────────────────┤
│ ⚖️ NERACA ISTIQOMAH AMALAN ADAB (Mizan Balance Scale Widget)         │
│ Senin s.d. Ahad: 88% Tertunaikan • Dominan: Nafs Muthma'innah        │
│ [Lihat Riwayat Muhasabah Sepekan ↗]                                  │
└──────────────────────────────────────────────────────────────────────┘
```

---

### G. Komposisi Tool Page 7: Tafsir Bakat 40 (TB-40 Dashboard)

```
┌──────────────────────────────────────────────────────────────────────┐
│ ← Tafsir Bakat 40 (TB-40)                           [ℹ️ Panduan]     │
├──────────────────────────────────────────────────────────────────────┤
│ 🕸️ SPIDER RADAR CHART 4 RUMPUN (Interactive fl_chart):               │
│             [ Al-Qiyadah (Kepemimpinan & Ketegasan) ]                 │
│                              /     \                                 │
│ [ Al-Fikriyyah (Strategi) ] —   •   — [ Al-Fashahah (Kasih Sayang) ] │
│                              \     /                                 │
│               [ Al-Idarah (Manajemen & Disiplin) ]                   │
├──────────────────────────────────────────────────────────────────────┤
│ [Rumpun: Semua (40)] [Al-Qiyadah (10)] [Al-Fashahah (10)] [Idarah]... │
├──────────────────────────────────────────────────────────────────────┤
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ ⚡ SYAJAA'AH (الشَّجَاعَةُ) — Keberanian Syar'i & Ketegasan Hukum  │ │
│ │ • Sisi Ihsan (Muthma'innah): Tegas membela hak Allah & adab anak.│ │
│ │ • Sisi Afat (Ammarah): Terjebak ghadhab & intimidasi fisik kaku. │ │
│ │ Dalil: HR. Bukhari (Orang kuat menahan marah) • [Buka Detail ➔]  │ │
│ └──────────────────────────────────────────────────────────────────┘ │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🕊️ RIFQ (الرِّفْقُ) — Kelemahlembutan & Kehalusan Jiwa            │ │
│ │ • Sisi Ihsan (Muthma'innah): Sentuhan kasih penakluk hati anak.  │ │
│ │ • Sisi Afat (Ammarah): Pembiaran maksiat atas nama kasihan.      │ │
│ │ Dalil: HR. Muslim 2594 (Rifq menghiasi segala sesuatu) • [Detail]│ │
│ └──────────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────┘
```

---

### H. Komposisi Modal Review Kualitas Amalan Adab (Muhasabah 3 Derajat Jiwa)

```
┌──────────────────────────────────────────────────────────────────────┐
│                    BOTTOM SHEET MUHASABAH ADAB                       │
├──────────────────────────────────────────────────────────────────────┤
│ Amanah: "Menahan Marah saat Anak Menumpahkan Air Minum"              │
│ Status: Selesai Dilaksanakan                                         │
├──────────────────────────────────────────────────────────────────────┤
│ BAGAIMANA KUALITAS SUASANA HATI KETIKA MENUNAIKANNYA?                │
│                                                                      │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🟢 NAFS MUTHMA'INNAH (Jiwa Tenang & Ikhlas)                      │ │
│ │    Hati lapang, berhasil menahan lisan dari celaan, merangkul    │ │
│ │    anak seraya mengajarkan membersihkan tumpahan air bersama.    │ │
│ └──────────────────────────────────────────────────────────────────┘ │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🟡 NAFS LAWWAMAH (Jiwa yang Menyesali Kekurangan)                │ │
│ │    Sempat tersulut nada tinggi sekejap, namun segera sadar,      │ │
│ │    beristighfar, dan meminta maaf kepada anak.                   │ │
│ └──────────────────────────────────────────────────────────────────┘ │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🔴 NAFS AMMARAH (Jiwa yang Dikuasai Ego & Ketergesaan)           │ │
│ │    Terlanjur membentak keras karena lelah kerja seharian.        │ │
│ │    ➔ Sistem memunculkan: Doa Kazhmul Ghaizh & Istighfar Segera.  │ │
│ └──────────────────────────────────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ INDIKATOR PERTUMBUHAN ADAB KUALITATIF:                               │
│ [BT: Belum Tampak] [MT: Mulai Tampak] [BK: Berkembang] [MM: Budaya]  │
├──────────────────────────────────────────────────────────────────────┤
│ Catatan Hati (Muhasabah Personal): [Tulis refleksi di sini...]       │
│ [Simpan Evaluasi Batin ➔]                                            │
└──────────────────────────────────────────────────────────────────────┘
```

---

### I. Komposisi Onboarding Wizard 4 Langkah + TB-40 Fast-Track Button

```
┌──────────────────────────────────────────────────────────────────────┐
│ [Langkah 1 dari 4: Identitas Diri]               [Lewati / Nanti ↗]  │
│ ●●○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○○ Progress 25%    │
├──────────────────────────────────────────────────────────────────────┤
│ Siapakah Nama / Kunyah Anda?                                         │
│ [ Input: Abu Zaid                                                  ] │
│                                                                      │
│ Apa Peran Utama Anda Saat Ini?                                       │
│ [Ayah]   [Bunda]   [Guru / Ustadz]   [Santri / Siswa]   [Mandiri]    │
├──────────────────────────────────────────────────────────────────────┤
│ ⚡ BUTUH ASESMEN CEPAT?                                               │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ 🎯 [TOMBOL AKSES LANGSUNG TOOLS TAFSIR BAKAT 40]                 │ │
│ │ Lompat langsung mencoba pemetaan 40 bakat fitrah tanpa form ini. │ │
│ └──────────────────────────────────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│                                                [Lanjut: Pekerjaan ➔] │
└──────────────────────────────────────────────────────────────────────┘
```

---

### J. Komposisi Cerita Interaktif: Rehearsal Pengasuhan Serial Zaid

```
┌──────────────────────────────────────────────────────────────────────┐
│ ← Serial Zaid (Ep. 4: Krisis Waktu Shalat)             [Fase Tamyiz] │
├──────────────────────────────────────────────────────────────────────┤
│ 📖 SITUASI KRISIS:                                                   │
│ "Adzan Ashar berkumandang. Zaid (8 tahun) sedang asyik merakit balok │
│ istana bersama adiknya. Ketika dipanggil untuk berwudhu, Zaid        │
│ berteriak: 'Nanti dulu Ayah! Sebentar lagi istanaku runtuh!'"        │
├──────────────────────────────────────────────────────────────────────┤
│ 🧠 MONOLOG CERMIN BATIN BAKAT TB-40:                                 │
│ ┌──────────────────────────────────────────────────────────────────┐ │
│ │ ⚡ Bakat Syajaa'ah: "Shalat tidak boleh ditunda! Tegaskan aturan!" │ │
│ │ 🕊️ Bakat Rifq: "Dia sedang asyik, jangan bentak, dekati tubuhnya." │ │
│ │ 🧠 Bakat Hikmah: "Gunakan Bahasa Tubuh; hampiri dan sejajarkan mata."│
│ └──────────────────────────────────────────────────────────────────┘ │
├──────────────────────────────────────────────────────────────────────┤
│ BAGAIMANA RESPON ANDA?                                               │
│                                                                      │
│ [A. Opsi Mumtaz (Nafs Muthma'innah)]:                                │
│ "Mendekat, berlutut setara mata Zaid, elus punggungnya: 'Istananya   │
│ bagus sekali, Nak. Yuk kita jeda 10 menit shalat bersama Ayah.'"     │
│                                                                      │
│ [B. Opsi Hasan (Nafs Lawwamah)]:                                     │
│ "Mematikan mainannya dari jauh lalu menyuruhnya bergegas wudhu."     │
│                                                                      │
│ [C. Opsi Munkar (Nafs Ammarah)]:                                     │
│ "Membentak: 'Zaid! Tinggalkan mainan itu atau Ayah buang ke tempat   │
│ sampah! Kamu mau masuk neraka?!'"                                    │
├──────────────────────────────────────────────────────────────────────┤
│ [Umpan Balik Syar'i & Atsar Salaf Muncul Setelah Pilihan Diklik ➔]   │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 3. Fase 1: Inisialisasi Proyek, Shell 5 Tab & Modul Katalog Publik

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

## 4. Fase 2: Identitas Pengguna & Khazanah Ilmu Lengkap

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

## 5. Fase 3: Instrumen Personal, Neraca Adab & Onboarding Terpandu

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
- [ ] **Task 3.3 — Modul 8 (Ceklist Harian Wirid Adab & Tazkiyatun Nafs):**
  - Buat `CeklistHomeWidget` (`Collapsible List Section` dengan status progress pill).
  - Buat `CeklistToolPage` dan `CeklistListPage` terbagi dimensi: Takhalli (tahan amarah *kazhmul ghaizh*, puasa lisan, cek nafkah halal) & Tahalli (qiyamullail, zikir pagi-petang, shalat awal waktu, dekap anak).
  - Buat `CeklistReviewModal` (Muhasabah 3 derajat jiwa: *Nafs Muthma'innah*, *Nafs Lawwamah*, *Nafs Ammarah* dengan rubrik fitrah BT-MT-BK-MM).
  - Buat `CeklistUserWidget` (Mizan balance scale / grafik stacked bar istiqomah sepekan di Profil User).
- [ ] **Task 3.4 — Modul 9 (Relasi Keluarga dan Teman Dekat):**
  - Buat `RelasiHomeWidget` (`Carousel` status Tangki Cinta & kehangatan ukhuwah).
  - Buat `RelasiToolPage` (Neraca qalbiyah & tadabbur AI esok hari).
  - Buat `RelasiListPage` dan `RelasiDetailPage` (Profil anggota keluarga & sahabat seperjuangan dakwah, catatan adab, dan rekomendasi hikmah).
  - Buat `RelasiUserWidget` di Profil User.
- [ ] **Task 3.5 — Modul 10 (Onboarding 4 Langkah + Jalan Pintas TB-40):**
  - Bangun Wizard interaktif 4 langkah: Data Diri -> Data Pekerjaan -> Data Relasi -> Data Ceklist Harian.
  - Sediakan tombol pintas langsung di layar pembuka: **"Akses Langsung Tools Tafsir Bakat 40"** untuk mencoba asesmen tanpa wajib menyelesaikan seluruh wizard.
  - Sediakan tombol "Lewati / Nanti Saja" di tiap tahapan.
  - Inisialisasi otomatis data User, relasi pertama, dan ceklist default.
  - Sediakan opsi edit ulang onboarding di Pengaturan Profil User.

---

## 6. Fase 4: Pendampingan Batin AI, Cerita Interaktif & Peluncuran Rilis

*Fokus: Fitur batin kontemplatif tingkat lanjut dan validasi rilis multiplatform.*

### Task List Fase 4:
- [ ] **Task 4.1 — Modul 11 (Curhat AI & Ruang Qalbu):**
  - Hubungkan `CurhatBottomBarButton` (Tab 4).
  - Buat `CurhatHomeWidget` (Banner pemicu kontemplasi).
  - Buat `CurhatToolPage` (Pijakan topik, tombol Walkie-Talkie Push-to-Talk dengan animasi living waveform).
  - Buat `CurhatListPage` (Riwayat percakapan tersimpan aman secara luring).
  - Buat `CurhatDetailPage` (Dialog tenang, doa penenang jiwa, ekspor RPP Adab).
- [ ] **Task 4.2 — Modul 12 (Cerita Interaktif & Rehearsal Tazkiyatun Nafs):**
  - Buat `CeritaHomeWidget` (`MultiSerialStoryCard` carousel episode aktif Serial Zaid).
  - Buat `CeritaToolPage` (Katalog skenario krisis pengasuhan per fase fitrah usia anak: Thufulah, Tamyiz, Murahaqah, Syabab).
  - Buat `CeritaListPage` dan `CeritaDetailPage`:
    - Simulasi dialog krisis dengan respon 3 derajat jiwa (*Nafs Muthma'innah / Mumtaz*, *Nafs Lawwamah*, *Nafs Ammarah / Munkar-Ego*).
    - Monolog dialektika batin bakat TB-40 (*Al-Qiyadah* vs *Al-Fashahah* vs *Al-Fikriyyah*).
    - Ulasan hikmah syar'i, atsar salaf, muhasabah pemulihan hutang pengasuhan (*debt of parenting recovery*), dan doa penenang.
- [ ] **Task 4.3 — Standalone Web Release & Android Validation:**
  - Build produksi rilis Web (`flutter build web --release`).
  - Verifikasi akses lokal (`localhost:3010`) dan remote Tailscale.
  - Uji jalankan di Android Studio / perangkat fisik Android.
  - Jalankan seluruh automated test suite (0 failures, 0 lint warnings).
