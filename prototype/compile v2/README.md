# PKN Mobile v2 — Master Architecture Blueprint & Unified Modular Specification

> **Status:** Cetak Biru Arsitektur & Perencanaan Ulang Terverifikasi (v2)  
> **Tanggal Pembaruan:** 13 Oktober 2026  
> **Basis Rujukan Manhaj:** Wiki PKN (*Naskah Induk Manhaj & Tazkiyatun Nafs Tier 1 Active Truth*)  
> **Basis Desain Visual:** Earth-Tree Design System (*Sand Ecru, Mineral Basalt, Meadow Pine, Merriweather, Plus Jakarta Sans, Amiri*)  
> **Framework Host:** Flutter (Dart 3.7+ / Flutter 3.29+)  
> **Target Lokasi Implementasi:** [`/home/abuhafi/Project/pkn-mobile`](file:///home/abuhafi/Project/pkn-mobile)  
> **Arsitektur Data:** Dual-Database Engine Backend v2 (*Drift SQLite Offline-First + LibSQL Vector 384-dim + Directus CMS*)  

---

## 1. Visi Produk & Filosofi Inti (Berdasarkan Manhaj Wiki PKN)

**PKN Mobile** adalah aplikasi saku penenteram jiwa dan pendampingan keluarga berbasis **Manhaj Pendidikan Karakter Nabawiyah (PKN)** dan **Tazkiyatun Nafs Syar'i**. Aplikasi ini dirancang menggunakan filosofi **Dual-Core Calm Technology**:
1. **Pilar 1: Khazanah & Perkakas Nyata (Wiki-Tools Hub):** Solusi situasi nyata < 10 detik, katalog literatur resmi, agenda majelis akbar, dan manajemen adab sehari-hari tanpa beban kognitif berlebih.
2. **Pilar 2: Refleksi Jiwa & Pendampingan Batin (Spiritual AI & Narrative Rehearsal):** Teman curhat beradab tanpa penghakiman (*non-judgmental*), simulasi dialektika suara bakat fitrah (TB-40), serta latihan pengasuhan berbasis adab tanpa kekerasan verbal/fisik.

---

### A. Rantai Nilai Makro (*Macro Value Chain*) Manhaj PKN
Mengacu pada naskah induk `wiki-pkn` (*Master Hub Arsitektur 00*):

```
       ┌────────────────────────────────────────────────────────┐
       │               HAKIKAT INSAN & TUJUAN HIDUP             │
       │    (Ibadah Tauhid, Khilafah Fil Ardh, Tazkiyatun Nafs)  │
       └───────────────────────────┬────────────────────────────┘
                                   │
       ┌───────────────────────────┴────────────────────────────┐
       ▼                                                        ▼
┌─────────────────────────────┐        ┌─────────────────────────────┐
│    FORMULA INTI MANHAJ      │        │   ALUR TRANSFORMASI NILAI   │
│  Amal (What: Lahiriah)      │        │  1. Jiwa Pendidik (Tazkiyah)│
│       ▲                     │        │  2. Peran Pendidik (Wasath) │
│  Ilmu (How: Penalaran)      │        │  3. Metode Mendidik (3 Bhs) │
│       ▲                     │        │  4. Materi Pendidikan (MOC) │
│  Iman (Why: Cinta & Tauhid) │        │  5. Implementasi Kelembagaan│
└─────────────────────────────┘        └─────────────────────────────┘
```

- **Formula Inti:** Perubahan amal lahiriah (*What*) bersumber dari penalaran ilmu yang lurus (*How*), yang bermula dari kekokohan iman dan keterikatan cinta batin (*Why*).
- **Target Akhir Tarbiyah:** Menghasilkan generasi pemuda mukallaf yang **Sholih** (selamat akidah & ibadahnya) dan **Muslih** (pelopor peradaban yang memberi manfaat luas bagi ummah).

---

### B. Epistemologi Tazkiyatun Nafs Pendidik
Dalam manhaj PKN, **Tazkiyatun Nafs** (penyucian jiwa) adalah jantung utama pendidikan. Tarbiyah nabawiyah bukanlah transfer informasi mekanis, melainkan **resonansi spiritual (*al-hal anfa' minal maqal*)** di mana frekuensi kesucian kalbu pendidik memancarkan getaran hikmah yang langsung meresap ke dalam sanubari anak.

Proses tazkiyah berlangsung melalui dua tahapan berkesinambungan:
1. **Fase Takhalli (Detoksifikasi Bejana Batin Pendidik):**
   - *Mengikis Riya' Pengasuhan & Gengsi Sosial:* Menghilangkan syirik kecil berupa keinginan dipuji sebagai orang tua sukses atau membanggakan anak di mata manusia (HR. Ahmad No. 23630).
   - *Membuang Ego dan Amarah (Ghadhab):* Melatih pengendalian amarah (*kazhmul ghaizh*, QS. Ali 'Imran: 134) dan menahan dorongan membentak/memukul anak (HR. Bukhari No. 6116).
   - *Menjauhkan Harta Syubhat & Makanan Haram:* Menjaga kehalalan asupan agar tidak mematikan nurani dan tidak menghalangi terkabulnya doa pengasuhan (HR. Bukhari No. 52, HR. Muslim No. 1015).
2. **Fase Tahalli (Penghiasan Bejana Jiwa dengan Akhlak Nabawiyah):**
   - *Keikhlasan Niat (Lillahi Ta'ala):* Membebaskan diri dari pamrih ucapan terima kasih atau balas budi anak di masa tua (HR. Bukhari No. 1).
   - *Kelemahlembutan (Ar-Rifq):* Menggunakan kelembutan sebagai instrumen pengubah perilaku paling ampuh tanpa meremukkan fitrah (HR. Muslim No. 2594).
   - *Qiyamullail (Generator Spiritualitas Pengasuhan):* Mengisi ulang energi kesabaran dan ketabahan batin di sepertiga malam terakhir (QS. Al-Muzzammil: 1–6).
   - *Dawamul 'Amal (Istiqamah Amalan Harian):* Konsisten menjaga wirid amalan sunnah dan adab keseharian (HR. Bukhari No. 6464).
   - *Menuju Qalbun Salim:* Merawat hati yang selamat dan suci saat kembali menghadap Allah (QS. Asy-Syu'ara: 88–89).

---

### C. Kaidah Asas Pengasuhan & Pemulihan Jiwa
- **Prinsip In'ikas (Pantulan Spiritual):** Kebeningan hati orang tua tercermin pada kelembutan tabiat anak; kemaksiatan orang tua sering kali memantul pada pembangkangan anak (atsar Utbah bin Abi Sufyan dan Al-Fudhail bin 'Iyadh).
- **Koneksi Sebelum Koreksi (*Connection Before Correction*):** Tautkan hati dan penuhi *Tangki Cinta* anak sebelum menegakkan aturan atau meluruskan kekeliruan.
- **Pemulihan Hutang Pengasuhan (*Debt of Parenting Recovery*):** Menuntaskan luka masa lalu orang tua secara vertikal (taubat nasuha & tazkiyah) dan horizontal (merangkul dan meminta maaf).
- **Tiga Bahasa Mendidik:**
  1. *Bahasa Tubuh:* Postur tenang, mendekat setara tinggi mata anak, dekapan yang memberi rasa aman.
  2. *Bahasa Mata:* Kontak mata teduh yang memancarkan penerimaan dan cinta tulus.
  3. *Bahasa Hati:* Komunikasi jiwa yang memvalidasi emosi sebelum memberikan bimbingan syar'i.
- **Kaidah Tadarruj (4 Tangga Fase Usia Fitrah):**
  1. *Fase Thufulah (2–7 Tahun):* Fitrah keimanan & bermain; haram sanksi fisik; tanpa doktrin menakut-nakuti neraka.
  2. *Fase Tamyiz (7–10 Tahun):* Pembedaan baik-buruk; pembiasaan shalat 5 waktu bertahap tanpa pukulan.
  3. *Fase Murahaqah (10–14 Tahun):* Pemisahan ranjang (*madhaji'*), batas disiplin syar'i sanksi 10 tahun (larangan keras memukul wajah), penguatan rasa malu (*haya'*).
  4. *Fase Syabab (14–18+ Tahun):* Kematangan aqil baligh mukallaf, penjagaan kehormatan (*iffah*), dan penemuan peran peradaban (*syakilah*).

---

### D. Prinsip Anti-Guilt UX & Non-Gamification
- **Bebas Streak Shaming:** Tidak ada notifikasi pemaksa (*"Kamu kehilangan streak 10 hari!"*). Pengguna yang rehat disambut dengan salam kehangatan dan doa ketenangan jiwa.
- **Bebas Leaderboard Riya':** Tidak ada sistem ranking komparatif antar-keluarga atau antar-santri yang memicu kesombongan atau rasa rendah diri.
- **Metrik Adab Kualitatif Otentik:** Penilaian perkembangan adab menggunakan rubrik fitrah:
  - **BT** (*Belum Tampak*): Perilaku adab belum muncul secara konsisten.
  - **MT** (*Mulai Tampak*): Mulai muncul dengan stimulasi atau pengingat santun.
  - **BK** (*Berkembang*): Muncul atas kesadaran mandiri di sebagian besar kesempatan.
  - **MM** (*Membudaya*): Telah menjadi karakter alami dan menginspirasi sekitar.

---

## 2. Struktur Navigasi & Pola Komponen Modular Terpadu

Navigasi utama menggunakan **Floating Frosted Acrylic Dock 5 Tab** di bagian bawah layar:

```
┌────────────────────────────────────────────────────────────────────────┐
│                        SHELL NAVIGASI 5 TAB                            │
├───────────────┬───────────────┬───────────────┬───────────────┬────────┤
│   Tab 1:      │    Tab 2:     │    Tab 3:     │    Tab 4:     │ Tab 5: │
│   BERANDA     │    EVENT      │     WIKI      │   CURHAT AI   │ PROFIL │
│   (Home)      │   (Agenda)    │  (Khazanah)   │ (Ruang Qalbu) │ (User) │
└───────────────┴───────────────┴───────────────┴───────────────┴────────┘
```
*Catatan:* Modul **Cerita Interaktif**, **Buku**, **Tafsir Bakat 40**, **Ceklist Harian**, **Relasi Keluarga dan Teman Dekat**, dan **Kemitraan Lembaga** dapat diakses melalui kartu unggulan di Beranda, Tool Page khusus, maupun User Widget di Profil. Seluruh modul dilindungi mekanisme **Dynamic Feature Flags** yang adaptif.

---

### Standar Dekomposisi 6 Surface Komponen
Setiap modul dipecah menjadi 6 surface visual yang fleksibel dan konsisten:
1. **Home Widget:** Representasi visual dinamis di Beranda. **Tidak selalu berupa Bento Card**, melainkan mengadopsi model antarmuka yang terbukti di prototipe (`v2`, `v4`, `v5`, `compile`):
   - *Horizontal Carousel:* (Highlights Carousel, Daily Activity Carousel, Serial Story Carousel, Buku Pilihan Carousel).
   - *Bento Grid Card:* (Bento Features Hub, modul agregator).
   - *Collapsible List Section:* (Daily Task Collapsible List dengan status progress pill).
   - *Grid 2x2 Action Tiles:* (Kerjasama Lembaga, P3K SOP Tantrum 10 Detik).
   - *Avatar Strip / Circle Bar:* (Tokoh Asatidzah & Lembaga Mitra).
   - *Header Banner & Search Ticker Bar:* (Header salam personal, Ticker dalil & trigger voice Ruang Qalbu).
2. **Bottom Bar Button:** Tombol tab navigasi langsung (khusus Beranda, Event, Wiki, Curhat AI, dan Profil).
3. **Tool Page / Explore Page:** Halaman dashboard / eksplorasi fungsional modul.
4. **List Page:** Halaman daftar entitas dengan filter, pencarian, dan pengelompokan.
5. **Detail Page:** Tampilan membaca / interaksi mendalam suatu entitas.
6. **User Widget:** Kartu / metrik ringkasan modul terkait yang disematkan di halaman Profil User.

---

## 3. Matriks 12 Modul Utama (Urutan Prioritas Modular)

| No | Modul | Surface Terpasang | Hubungan Data & Peran Inti |
| :---: | :--- | :--- | :--- |
| **1** | **Event (Agenda)** | Home Widget (Bento/Carousel), Bottom Bar, List, Detail, Profile Badge | Daurah, seminar parenting, majelis akbar, filter kategori, badge keikutsertaan di profil. |
| **2** | **Buku (Pustaka)** | Home Widget (Horizontal Carousel), List, Detail | Katalog buku fisik/digital karya asatidzah PKN, sinopsis, daftar isi, pemesanan / bacaan. |
| **3** | **Profil & Rekan** | Home Widget (Avatar Strip), List, Detail | Direktori Tokoh (4 asatidzah: Ust. Abdul Kholiq, Ust. Bayu, Prof Iman, Ummu Khusna) dan Lembaga (SKIS, HU, SOTAB, Darul Atsar, YBIT, YBIM). |
| **4** | **Kemitraan Lembaga** | Home Widget (Grid 2x2 Action Tiles), List, Detail | Program kemitraan v2: Konsultasi Online, Visitasi Lapangan, Coaching Guru, Pengadaan Daurah. |
| **5** | **User (Profil)** | Home Widget (Top Header), Bottom Bar, Detail Page | Identitas akun, peran keluarga/sekolah, koleksi event badges, agregator seluruh User Widget, pengaturan. |
| **6** | **Wiki (Khazanah)** | Home Widget (Search Ticker), Bottom Bar, Explore, Detail, User Widget | Wiki Penulis (6 format media) + Wiki AI (Paradigma, Bakat, Dalil, Doa, Software Bantuan: OpenBayan, Qaf, Quran.org, Tafsirweb, yufid). |
| **7** | **Tafsir Bakat 40** | Home Widget (Radar/Highlight), Tool Page, List, Detail, User Widget | Peta 40 bakat fitrah (sisi Ihsan vs sisi Afat/over-investment), radar chart 4 rumpun via `fl_chart`, cermin batin. |
| **8** | **Ceklist Harian** | Home Widget (Collapsible List), Tool Page, List, Detail, User Widget | Wirid amalan adab harian (*Dawamul 'Amal*), muhasabah Takhalli-Tahalli, modal review 3 derajat jiwa (Muthma'innah, Lawwamah, Ammarah). |
| **9** | **Relasi Keluarga & Teman Dekat** | Home Widget (Carousel Status Cinta), Tool Page, List, Detail, User Widget | Lingkaran keluarga (pasangan, anak per fase usia fitrah, orang tua) & teman dekat/seperjuangan; neraca qalbiyah, Tangki Cinta, tadabbur AI. |
| **10** | **Onboarding** | Wizard 4 Langkah (Diri, Kerja, Relasi, Ceklist) + **Tombol Akses Langsung TB-40** | Personalisasi profil awal terpandu (bisa dilewati) yang menginisialisasi modul 5, 8, 9, serta menyediakan jalan pintas langsung mencoba tools Tafsir Bakat 40. |
| **11** | **Curhat AI** | Home Widget (Action Banner), Bottom Bar, Tool Page, List, Detail | Ruang Qalbu, Walkie-talkie PTT waveform, pijakan dialog, riwayat konsultasi amanah luring (*zero retention*). |
| **12** | **Cerita Interaktif** | Home Widget (Multi-Serial Carousel), Tool Hub, List, Detail | Living narrative Serial Zaid, skenario krisis adab 10 detik, respon berjenjang 3 derajat jiwa, dialektika batin bakat TB-40, ulasan takhrij dalil & pemulihan hutang pengasuhan. |

---

## 4. Arsitektur Data Terintegrasi (Backend v2)

Mengadopsi arsitektur dari `prototype/backend v2`:
```
┌────────────────────────────────────────────────────────────────────────┐
│                        FLUTTER CLIENT ENGINE                           │
│  ┌──────────────────────────────┐    ┌──────────────────────────────┐  │
│  │    Drift SQLite Database     │    │   Embedded LibSQL Database   │  │
│  │   (Mutasi & Data Personal)   │    │    (OTA Bundle Zstandard)    │  │
│  │ • User Profile & Badges      │    │ • Wiki Articles FTS5         │  │
│  │ • Ceklist Harian & Muhasabah │    │ • 384-dim Vector Embeddings  │  │
│  │ • Relasi Keluarga & Teman    │    │ • Katalog Buku & Tokoh       │  │
│  │ • Outbox Mutation Queue      │    │ • Event & Agenda Daurah      │  │
│  └──────────────┬───────────────┘    └──────────────▲───────────────┘  │
└─────────────────┼───────────────────────────────────┼──────────────────┘
                  │ Sync (REST/HTTP)                  │ OTA Update (.zst)
┌─────────────────▼───────────────────────────────────┴──────────────────┐
│                           BACKEND v2 HUB                               │
│  • Directus CMS (Port 8055): Manajemen Event, Buku, Lembaga, Tokoh    │
│  • Alexandrie Search Engine (Port 8201): FTS5 & Semantic Indexing      │
│  • MCP Stdio Server: 6 Tools AI Knowledge Integration                  │
│  • Build Pipeline: build_knowledge_db.py -> knowledge_v4.db.zst (7 MB) │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 5. Hubungan Dokumen Terkait di Direktori Ini

1. 📋 [MODULAR_MODULES_DECOMPOSITION.md](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/compile%20v2/MODULAR_MODULES_DECOMPOSITION.md) — Rincian teknis 12 modul, variasi surface widget, dan struktur per komponen.
2. 🗄️ [DATABASE_AND_BACKEND_SCHEMA.md](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/compile%20v2/DATABASE_AND_BACKEND_SCHEMA.md) — Skema tabel Drift & LibSQL terpadu yang mencakup relasi keluarga/teman dan riyadhoh harian.
3. 🚀 [PHASED_IMPLEMENTATION_ROADMAP.md](file:///home/abuhafi/Project/PKN-healing-mobile-app/prototype/compile%20v2/PHASED_IMPLEMENTATION_ROADMAP.md) — Rencana aksi eksekusi 4 fase di `/home/abuhafi/Project/pkn-mobile`.
