# Dekomposisi 12 Modul Terstandar PKN Mobile v2

> **Dokumen Spesifikasi Teknis Komponen Modular**  
> Menguraikan antarmuka, model data, dan penyebaran surface untuk setiap modul dari yang paling mudah/krusial.

---

## 1. Modul 1: Event (Agenda & Majelis Akbar)
*Modul paling esensial dan termudah untuk memvalidasi interaksi offline-online pertama.*

- **Peran:** Menyajikan informasi daurah, seminar parenting, kajian rutin, dan temu lembaga resmi PKN.
- **Surface Komponen:**
  1. `EventHomeWidget`: Bento card di Beranda yang menampilkan event terdekat ("H-3 Daurah Parenting Nabawiyah") dengan tombol aksi "Lihat Jadwal".
  2. `EventBottomBarButton`: Tab ke-2 di Bottom Navigation Dock dengan ikon kalender/agenda.
  3. `EventListPage`: Halaman daftar event terkelompok (Akan Datang, Berlangsung, Arsip Selesai), dilengkapi filter kategori (`Semua`, `Daurah`, `Seminar`, `Temu Lembaga`, `Kajian Pasutri`).
  4. `EventDetailPage`: Halaman detail event lengkap dengan banner landscape, pemateri terkait (link ke Modul Tokoh), lokasi/link Zoom aman, waktu pelaksanaan, kapasitas peserta, dan tombol pendaftaran / "Simpan ke Kalender".
  5. `EventProfileBadge`: Badge keikutsertaan / kelulusan daurah yang otomatis muncul di halaman profil User jika pengguna mendaftar atau menyelesaikan acara.
- **Model Data Utama:** `EventItem(id, title, category, speakerId, institutionId, startDateTime, endDateTime, locationType, venueOrUrl, coverImageUrl, isRegistered, badgeCode)`.

---

## 2. Modul 2: Buku (Pustaka Nabawiyah)
*Katalog literatur rujukan dan buku panduan resmi manhaj PKN.*

- **Peran:** Memperkenalkan karya tulis asatidzah dan tim litbang PKN untuk rujukan belajar orang tua dan pendidik.
- **Surface Komponen:**
  1. `BukuHomeWidget`: Carousel horizontal kartu buku pilihan ("Buku Wajib Bulan Ini") di Beranda dengan preview sampul artistik.
  2. `BukuListPage`: Grid/daftar buku dengan filter tema (`Keluarga`, `Adab Anak`, `Tafsir Bakat`, `Manajemen Sekolah`), pencarian judul/penulis, dan penanda format (Cetak / E-book / PDF).
  3. `BukuDetailPage`: Sinopsis lengkap, daftar isi terstruktur, preview kutipan emas, profil penulis terkait, serta tombol pemesanan fisik / akses digital.
- **Model Data Utama:** `BookItem(id, title, authorId, coverUrl, synopsis, tableOfContents, isbn, publicationYear, pageCount, purchaseUrl, pdfAssetPath)`.

---

## 3. Modul 3: Profil & Rekan (Tokoh Asatidzah & Lembaga Mitra)
*Direktori figur teladan dan institusi yang menerapkan standar PKN.*

- **Peran:** Menghubungkan pengguna dengan para pengasuh manhaj dan institusi pendidikan rujukan.
- **Sub-Entitas:**
  - **Person (Tokoh Asatidzah):**
    - Ust. Abdul Kholiq
    - Ust. Bayu
    - Prof Iman
    - Ummu Khusna
  - **Lembaga (Institusi Karakter):**
    - Sekolah Karakter Imam Syafii (SKIS)
    - Yayasan Himmatul Ummah (HU)
    - Sekolah Orang Tua Hebat (SOTAB)
    - Yayasan Darul Atsar
    - Yayasan Bina Insan Taqwa (YBIT)
    - Yayasan Bina Insan Mustaqbal (YBIM)
- **Surface Komponen:**
  1. `TokohLembagaHomeWidget`: Avatar strip horizontal di Beranda dengan badge tokoh utama dan lembaga rujukan.
  2. `TokohLembagaListPage`: Halaman direktori dengan segmented tab switcher `[Tokoh Pakar | Lembaga Mitra]`, pencarian, dan filter jenjang pendidikan/wilayah.
  3. `TokohDetailPage`: Biografi ringkas, peranan manhaj, buku yang ditulis (relasi ke Modul 2), rekaman kajian (relasi ke Modul 6), dan event mendatang (relasi ke Modul 1).
  4. `LembagaDetailPage`: Profil yayasan/sekolah, visi misi fitrah, jenjang binaan (TK/SD/Kuttab/SMP/SMA), alamat & kontak, serta sertifikasi adopsi standar PKN.

---

## 4. Modul 4: Kemitraan Lembaga (Kerjasama Institusi)
*Pola diadopsi langsung dari desain kanonikal v2 (`home_screen` & `katalog_instrumen_praktis`).*

- **Peran:** Portal layanan kerjasama institusional bagi sekolah, madrasah, pesantren, dan yayasan dakwah.
- **4 Program Kerjasama Resmi:**
  1. **Konsultasi Online (Keluarga & Sekolah):** Sesi telaah kasus anak/santri dan blueprint karakter privat via daring (60-90 menit).
  2. **Visitasi (Kunjungan Lapangan):** Observasi on-site, audit kultur adab sekolah, dan pemetaan dinamika fitrah santri.
  3. **Coaching (Pendampingan Guru):** Pelatihan intensif asatidzah/guru dalam menguasai Tiga Bahasa Mendidik dan rubrik 19 butir adab.
  4. **Pengadaan Acara (Daurah & Seminar):** Penyelenggaraan seminar akbar bersama pakar PKN di kota/lembaga mitra.
- **Surface Komponen:**
  1. `KemitraanHomeWidget`: Grid 2x2 ikonik di Beranda (Konsultasi, Visitasi, Coaching, Daurah) dengan tombol cepat.
  2. `KemitraanListPage`: Katalog komprehensif 4 program dengan spesifikasi teknis, durasi, target peserta, dan output dokumen resmi.
  3. `KemitraanDetailPage`: Detail spesifik satu program kemitraan + formulir pengajuan kerjasama in-app terintegrasi.

---

## 5. Modul 5: User (Akun & Profil Pengguna)
*Identitas sentral, agregator capaian fitrah, dan personalisasi peran.*

- **Peran:** Menyimpan data diri, riwayat perjalanan fitrah, dan menjadi wadah penampil seluruh widget ringkasan modul lain.
- **Surface Komponen:**
  1. `UserHomeWidget`: Header sambutan di bagian paling atas Beranda ("Ahlan wa Sahlan, Abu Zaid", avatar, indikator ketenangan batin).
  2. `UserBottomBarButton`: Tab ke-5 di Bottom Navigation Dock dengan ikon profil.
  3. `UserDetailPage`: Halaman profil lengkap yang memuat:
     - Kartu identitas utama & peran keluarga/sekolah (hasil Onboarding).
     - Rak **Event Badges** (koleksi lencana keikutsertaan daurah/acara).
     - **TB-40 User Widget** (Radar chart bakat dominan).
     - **Relasi User Widget** (Daftar ringkas anggota keluarga & status cinta).
     - **Ceklist User Widget** (Neraca istiqomah amalan sepekan).
     - Pengaturan akun, preferensi tema, sinkronisasi offline, dan tombol keluar.

---

## 6. Modul 6: Wiki (Khazanah Ilmu PKN)
*Pusat rujukan intelektual manhaj, dalil shahih, dan perangkat software pembantu.*

- **Peran:** Menyediakan perpustakaan artikel terkurasi, bahan ajar, takhrij dalil, serta alat bantu penelaahan.
- **Pembagian Sub-Khazanah:**
  - **6.1 Wiki Penulis (Bahan Ajar & Publikasi):**
    1. *Artikel/Postingan:* Tesis singkat < 10 detik dan ulasan mendalam.
    2. *Rekaman Kajian:* Audio player latar sirah & adab *hands-free*.
    3. *Presentasi:* Slide ringkasan materi siap sebar untuk sosialisasi wali murid.
    4. *Modul Pembelajaran:* Buku panduan kurikulum berjenjang.
    5. *Lembar Kerja (Worksheet):* Instrumen observasi adab murid/anak.
    6. *Case Study:* Analisis studi kasus problematika keluarga & sekolah nyata.
  - **6.2 Wiki AI & Direktori Paradigma:**
    1. *Konten Wiki Terstruktur:*
       - Panduan Berurutan (MOC P1 s.d. P6).
       - Paradigma: Insan, Pendidikan Ideal, Implementasi, Tazkiyatun Nafs.
       - Ensiklopedi Bakat Nabawiyah.
       - Referensi & Perbandingan Kurikulum Konvensional vs Nabawiyah.
    2. *Tips Cepat:* P3K penanganan krisis adab kilat.
    3. *Dzikir & Doa:* Doa penenang hati, doa kelembutan anak, doa istiqomah.
    4. *Software Bantuan (Integrasi Khazanah Digital):*
       - **OpenBayan:** Analisis semantik kosakata Al-Qur'an.
       - **Qaf:** Korpus linguistik Arab dan gramatika nahwu-sharaf.
       - **Quran.org:** Rujukan mushaf dan terjemahan kanonikal.
       - **Tafsirweb.com:** Kompilasi tafsir mu'tabar (Ibnu Katsir, As-Sa'di, Al-Muyassar).
       - **yufid.com:** Mesin pencari fatwa dan artikel ulama ahlus sunnah.
- **Surface Komponen:**
  1. `WikiHomeWidget`: Ticker mutiara dalil hari ini & bilah pencarian FTS5/Vector di Beranda.
  2. `WikiBottomBarButton`: Tab ke-3 di Bottom Navigation Dock.
  3. `WikiExplorePage`: Halaman penjelajah khazanah dengan segmented switcher `[Penulis & Media | Paradigma & AI | Software Bantuan]`.
  4. `WikiDetailPage`: Layar baca artikel nyaman (font Merriweather & Amiri Arabic, floating audio bar, salin dalil, bookmark offline).
  5. `WikiUserWidget`: Riwayat bacaan & artikel yang dibookmark di halaman Profil User.

---

## 7. Modul 7: Tafsir Bakat 40 (TB-40)
*Instrumen pemetaan 40 bakat fitrah ciptaan Allah dan dialektika batin.*

- **Peran:** Membantu orang tua dan pendidik mengenali keunikan syakilah anak tanpa melabeli secara kaku atau mengadu skor komparatif.
- **4 Rumpun Bakat Utama:**
  1. *Al-Qiyadah* (Kepemimpinan & Ketegasan): Misal *Syajaa'ah*, *Himmah*, *Qawiyy*.
  2. *Al-Fashahah* (Komunikasi & Kasih Sayang): Misal *Bayan*, *Rifq*, *Ulfah*.
  3. *Al-Idarah* (Pengelolaan & Keteraturan): Misal *Nidham*, *Amanah*, *Injaz*.
  4. *Al-Fikriyyah* (Analisis & Strategi): Misal *Hikmah*, *Firaasah*, *Tadabbur*.
- **Setiap Bakat Memiliki 2 Sisi Jiwa:**
  - *Sisi Ihsan:* Ketika dibimbing Nafs Muthma'innah.
  - *Sisi Afat:* Ketika jatuh ke over-investment atau dikuasai Nafs Ammarah.
- **Surface Komponen:**
  1. `Tb40HomeWidget`: Kartu "Bakat Pekan Ini" atau radar preview di Beranda.
  2. `Tb40ToolPage`: Dashboard asesmen mandiri, visualisasi spider/radar 4 rumpun via `fl_chart`, dan filter bakat dominan.
  3. `Tb40ListPage`: Katalog 40 kartu bakat dengan badge rumpun, nama Arab, dan pencarian.
  4. `Tb40DetailPage`: Ulasan mendalam satu bakat: hakikat penciptaan, dalil Al-Qur'an/Hadits, sisi Ihsan vs Afat, serta peran peradaban (*syakilah*).
  5. `Tb40UserWidget`: Radar chart profil bakat pengguna yang disematkan di Profil User.

---

## 8. Modul 8: Ceklist Harian (Amanah & Amalan Adab)
*Manajemen amalan harian anti-guilt dengan modal review kualitatif.*

- **Peran:** Membimbing muhasabah harian tanpa memanfaatkan adiksi streak harian.
- **Surface Komponen:**
  1. `CeklistHomeWidget`: Ringkasan amanah hari ini ("3 dari 5 amanah telah ditunaikan") dengan indikator ketenteraman.
  2. `CeklistToolPage`: Halaman manajemen ceklist terkelompok (*Amanah Diri*, *Amanah Keluarga*, *Target Belajar*, *Ibadah Sunnah*).
  3. `CeklistListPage`: Daftar ceklist aktif dengan tombol centang cepat.
  4. `CeklistReviewModal (Detail)`: Bottom sheet muhasabah non-gamified untuk menilai kualitas batin amalan (*Muthma'innah*, *Lawwamah*, *Ammarah*).
  5. `CeklistUserWidget`: Mizan balance scale / grafik stacked bar istiqomah sepekan di Profil User.

---

## 9. Modul 9: Relasi Qalbiyah (Keluarga & Santri)
*Pemantauan ikatan jiwa, dinamika Tangki Cinta, dan rekomendasi hikmah.*

- **Peran:** Mengelola hubungan emosional dan spiritual orang tua terhadap pasangan, anak-anak, maupun santri asuhan.
- **Surface Komponen:**
  1. `RelasiHomeWidget`: Kartu relasi aktif di Beranda yang menampilkan status Tangki Cinta anggota keluarga (misal "Ananda Zaid: Penuh Kehangatan").
  2. `RelasiToolPage`: Dashboard neraca qalbiyah, filter periode (Pekan Ini, Bulan Ini, Sepanjang Masa), dan kartu tadabbur asisten batin.
  3. `RelasiListPage`: Daftar profil relasi keluarga/santri yang terdaftar.
  4. `RelasiDetailPage`: Profil individu anak/santri: usia fitrah (Thufulah/Tamyiz/Murahaqah/Syabab), riwayat dialog hati, catatan adab, dan rekomendasi hikmah esok hari yang bisa disematkan langsung ke Ceklist Harian.
  5. `RelasiUserWidget`: Ringkasan lingkaran keluarga terhubung di Profil User.

---

## 10. Modul 10: Onboarding 4 Langkah (Setup Awal Terpandu)
*Personalisasi awal tenang dan bermartabat.*

- **Peran:** Mengumpulkan data penting agar seluruh modul memiliki konteks relevan sejak hari pertama.
- **Alur 4 Langkah Wizard:**
  1. **Langkah 1 — Data Diri:** Nama/Kunyah, panggilan, peran utama (Ayah / Bunda / Guru / Santri / Mandiri), avatar fitrah.
  2. **Langkah 2 — Data Pekerjaan:** Profesi/aktivitas, instansi/sekolah (opsional, bisa memilih dari daftar Modul 3 Lembaga Mitra), zona waktu.
  3. **Langkah 3 — Data Relasi:** Input relasi pertama (misal: nama anak pertama, tanggal lahir/rentang usia fitrah Thufulah/Tamyiz/Murahaqah/Syabab).
  4. **Langkah 4 — Data Ceklist Harian:** Pemilihan 3–5 amanah adab awal yang ingin dibiasakan sesuai peran yang dipilih.
- **Karakteristik Interaksi:**
  - Terdapat tombol **"Lewati / Nanti Saja"** di setiap langkah untuk pengguna yang ingin langsung melihat Beranda.
  - Data yang diisi otomatis mengisi Modul 5 (User), Modul 8 (Ceklist), dan Modul 9 (Relasi).
  - Dapat diakses dan disunting ulang kapan saja melalui Pengaturan Profil User.

---

## 11. Modul 11: Curhat AI (Teman Curhat Ruang Qalbu)
*Pendampingan batin syar'i berbasis Edge/Offline AI.*

- **Peran:** Ruang aman berkeluh kesah saat mengalami kepenatan pengasuhan tanpa takut dihakimi manusia lain, dilengkapi doa penenang jiwa.
- **Surface Komponen:**
  1. `CurhatHomeWidget`: Banner kontemplatif di Beranda ("Hati sedang gundah? Masuki Ruang Qalbu") dengan tombol pemicu satu ketukan.
  2. `CurhatBottomBarButton`: Tab ke-4 di Bottom Navigation Dock dengan ikon dialog hati.
  3. `CurhatToolPage`: Pijakan permulaan (pilihan topik: *Lelah Emosi*, *Bingung Menghadapi Anak*, *Konflik Pasutri*, *Keraguan Jiwa*), tombol Walkie-Talkie Ruang Qalbu (Push-to-Talk) dengan living audio waveform.
  4. `CurhatListPage`: Riwayat sesi dialog batin tersimpan rapi secara lokal (*zero-cloud-retention*).
  5. `CurhatDetailPage`: Layar percakapan interaktif tenang, dilengkapi tombol "Sematkan Doa Ketenangan" dan "Ekspor RPP Adab Keluarga (PDF)".

---

## 12. Modul 12: Cerita Interaktif (Simulasi Narasi Adab & Serial Zaid)
*Latihan simulasi pengasuhan tanpa risiko nyata.*

- **Peran:** Melatih respon spontan orang tua menghadapi krisis nyata (anak tantrum, menolak shalat, membangkang) menggunakan dialog bercabang dan umpan balik syar'i.
- **Surface Komponen:**
  1. `CeritaHomeWidget`: Kartu episode aktif Serial Zaid di Beranda dengan penanda progres langkah.
  2. `CeritaToolPage`: Katalog skenario narasi terkelompok berdasarkan fase usia anak (Fase 2-7 th, 7-10 th, 10-14 th, 14-18 th).
  3. `CeritaListPage`: Daftar bab cerita interaktif dengan status eksplorasi (*Belum Dicoba*, *Sedang Berjalan*, *Selesai Muhasabah*).
  4. `CeritaDetailPage`: Layar interaksi cerita:
     - Narasi situasi krisis.
     - Pilihan respon dialog orang tua berjenjang (*Mumtaz* adab nabawiyah, *Hasan* wajar, *Munkar* bentakan/amarah).
     - Monolog cermin batin bakat TB-40 yang bersuara memberikan pertimbangan.
     - Ulasan hikmah syar'i setelah pilihan diambil.
