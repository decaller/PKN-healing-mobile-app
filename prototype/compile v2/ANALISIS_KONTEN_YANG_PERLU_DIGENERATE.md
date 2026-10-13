# Analisis Kesenjangan Konten: Data & Aset yang Perlu Di-Generate (PKN Mobile v2)

> **Dokumen Audit Kesiapan Data & Rencana Produksi Konten**  
> Mengidentifikasi konten yang **sudah tersedia** di [`wiki-pkn`](file:///home/abuhafi/Project/wiki-pkn) vs konten yang **belum ada dan wajib di-generate** untuk mendukung 12 modul di [`/home/abuhafi/Project/pkn-mobile`](file:///home/abuhafi/Project/pkn-mobile).

---

## 1. Ikhtisar Hasil Audit Kesiapan Konten

Repositori [`wiki-pkn`](file:///home/abuhafi/Project/wiki-pkn) memiliki kekayaan luar biasa pada **artikel paradigma naratif, naskah manhaj induk (Tier 1), takhrij dalil Al-Qur'an & Hadits, serta transkrip kajian video**. 

Namun, untuk kebutuhan aplikasi mobile interaktif (*calm-tech, offline-first, micro-learning, dan simulasi living rehearsal*), terdapat kesenjangan (*gap*) berupa **ketiadaan data operasional terstruktur (JSON/database), metadata katalog, instrumen asesmen lengkap, naskah skenario dialog bercabang, serta aset audio/visual terkurasi**.

```
┌────────────────────────────────────────────────────────────────────────┐
│                   STATUS KESIAPAN KONTEN LINTAS 12 MODUL               │
├─────────────────┬────────────────────────────────┬─────────────────────┤
│ KATEGORI STATUS │ ARTI STATUS                    │ MODUL TERKAIT       │
├─────────────────┼────────────────────────────────┼─────────────────────┤
│ 🟢 SIAP PAKAI   │ Konten lengkap di wiki-pkn     │ Sebagian Modul 6    │
│                 │ (perlu formatting JSON ringan) │ (Paradigma & Dalil) │
├─────────────────┼────────────────────────────────┼─────────────────────┤
│ 🟡 PERLU        │ Konsep dasar ada di wiki-pkn,  │ Modul 2 (Buku),     │
│    PENGAYAAN    │ namun belum berformat operasional│ Modul 3 (Tokoh/Lbg),│
│                 │ & butuh struktur komprehensif  │ Modul 7 (TB-40),    │
│                 │                                │ Modul 8 (Ceklist),  │
│                 │                                │ Modul 9 (Relasi)    │
├─────────────────┼────────────────────────────────┼─────────────────────┤
│ 🔴 WAJIB        │ Belum ada sama sekali di       │ Modul 1 (Event DB), │
│    GENERATE     │ wiki-pkn; wajib dirumuskan     │ Modul 4 (Kemitraan),│
│    BARU         │ dari nol sesuai kaidah manhaj  │ Modul 10 (Onboard), │
│                 │                                │ Modul 11 (Prompt AI)│
│                 │                                │ Modul 12 (Graf RPG) │
└─────────────────┴────────────────────────────────┴─────────────────────┘
```

---

## 2. Matriks Rinci Analisis Kesenjangan Konten (Gap Analysis)

Berikut adalah audit terperinci untuk setiap modul dari urutan 1 sampai 12:

---

### Modul 1: Event (Agenda & Majelis Akbar)
- **Status di `wiki-pkn`:** 🔴 Belum Ada (Hanya ada arsip rekaman video masa lalu di `Kajian Video/`).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `events.json`: Dataset 10–15 agenda daurah, seminar parenting, dan temu lembaga terstruktur:
     - Judul acara, kategori (`Daurah`, `Seminar`, `Temu Lembaga`, `Kajian Pasutri`).
     - Jadwal presisi (tanggal, jam mulai, jam selesai, zona waktu).
     - Format acara (`Daring Zoom`, `Luring Masjid/Sekolah`, `Hybrid`).
     - Pemateri (relasi ke Modul 3: Tokoh) & Penyelenggara (relasi: Lembaga).
     - Informasi kuota, tautan pendaftaran aman, dan rincian silabus.
  2. `event_badges.json`: Sistem 5–10 lencana resmi keikutsertaan/kelulusan daurah:
     - Kode badge, nama lencana, ikon SVG bernuansa Earth-Tree, deskripsi kompetensi fitrah.
  3. `event_banners/`: Aset visual banner landscape 16:9 siap pakai untuk carousel Beranda dan halaman detail.

---

### Modul 2: Buku (Pustaka Nabawiyah)
- **Status di `wiki-pkn`:** 🟡 Perlu Pengayaan (Hanya ada ulasan/review buku di `Referensi/Review Buku...`).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `books_catalog.json`: Katalog 8–12 buku resmi karya asatidzah PKN:
     - Judul lengkap, penulis, ISBN, tahun terbit, tebal halaman, kategori tema.
     - **Sinopsis Memikat (< 100 kata):** Penjelasan masalah yang diselesaikan buku tersebut.
     - **Daftar Isi Terstruktur:** Array bab dan sub-bab untuk navigasi in-app.
     - **Golden Quotes (Kutipan Emas):** 3–5 kutipan paling menggugah per buku.
     - Tautan pemesanan cetak resmi & path aset file digital/PDF preview.
  2. `book_covers/`: Aset grafis sampul buku proporsional 2:3 beresolusi tajam.

---

### Modul 3: Profil & Rekan (Tokoh Asatidzah & Lembaga Mitra)
- **Status di `wiki-pkn`:** 🟡 Perlu Pengayaan (Disebutkan secara sporadis di atsar/catatan, belum ada profil direktori terstruktur).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `persons_directory.json`: Profil terstruktur 4 Tokoh Asatidzah Utama:
     - **Ust. Abdul Kholiq:** Perumus Naskah Induk Manhaj PKN, SOTAB Hebat, Yayasan Himmatul Ummah.
     - **Ust. Bayu:** Pakar Fiqih Pengasuhan & Karakter Remaja Murahaqah.
     - **Prof. Iman Harymawan:** Guru Besar, Penggagas Pendidikan Lestari & Standar Akreditasi PKN.
     - **Ummu Khusna:** Konselor Fitrah Ibu & Pemulihan Luka Batin Pengasuhan Balita.
     - *Data Wajib:* Biografi ringkas, peran manhaj, karya tulis (link Modul 2), rekaman kajian (link Modul 6), event mendatang (link Modul 1), foto avatar resmi.
  2. `institutions_directory.json`: Profil terstruktur 6 Lembaga Mitra Resmi:
     - Sekolah Karakter Imam Syafii (SKIS)
     - Yayasan Himmatul Ummah (HU)
     - Sekolah Orang Tua Hebat (SOTAB)
     - Yayasan Darul Atsar
     - Yayasan Bina Insan Taqwa (YBIT)
     - Yayasan Bina Insan Mustaqbal (YBIM)
     - *Data Wajib:* Jenjang binaan (TK/Kuttab/SD/SMP/SMA), visi-misi fitrah, kota/alamat, narahubung resmi, logo vektor/PNG resmi, status adopsi standar PKN.

---

### Modul 4: Kemitraan Lembaga (Kerjasama Institusional)
- **Status di `wiki-pkn`:** 🔴 Wajib Generate Baru (Ada 8 Standar Implementasi, tetapi belum ada naskah paket program layanan kemitraan).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `partnership_programs.json`: Spesifikasi naskah 4 Layanan Kemitraan:
     - **Konsultasi Online (Keluarga & Sekolah):** Durasi 60–90 menit, kurikulum telaah kasus privat, output rekomendasi tertulis.
     - **Visitasi (Kunjungan Lapangan):** Audit kultur adab lingkungan, pemetaan dinamika santri, pendampingan kepala madrasah.
     - **Coaching (Pendampingan Guru):** Modul pelatihan Tiga Bahasa Mendidik dan rubrik 19 butir adab.
     - **Pengadaan Acara (Daurah & Seminar):** Paket penyelenggaraan seminar parenting akbar bersama pakar PKN.
  2. `partnership_form_schema.json`: Skema formulir pengajuan in-app (nama institusi, jenis lembaga, kontak penanggung jawab, program yang diminati, uraian kendala karakter santri).

---

### Modul 5: User (Akun & Profil Pengguna)
- **Status di `wiki-pkn`:** 🟡 Perlu Pengayaan (Ada 17 Persona di `docs/personas/`, namun belum ada konfigurasi profil pengguna aplikasi).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `user_roles_config.json`: Konfigurasi 5 Arketipe Peran Pengguna:
     - *Ayah* (Fokus: Kepemimpinan, Qiyadah, Ketegasan Syar'i, Dialog Remaja).
     - *Bunda* (Fokus: Kelembutan, Rifq, Penanganan Tantrum, Bahasa Hati).
     - *Guru / Asatidzah* (Fokus: KBM Beradab, Rubrik 19 Butir, Manajemen Kelas).
     - *Santri / Pelajar* (Fokus: Asesmen Bakat Syakilah, Adab Menuntut Ilmu).
     - *Mandiri / Umum* (Fokus: Tazkiyatun Nafs, Pemulihan Batin).
  2. `default_guest_profile.json`: Mock data profil tamu untuk pengguna yang melewati onboarding.

---

### Modul 6: Wiki (Khazanah Ilmu PKN)
- **Status di `wiki-pkn`:** 🟢 70% Siap Pakai di ranah teks naratif, 🔴 30% Belum Ada di ranah media & AI.
- **Yang Belum Ada & Wajib Di-Generate:**
  1. **Wiki Penulis (Bahan Ajar & Media):**
     - `article_tldr_snippets.json`: Ekstraksi ringkasan tesis < 10 detik untuk seluruh 80+ artikel utama di wiki-pkn.
     - `audio_streams_manifest.json`: Audio MP3 sirah & adab terpotong per tema (< 15 menit) siap putar latar.
     - `presentation_slides_json/`: Konversi ringkasan materi presentasi menjadi format deck slide JSON/SVG ringan siap saji.
     - `worksheets_interactive.json`: Formulir lembar kerja observasi anak berbasis web/flutter (misal: *Formulir Desain Proyek Pembelajaran Alamiah*).
  2. **Wiki AI & Software Bantuan:**
     - `software_bantuan_directory.json`: Direktori integrasi dan kurasi link deep-search untuk **OpenBayan**, **Qaf**, **Quran.org**, **Tafsirweb.com**, dan **yufid.com**.
     - `bank_dzikir_doa_penenang.json`: Kompilasi 25 doa nabawiyah pelindung jiwa, doa kelembutan anak, doa penahan amarah, dan doa istiqomah lengkap dengan teks Arab, transliterasi Latin, terjemahan, takhrij sanad shahih, dan panduan situasi pengamalan.

---

### Modul 7: Tafsir Bakat 40 (TB-40)
- **Status di `wiki-pkn`:** 🔴 Sebagian Besar Belum Ada (Di wiki-pkn hanya ada pengantar umum bakat; katalog 40 bakat belum terurai satu per satu!).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `tb40_master_talents.json`: Katalog Lengkap 40 Bakat Fitrah Nabawiyah:
     - **Identitas Bakat:** Kode unik, Nama Arab asli, Nama Latin, dan Kluster Rumpun (*Al-Qiyadah*, *Al-Fashahah*, *Al-Idarah*, *Al-Fikriyyah*).
     - **Hakikat Fitrah:** Penjelasan filosofis mengapa bakat tersebut diciptakan Allah.
     - **Sisi Ihsan (Nafs Muthma'innah):** Manifestasi mulia bakat saat dibimbing keimanan.
     - **Sisi Afat / Over-Investment (Nafs Ammarah):** Jebakan bahaya saat bakat dikuasai ego (misal: *Syajaa'ah* berubah menjadi *Ghadhab*, *Firaasah* berubah menjadi *Su'uzhan*, *Himmah* berubah menjadi *Riya'* menuntut kesempurnaan).
     - **Dalil Al-Qur'an & Sunnah:** Ayat atau hadits yang mendasari bakat tersebut.
     - **Peran Peradaban (*Syakilah*):** Karier dan kontribusi nyata yang cocok di usia mukallaf.
  2. `tb40_assessment_questions.json`: 40–80 butir instrumen pertanyaan situasional untuk asesmen mandiri di Tool Page.

---

### Modul 8: Ceklist Harian (Wirid Amalan Adab & Tazkiyatun Nafs)
- **Status di `wiki-pkn`:** 🟡 Perlu Pengayaan (Ada teori Tazkiyah dan 19 butir adab KBM, namun belum ada bank amalan harian terstruktur untuk aplikasi).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `daily_adab_tasks_bank.json`: Bank 30 amalan harian terkelompok:
     - **10 Amalan Takhalli (Detoksifikasi Hati):**
       - Menahan amarah ego (*kazhmul ghaizh*, QS. Ali 'Imran: 134) saat anak berulah.
       - Puasa lisan dari mencaci, membentak, atau menyindir anak.
       - Memeriksa kehalalan nafkah dan asupan keluarga dari syubhat.
       - Mengikis riya' pengasuhan dan pencitraan di media sosial.
       - Meminta maaf kepada pasangan dan anak atas kekasaran sikap.
     - **15 Amalan Tahalli (Penghiasan Akhlak):**
       - Shalat berjamaah 5 waktu awal waktu.
       - Qiyamullail / munajat tahajjud malam (QS. Al-Muzzammil: 1–6).
       - Istighfar minimal 100 kali sehari dan zikir pagi-petang.
       - Dekapan hangat anak selama 3 menit tanpa memegang gadget (*Bahasa Tubuh*).
       - Kontak mata teduh dan senyum tulus (*Bahasa Mata*).
       - Tilawah 1 maqra' dan tadabbur ayat adab keluarga.
  2. `task_review_rubrics.json`: Panduan kualitatif evaluasi 3 derajat jiwa (*Muthma'innah*, *Lawwamah*, *Ammarah*) serta rubrik **BT, MT, BK, MM** untuk setiap amalan.

---

### Modul 9: Relasi Keluarga dan Teman Dekat
- **Status di `wiki-pkn`:** 🟡 Perlu Pengayaan (Ada konsep Tangki Cinta dan Fase Usia, namun belum ada instrumen metrik relasi digital).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `love_tank_metrics.json`: Parameter kuadran skor Tangki Cinta:
     - Level 0–25% (Kering Kritis: Indikator sering mengamuk/menutup diri, rekomendasi P3K dekap hangat).
     - Level 26–50% (Haus Perhatian: Indikator merengek/mencari perhatian negatif).
     - Level 51–75% (Stabil: Cukup terisi, siap menerima bimbingan adab).
     - Level 76–100% (Penuh Kehangatan: Resonansi cinta optimal, adab membudaya mandiri).
  2. `dialogue_cards_by_phase.json`: Kartu panduan dialog hati per fase fitrah:
     - *Thufulah (2–7 th):* Dongeng sirah sebelum tidur, pelukan rasa aman.
     - *Tamyiz (7–10 th):* Dialog logika shalat, validasi perasaan lelah.
     - *Murahaqah (10–14 th):* Musyawarah ayah-anak, pemisahan kamar tidur, penjagaan malu (*haya'*).
     - *Syabab (14–18+ th):* Diskusi visi hidup, penjagaan pergaulan, penemuan bakat syakilah.
     - *Teman Dekat / Sahabat Dakwah:* Kaidah ukhuwah fillah, saling mendoakan dalam kesendirian, menjaga aib.

---

### Modul 10: Onboarding 4 Langkah
- **Status di `wiki-pkn`:** 🔴 Wajib Generate Baru.
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `onboarding_copywriting.json`: Teks antarmuka ramah dan tenang untuk 4 langkah wizard:
     - Judul langkah, pertanyaan pemantik batin, pilihan opsi peran, opsi instansi, dan teks tombol pintas TB-40.
  2. `onboarding_presets.json`: Paket template ceklist & relasi awal yang otomatis terpasang saat memilih peran tertentu (misal: peran Ayah otomatis mendapat rekomendasi relasi anak tamyiz dan ceklist qiyamullail).

---

### Modul 11: Curhat AI (Ruang Qalbu)
- **Status di `wiki-pkn`:** 🔴 Wajib Generate Baru (Belum ada prompt AI dan aturan sistem dialog).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `system_prompt_ruang_qalbu.md`: System prompt kanonikal untuk asisten AI:
     - Prinsip empati syar'i: memvalidasi emosi sebelum memberikan nasihat (*connection before correction*).
     - Gaya bahasa: Tenang, hangat, beradab, menggunakan salam nabawiyah, tanpa nada menghakimi (*anti-guilt*).
     - **Safeguarding Boundaries:** Batas tegas non-klinis (jika pengguna mengindikasikan kecenderungan menyakiti diri sendiri, depresi berat, atau kekerasan fisik anak, sistem wajib menampilkan rujukan psikolog muslim profesional dan hotline bantuan darurat).
  2. `starter_topics.json`: 12 topik pemantik dialog batin (*Lelah Emosi Seharian*, *Bingung Menghadapi Anak Mogok Belajar*, *Merasa Gagal Menjadi Orang Tua*, *Konflik Pola Asuh Pasutri*).
  3. `rpp_adab_template.json`: Template struktur dokumen *Rencana Pembiasaan Perilaku (RPP) Adab Keluarga* format PDF A4.

---

### Modul 12: Cerita Interaktif (Serial Zaid Rehearsal)
- **Status di `wiki-pkn`:** 🔴 Wajib Generate Baru (Di `Bank Studi Kasus.md` hanya ada uraian teks pasif 2 paragraf).
- **Yang Belum Ada & Wajib Di-Generate:**
  1. `scenarios_graph_episodes.json`: Naskah pohon keputusan graf dialog bercabang untuk 5 episode Serial Zaid:
     - **Ep 1 (Thufulah 3 Th):** *"Tantrum di Minimarket Karena Tidak Dibelikan Mainan"*.
     - **Ep 2 (Thufulah 6 Th):** *"Berebut Balok Kayu dan Memukul Adik"*.
     - **Ep 3 (Tamyiz 8 Th):** *"Menolak Berwudhu Saat Asyik Merakit Istana"*.
     - **Ep 4 (Murahaqah 11 Th):** *"Membangkang dan Membanting Pintu Kamar Saat Dinasihati"*.
     - **Ep 5 (Syabab 15 Th):** *"Kecanduan Layar Gadget dan Kehilangan Semangat Belajar"*.
  2. **Setiap Node Skenario Wajib Memiliki:**
     - Teks situasi krisis.
     - **Kotak Monolog Cermin Batin TB-40:** Suara bakat ketegasan vs kelembutan vs hikmah di kepala orang tua.
     - **3 Opsi Respon Orang Tua:**
       - *Opsi Mumtaz (Nafs Muthma'innah):* Adab nabawiyah, Tiga Bahasa Mendidik, menyentuh batin anak.
       - *Opsi Hasan (Nafs Lawwamah):* Respon wajar manusiawi namun terburu-buru.
       - *Opsi Munkar (Nafs Ammarah):* Melampiaskan amarah ego, bentakan, atau ancaman neraka.
     - Cabang konsekuensi perilaku anak terhadap masing-masing pilihan.
     - Ulasan hikmah syar'i, atsar salaf, muhasabah hutang pengasuhan, dan doa penenang.

---

## 3. Rencana Aksi Pembuatan Konten (Content Generation Action Plan)

Berdasarkan prioritas roadmap 4 Fase di `PHASED_IMPLEMENTATION_ROADMAP.md`, pembuatan konten dibagi ke dalam 4 gelombang kerja (*batches*):

```
┌────────────────────────────────────────────────────────────────────────┐
│             URUTAN KERJA GENERASI KONTEN (4 GELOMBANG)                 │
├───────────────┬────────────────────────────────────────────────────────┤
│ GELOMBANG 1   │ 1. events.json & event_badges.json                     │
│ (Fase 1 App)  │ 2. books_catalog.json (8 buku)                         │
│               │ 3. persons_directory.json (4 asatidzah)                │
│               │ 4. institutions_directory.json (6 lembaga)             │
│               │ 5. partnership_programs.json (4 layanan kemitraan)     │
├───────────────┼────────────────────────────────────────────────────────┤
│ GELOMBANG 2   │ 6. user_roles_config.json & default_guest_profile.json │
│ (Fase 2 App)  │ 7. article_tldr_snippets.json & audio_manifest.json    │
│               │ 8. software_bantuan_directory.json                     │
│               │ 9. bank_dzikir_doa_penenang.json (25 doa)              │
├───────────────┼────────────────────────────────────────────────────────┤
│ GELOMBANG 3   │ 10. tb40_master_talents.json (40 bakat lengkap)        │
│ (Fase 3 App)  │ 11. tb40_assessment_questions.json                     │
│               │ 12. daily_adab_tasks_bank.json (Takhalli & Tahalli)    │
│               │ 13. task_review_rubrics.json (BT-MT-BK-MM)             │
│               │ 14. love_tank_metrics.json & dialogue_cards.json       │
│               │ 15. onboarding_copywriting.json & presets.json         │
├───────────────┼────────────────────────────────────────────────────────┤
│ GELOMBANG 4   │ 16. system_prompt_ruang_qalbu.md & starter_topics.json │
│ (Fase 4 App)  │ 17. rpp_adab_template.json                             │
│               │ 18. scenarios_graph_episodes.json (5 episode Zaid)     │
└───────────────┴────────────────────────────────────────────────────────┘
```

---

## 4. Format & Lokasi Penyimpanan Data Hasil Generasi

Semua berkas hasil generasi konten akan disimpan dengan struktur terstandar yang siap dibaca oleh aplikasi Flutter maupun dikompilasi oleh backend:
1. **Untuk Klien Flutter (`pkn-mobile`):**
   Disimpan di `/home/abuhafi/Project/pkn-mobile/assets/data/` (JSON) dan SQLite assets.
2. **Untuk Backend v2 (`prototype/backend v2`):**
   Disimpan di koleksi Directus CMS dan dikompilasi ke dalam `knowledge_v4.db` melalui skrip `build_knowledge_db.py`.
