# Product Requirement Document (PRD)
## Project Name: PKN Healing Mobile App (Pendidikan Karakter Nabawiyah & Tazkiyatun Nafs)
**Version:** 1.0.0-PROD  
**Document Status:** Approved / Canonical Baseline  
**Target Codebases:** `prototype/v0/` (Canonical Native Flutter), `prototype/v1/` (Flutter Web / Device-Preview)  
**Primary Design System:** Executive Nabawi Character & Healing System (`#0B0F14`, `#151D24`, `#14B8A6`, `#EAB308`)

---

## 1. Executive Summary & Product Vision

### 1.1 Latar Belakang & Pernyataan Masalah
Dalam pola pengasuhan (*parenting*) modern, orang tua sering kali menghadapi krisis emosi akut saat anak menunjukkan resistensi atau pembangkangan (misal: tantrum, menolak shalat, mogok belajar). Dalam kondisi beban kognitif tinggi dan kelelahan mental, orang tua kerap terjebak dalam respons impulsif (membentak, mengancam, atau menghukum secara reaktif) yang mengunci reseptor nalar (*amygdala freeze*) anak dan mencederai fitrahnya.

Aplikasi umum yang ada saat ini cenderung mengandalkan pendekatan psikologi sekuler atau gamifikasi superfisial (*streak shaming*, *leaderboard* komparatif, notifikasi agresif) yang justru menambah beban rasa bersalah (*parenting guilt*) bagi orang tua Muslim.

### 1.2 Visi & Nilai Inti Produk
**PKN Healing Mobile App** adalah ekosistem pendampingan pengasuhan berbasis **Pendidikan Karakter Nabawiyah (PKN)** dan **Tazkiyatun Nafs** yang mengintegrasikan:
1. **Pertolongan Pertama Krisis Lapangan (P3K Emosi / Guidance-First):** Protokol taktis instan yang dapat dieksekusi dalam 10 detik saat situasi genting di rumah.
2. **Kearifan Autentik (Otentisitas Manhaj):** Landasan Al-Qur'an dan As-Sunnah Ash-Shahihah dengan taksonomi 6 Pilar Fitrah dan Matriks Syakilah (TB-40).
3. **Simulasi Interaktif Reflektif (Living Rehearsal):** Simulasi skenario adab tanpa konsep *Game Over*, melatih respon orang tua sebelum menghadapi situasi nyata di dunia riil.
4. **Teman Curhat AI yang Terpercaya (Amanah Guard):** Pendampingan muhasabah jiwa berbasis on-device / zero-cloud-leak tanpa nada menghakimi (*non-judgmental*).
5. **Ketenangan & Nol Kebisingan (Anti-Slop Design):** Antarmuka berdensitas informasi tinggi namun tenang, tidak menggunakan trik manipulatif FOMO, kartu bertumpuk sembarangan (*non-card layout*), atau ornamen religius hampa makna.

---

## 2. Target Persona & Situasi Penggunaan (JTBD)

### 2.1 Persona Utama
* **Abu Zaid / Ummu Zaid (Caregiver / Orang Tua Utama)**
  * **Karakteristik:** Memiliki anak usia *Tamyiz* (7–10 tahun) atau *Murahaqah* (remaja), berikhtiar mendidik dengan nilai Islam murni, memiliki waktu terbatas, sering mengalami keletihan mental setelah jam kerja.
  * **Kebutuhan Kritis:** Solusi cepat ketika anak berulah menjelang waktu shalat/maghrib, panduan praktis yang menenangkan tanpa mempermalukan, dan bahan rujukan dalil yang shahih.

### 2.2 Jobs-to-be-Done (JTBD)
1. **Saat Krisis Mendadak (In-the-Moment Emergency):**  
   *"Ketika anak saya mengamuk atau menolak shalat di jam maghrib, saya ingin panduan 3 langkah konkret dalam 10 detik agar amarah saya tidak meledak dan fitrah anak tetap terjaga."*
2. **Saat Muhasabah Malam (Post-Crisis Reflection):**  
   *"Ketika saya merasa bersalah karena sempat bersikap keras seharian, saya ingin mencurahkan beban batin ke AI yang aman dan memetakan kondisi nafs saya ke rujukan doa & istighfar."*
3. **Saat Meningkatkan Kapasitas Diri (Deliberate Learning):**  
   *"Saya ingin memahami keunikan bakat bawaan anak (Syakilah TB-40) dan melatih respon lisan saya melalui simulasi skenario interaktif."*
4. **Saat Hadir di Majelis Ilmu (Community & Event):**  
   *"Saya ingin memeriksa jadwal daurah offline, memesan kursi secara tertib syar'i, dan mengakses tiket digital bahkan saat jaringan internet ponsel terputus."*

---

## 3. Pilar Arsitektur & Prinsip Desain (Anti-Slop & Non-Card Framework)

Sesuai dengan dokumen panduan `DESIGN_SKILLS_ANTI_SLOP.md` dan `Panduan Layout Out of the Box: Non-Card Redesign`:

1. **Editorial Terbuka & Action Spine:** Informasi penting disajikan dalam aliran hierarki tipografi dokumen yang terstruktur, bukan tumpukan kartu seragam (*nested card slop*).
2. **Guidance-First, Metadata-Last:** Tindakan lapangan diletakkan di awal, diikuti penjelasan pedagogis dan referensi dalil.
3. **Kejujuran Data & Zero Manipulative UX:** Tidak ada *countdown timer* palsu, tidak ada klaim statistik palsu, tidak ada *streak shaming*. Transparansi alokasi kursi majelis disajikan secara faktual.
4. **Tipografi Berakar Budaya:** 
   * Huruf Latin: **Inter** (bobot terukur, line-height lega untuk mobilitas).
   * Huruf Hijaiyah / Arab: **Amiri** (rendisi khat autentik untuk matan Al-Qur'an dan Hadits).
5. **Palet Warna "Executive Deep Slate":**
   * Surface & Background: `#0A0E13` / `#101419` / `#151D24`
   * Primary Emerald: `#14B8A6` (Koneksi & Thuma'ninah)
   * Aksen Nabawi Gold: `#EAB308` (Mutiara Hikmah & Dalil)
   * Semantic Pilar: 6 warna rumpun fitrah yang bermakna fungsional.

---

## 4. Spesifikasi Modul Inti (Scope & Functional Requirements)

Aplikasi dibangun di atas **5 Modul Inti** yang terhubung secara mulus melalui Flutter Material 3 NavigationBar:

```
[  Beranda  ]   [  Agenda  ]   [  Khazanah  ]   [  Kisah  ]   [  Curhat AI  ]
   (Home)          (Event)         (Wiki)         (Game)       (AI Sanctuary)
```

---

### MODUL 1: BERANDA PKN (Home Dashboard)
*Struktur Desain: Editorial Terbuka (Non-Card Living Flow)*

* **Fungsi Utama:**
  1. **Status Fase Pengasuhan:** Menampilkan fase aktif anak binaan (cth: *Fase Tamyiz 7–10 Thn — Zaid, 8 Thn*).
  2. **Situasi Lapangan Hari Ini:** Refleksi kontekstual harian yang menajamkan kesadaran orang tua.
  3. **SOP 3 Detik: Koneksi Sebelum Koreksi (P3K Lapangan Tindakan Langsung):**
     * *Langkah 1: Dekati Fisik (< 1 Meter)* — hindari instruksi lintas ruangan.
     * *Langkah 2: Rendahkan Sudut Pandang* — duduk sejajar mata anak agar amigdala tidak mendeteksi ancaman dominasi predator.
     * *Langkah 3: Sentuhan Rahmat* — letakkan telapak tangan hangat di pundak kanan anak sebelum memulai instruksi ibadah.
  4. **Pemutar Panduan Audio Terpadu:** Akses cepat ke rekaman intonasi nada bicara rendah pengasuh.
  5. **Jalur Pintas Ekosistem (Akses Cepat):** Tautan langsung ke Event terdekat, Glosarium terpopuler, Lanjutan Simulasi Karakter, dan Muhasabah Mandiri.
  6. **Atsar Nabawiyah Autentik:** Kutipan sunnah fisik tarbiyah (*HR. Riwayat Sirah & Sunan An-Nasa'i*) mengenai keteladanan Rasulullah ﷺ duduk di tanah bersama anak-anak.

---

### MODUL 2: AGENDA EVENT & DAURAH (Event & Ticketing Hub)
*Struktur Desain: Transparansi Majelis & E-Pass Luring*

* **Fungsi Utama:**
  1. **Pencarian & Filter Jadwal:** Filter berdasarkan kategori *Semua Agenda*, *Tatap Muka (Offline)*, dan *Webinar Interaktif*.
  2. **Tiket Terdaftar Aktif (Offline Ready):**
     * Menampilkan daurah terdekat yang telah diikuti pengguna.
     * Alokasi tempat duduk spesifik (cth: *Ikhwan A-14, Lajur Depan Mimbar*).
     * Tombol aksi: `Tampilkan QR E-Pass (Offline)` dan `Rute Lokasi & Rundown Syar'i`.
  3. **Katalog Agenda Pembinaan Mendatang:**
     * Transparansi kuota kursi riil (cth: *Sisa 12 Ikhwan, 6 Akhwat*) tanpa hitung mundur manipulatif.
     * Informasi biaya kontribusi infaq modul, konsumsi, dan ruang ramah anak.
     * Alur pendaftaran bebas biaya / infaq sukarela untuk webinar privasi tinggi.
  4. **Pedoman Adab & Amanah Majelis:** Panduan datang sebelum mukaddimah, membawa buku muhasabah fisik, serta ketersediaan pemisahan ruangan ikhwan/akhwat dan ruang laktasi.

---

### MODUL 3: KHAZANAH WIKI & MOC (Knowledge Base & SOP Krisis)
*Struktur Desain: Indeks Bertingkat (MOC) & Direktori Tipografi Terbuka*

* **Fungsi Utama:**
  1. **Peta Induk Taksonomi (6 Pilar Fitrah Nabawiyah):**
     * *Pilar 01: Fitrah Iman & Rububiyyah* (Mengenal tauhid asasi sejak dini).
     * *Pilar 02: Fitrah Belajar & Nalar* (Syakilah TB-40, adab menuntut ilmu).
     * *Pilar 03: Fitrah Bakat & Kepemimpinan* (Peran khalifah fil ardh).
     * *Pilar 04: Fitrah Perkembangan & Adab* (Tahapan Shobiy, Tamyiz, Murahaqah).
     * *Pilar 05: Fitrah Seksualitas & Gender* (Keteladanan Qawwamun & Ummu Basyar).
     * *Pilar 06: Fitrah Jasmani & Hifzhun Nafs* (Pola thoyyib, ketangguhan fisik).
  2. **Glosarium Istilah Asasi (Terminologi Ruhaniyah & Psikologi Islam):**
     * Definisi baku: *Syakilah (الشَّاكِلَة)*, *Tazkiyatun Nafs*, *Fase Tamyiz*.
  3. **Protokol Cepat Krisis Anak (SOP 3 Menit Baca):**
     * SOP Anak Mogok Belajar & Menolak Nasihat.
     * SOP Tantrum di Ruang Publik (Dekap fisik hifzhun nafs).
     * SOP Menyelesaikan Perselisihan Antar Saudara (*Ishlah Nabawi*).
  4. **Brankas Luring & Ekspor:** Kemampuan menyimpan artikel ke memori lokal HP untuk dibaca tanpa jaringan.

---

### MODUL 4: KISAH & MINIGAME STORYTELLING (Living Rehearsal RPG)
*Struktur Desain: Interactive Dialogue & Multi-Branching Simulation*

* **Fungsi Utama:**
  1. **Simulasi Dinamis Tanpa "Game-Over":**
     * Serial latihan pengasuhan aktif (cth: *Serial 1: Menghadapi Kemarahan Zaid Menjelang Maghrib*).
     * Barometer Resonansi Batin Ayah-Anak (0% Reaktif hingga 100% Hikmah Penuh).
  2. **Telemetri Psikis Anak:**
     * Visualisasi status fisik ananda Zaid (Nafas tercekat, reseptor nalar defensif, kebutuhan jiwa: validasi rasa takut).
     * Konteks waktu sensitif (*10 Menit Menuju Adzan Maghrib*).
  3. **Pilihan Respon Pengasuhan Cabang:**
     * *Pilihan A (Respons Spontan Impulsif):* Prediksi dampak: memicu lonjakan kortisol amigdala, anak menolak shalat secara defensif.
     * *Pilihan B (Sunnah Nabawiyah — Koneksi Sebelum Koreksi):* Prediksi dampak: merangsang hormon oksitosin, melunakkan otot tegang anak, membuka gerbang ketenangan jiwa.
  4. **Umpan Balik Pedagogis & Matan Hadits:**
     * Penjelasan perilaku Rasulullah ﷺ yang senantiasa mensejajarkan raga sebelum menegakkan aturan ibadah (*HR. Muslim No. 2594 tentang Kelembutan*).
  5. **Integrasi Kabinet Muhasabah:** Penyimpanan hikmah sesi simulasi ke brankas refleksi pribadi.

---

### MODUL 5: TEMAN CURHAT AI (Sanctuary & Cermin Jiwa)
*Struktur Desain: Amanah Guard & Barometer Tiga Tingkat Jiwa*

* **Fungsi Utama:**
  1. **Amanah Nabawi Guard (Privasi 100% On-Device / Zero Cloud Leak):**
     * Menjamin keamanan pengakuan dan curahan hati orang tua dari kebocoran data awan publik.
  2. **Barometer Jiwa & Nafs Tiga Tingkat:**
     * *Nafs Ammarah:* Jiwa yang terbawa emosi amarah/ego.
     * *Nafs Lawwamah:* Jiwa yang menyesali kekhilafan dan rindu perbaikan.
     * *Nafs Muthma'innah:* Jiwa yang telah mencapai ketenangan dan thuma'ninah.
  3. **Dialog Konseling Empatik:**
     * Respon AI yang menyapa lembut (*Afwan Ayah/Bunda*), memvalidasi rasa sesak sebagai tanda hidupnya *Nafs Lawwamah*, dan menuntun pernapasan tenang.
  4. **Resep Doa & Penenteram Hati:**
     * Penyajian doa Qur'ani (cth: Doa Nabi Musa *Rabbisyrahli Shadri...* QS. Thaha: 25-26) lengkap dengan tombol salin dan simpan dalil.
  5. **Saran Dialog Lanjutan:** Chip pilihan respon cepat (*Bagaimana merangkul anak yang keras kepala?*, *Latihan nafas thuma'ninah*).

---

## 5. Non-Functional Requirements & Standar Kepatuhan

### 5.1 Kepatuhan Syar'i & Legal (`COMPLIANCE_AND_ARCHITECTURE.md`)
1. **Integritas Teks Agama:** Dilarang keras mengarang atau parafrase ayat Al-Qur'an dan matan hadits. Setiap teks Arab wajib menggunakan khat Amiri dengan harakat lengkap serta nomor riwayat terverifikasi.
2. **Non-Clinical Disclaimer:** Aplikasi ini berfungsi sebagai pendampingan adab dan edukasi karakter, bukan pengganti intervensi medis/psikiatri klinis resmi.
3. **Pemisahan Syar'i Majelis:** Semua modul reservasi daurah wajib menyediakan opsi dan kejelasan alokasi ikhwan & akhwat.

### 5.2 Performa & Arsitektur Teknis
1. **Offline-First Storage:** Seluruh SOP krisis 10 detik, tiket terdaftar, dan artikel tersimpan wajib di-cache secara persisten menggunakan local storage (`SharedPreferences` / `Hive` / `Sqflite`).
2. **Touch Targets & Keterbacaan Mobile:** Standar sentuh minimum 48×48 dp, kontras rasio WCAG 2.2 AAA (minimal 4.5:1 untuk teks biasa, 3:1 untuk teks besar).
3. **State Management:** Riverpod 2.x dengan arsitektur immutable state, dependency injection bersih, dan GoRouter declarative routing.

---

## 6. Roadmap Rilis & Milestone

* **Fase 1 (MVP - Q1):** Baseline 5 Layar Inti Flutter M3 (Beranda, Event, Wiki, Minigame, Curhat AI).
* **Fase 2 (Q2):** Integrasi Runtime Rive State Machine untuk karakter reaktif Zaid dan Timbangan Fisika Mizan Fitrah.
* **Fase 3 (Q3):** Peluncuran modul Brankas Luring penuh (Jurnal Refleksi Pribadi & Folder Tematik).
* **Fase 4 (Q4):** Sinkronisasi offline P2P majelis untuk panitia scanner tiket daurah di lokasi acara.
