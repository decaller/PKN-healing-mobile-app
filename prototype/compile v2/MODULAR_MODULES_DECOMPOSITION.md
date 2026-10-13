# Dekomposisi 12 Modul Terstandar PKN Mobile v2

> **Dokumen Spesifikasi Teknis Komponen Modular & Arsitektur Surface**  
> Menguraikan antarmuka, ragam surface widget, kontrak Riverpod provider, rute GoRouter, dan model data untuk setiap modul berdasarkan naskah autentik **Wiki PKN** (*Tier 1: Active Truth*) dan **Tazkiyatun Nafs Syar'i**.

---

## 1. Fondasi Arsitektur Surface Komponen

Mengikuti prinsip **Dual-Core Calm Technology** dan **Macro Value Chain Manhaj PKN**:
$$\text{Amal (What: Lahiriah)} \leftarrow \text{Ilmu (How: Penalaran)} \leftarrow \text{Iman (Why: Cinta & Tauhid)}$$
$$\text{Jiwa Pendidik (Tazkiyah)} \gg \text{Peran Pendidik} \gg \text{Metode Mendidik} \gg \text{Materi Pendidikan} \gg \text{Implementasi Lembaga}$$

### Ragam Representasi Visual `Home Widget`
Dalam PKN Mobile, `Home Widget` **tidak terpaku pada Bento Card semata**, melainkan mengadopsi 6 pola permukaan visual dinamis sesuai model homescreen yang teruji di prototipe (`v2`, `v4`, `v5`, `compile`):
1. **Horizontal Carousel:** Kartu meluncur horizontal dengan snap physics (*HighlightsCarousel*, *DailyActivityCarousel*, *SerialStoryCarousel*, *BukuPilihanCarousel*).
2. **Bento Grid Card:** Kartu bento modular dengan perbandingan proporsi asimetris (*BentoFeaturesGrid* sebagai agregator fitur).
3. **Collapsible List Section:** Daftar vertikal yang dapat diciutkan/dibentangkan (*Daily Task Collapsible List* dengan indikator progress pill).
4. **Grid 2x2 Action Tiles:** Grid 4 tombol aksi cepat (*Kerjasama Lembaga*, *P3K SOP Tantrum 10 Detik*).
5. **Avatar Strip / Circle Bar:** Deretan lingkaran avatar horizontal (*Tokoh Asatidzah & Lembaga Mitra*).
6. **Top Header & Search Ticker Bar:** Bilah penelusuran FTS5/Vector dengan running text kutipan dalil hari ini dan tombol aksi audio Ruang Qalbu.

---

## 2. Rincian Dekomposisi 12 Modul Terstandar

---

### Modul 1: Event (Agenda & Majelis Akbar)
*Modul paling esensial dan termudah untuk memvalidasi interaksi offline-online pertama.*

- **Peran Manhaj:** Sarana talaqqi ilmu langsung bersama para asatidzah dan penguatan ukhuwah antar-lembaga mitra.
- **Ragam Surface Komponen:**
  1. `EventHomeWidget`: 
     - *Bentuk Visual:* Bento card atau Banner countdown di Beranda ("H-3 Daurah Parenting Nabawiyah") dengan tombol aksi *"Lihat Jadwal"*.
     - *Alternatif:* Item kartu dalam `HighlightsCarousel`.
  2. `EventBottomBarButton`: Tab ke-2 di Bottom Navigation Dock dengan ikon kalender/agenda.
  3. `EventListPage`: Halaman daftar event terkelompok (Akan Datang, Berlangsung, Arsip Selesai), dilengkapi filter kategori (`Semua`, `Daurah`, `Seminar`, `Temu Lembaga`, `Kajian Pasutri`).
  4. `EventDetailPage`: Halaman detail event lengkap dengan banner landscape, pemateri terkait (link ke Modul Tokoh), lokasi/link Zoom aman, waktu pelaksanaan, kapasitas peserta, dan tombol pendaftaran / *"Simpan ke Kalender"*.
  5. `EventProfileBadge`: Badge keikutsertaan / kelulusan daurah yang otomatis muncul di halaman profil User jika pengguna mendaftar atau menyelesaikan acara.
- **Rute GoRouter:** `/events` (List) dan `/events/:id` (Detail).
- **Riverpod Provider:** `eventsListProvider`, `eventDetailProvider(id)`, `userEventBadgesProvider`.
- **Model Data Utama:** `EventItem(id, title, category, speakerId, institutionId, startDateTime, endDateTime, locationType, venueOrUrl, coverImageUrl, isRegistered, badgeCode)`.

---

### Modul 2: Buku (Pustaka Nabawiyah)
*Katalog literatur rujukan dan buku panduan resmi manhaj PKN.*

- **Peran Manhaj:** Memperkenalkan karya tulis asatidzah dan tim litbang PKN untuk rujukan belajar orang tua dan pendidik.
- **Ragam Surface Komponen:**
  1. `BukuHomeWidget`: 
     - *Bentuk Visual:* `Horizontal Carousel` kartu buku pilihan ("Buku Wajib Bulan Ini") di Beranda dengan preview sampul artistik.
  2. `BukuListPage`: Grid/daftar buku dengan filter tema (`Keluarga`, `Adab Anak`, `Tafsir Bakat`, `Manajemen Sekolah`), pencarian judul/penulis, dan penanda format (Cetak / E-book / PDF).
  3. `BukuDetailPage`: Sinopsis lengkap, daftar isi terstruktur, preview kutipan emas, profil penulis terkait, serta tombol pemesanan fisik / akses digital.
- **Rute GoRouter:** `/books` (List) dan `/books/:id` (Detail).
- **Riverpod Provider:** `booksListProvider`, `bookDetailProvider(id)`.
- **Model Data Utama:** `BookItem(id, title, authorId, coverUrl, synopsis, tableOfContents, isbn, publicationYear, pageCount, purchaseUrl, pdfAssetPath)`.

---

### Modul 3: Profil & Rekan (Tokoh Asatidzah & Lembaga Mitra)
*Direktori figur teladan dan institusi yang menerapkan standar PKN.*

- **Peran Manhaj:** Menghubungkan pengguna dengan para perumus manhaj dan institusi pendidikan rujukan.
- **Sub-Entitas Resmi:**
  - **Person (Tokoh Asatidzah):**
    - Ust. Abdul Kholiq (SOTAB / Himmatul Ummah — perumus naskah induk PKN)
    - Ust. Bayu
    - Prof Iman (Pendidikan Lestari)
    - Ummu Khusna
  - **Lembaga (Institusi Karakter):**
    - Sekolah Karakter Imam Syafii (SKIS)
    - Yayasan Himmatul Ummah (HU)
    - Sekolah Orang Tua Hebat (SOTAB)
    - Yayasan Darul Atsar
    - Yayasan Bina Insan Taqwa (YBIT)
    - Yayasan Bina Insan Mustaqbal (YBIM)
- **Ragam Surface Komponen:**
  1. `TokohLembagaHomeWidget`: 
     - *Bentuk Visual:* `Avatar Strip` horizontal di Beranda dengan foto/avatar tokoh pakar dan logo lembaga mitra rujukan.
  2. `TokohLembagaListPage`: Halaman direktori dengan segmented tab switcher `[Tokoh Pakar | Lembaga Mitra]`, pencarian, dan filter jenjang pendidikan/wilayah.
  3. `TokohDetailPage`: Biografi ringkas, peranan manhaj, buku yang ditulis (relasi ke Modul 2), rekaman kajian (relasi ke Modul 6), dan event mendatang (relasi ke Modul 1).
  4. `LembagaDetailPage`: Profil yayasan/sekolah, visi misi fitrah, jenjang binaan (TK/SD/Kuttab/SMP/SMA), alamat & kontak, serta sertifikasi adopsi standar PKN.
- **Rute GoRouter:** `/partners` (List) dan `/partners/person/:id`, `/partners/institution/:id`.
- **Riverpod Provider:** `tokohListProvider`, `lembagaListProvider`, `partnerDetailProvider(id)`.

---

### Modul 4: Kemitraan Lembaga (Kerjasama Institusi)
*Pola diadopsi langsung dari desain kanonikal v2 (`home_screen` & `katalog_instrumen_praktis`).*

- **Peran Manhaj:** Portal layanan kerjasama institusional bagi sekolah, madrasah, pesantren, dan yayasan dakwah yang ingin mengadopsi standar PKN.
- **4 Program Kerjasama Resmi:**
  1. **Konsultasi Online (Keluarga & Sekolah):** Sesi telaah kasus anak/santri dan blueprint karakter privat via daring (60-90 menit).
  2. **Visitasi (Kunjungan Lapangan):** Observasi on-site, audit kultur adab sekolah, dan pemetaan dinamika fitrah santri.
  3. **Coaching (Pendampingan Guru):** Pelatihan intensif asatidzah/guru dalam menguasai Tiga Bahasa Mendidik dan rubrik 19 butir adab.
  4. **Pengadaan Acara (Daurah & Seminar):** Penyelenggaraan seminar akbar bersama pakar PKN di kota/lembaga mitra.
- **Ragam Surface Komponen:**
  1. `KemitraanHomeWidget`: 
     - *Bentuk Visual:* `Grid 2x2 Action Tiles` di Beranda (Konsultasi, Visitasi, Coaching, Daurah) dengan ikon tematik dan label jelas.
  2. `KemitraanListPage`: Katalog komprehensif 4 program dengan spesifikasi teknis, durasi, target peserta, dan output dokumen resmi.
  3. `KemitraanDetailPage`: Detail spesifik satu program kemitraan + formulir pengajuan kerjasama in-app terintegrasi.
- **Rute GoRouter:** `/kemitraan` (List) dan `/kemitraan/:code` (Detail & Form).
- **Riverpod Provider:** `partnershipProgramsProvider`, `partnershipSubmissionNotifier`.

---

### Modul 5: User (Akun & Profil Pengguna)
*Identitas sentral, agregator capaian fitrah, dan personalisasi peran.*

- **Peran Manhaj:** Wadah penyimpanan riwayat perjalanan fitrah diri dan bejana penampil seluruh capaian adab.
- **Ragam Surface Komponen:**
  1. `UserHomeWidget`: 
     - *Bentuk Visual:* `Top Header Greeting` di bagian paling atas Beranda ("Ahlan wa Sahlan, Abu Zaid", avatar fitrah, indikator ketenangan jiwa, tombol toggle mode/tema).
  2. `UserBottomBarButton`: Tab ke-5 di Bottom Navigation Dock dengan ikon profil.
  3. `UserDetailPage`: Halaman profil lengkap yang memuat:
     - Kartu identitas utama & peran keluarga/sekolah (hasil Onboarding).
     - Rak **Event Badges** (koleksi lencana keikutsertaan daurah/acara).
     - **TB-40 User Widget** (Radar chart 4 rumpun bakat dominan).
     - **Relasi User Widget** (Lingkaran keluarga dan sahabat dekat terhubung).
     - **Ceklist User Widget** (Mizan neraca istiqomah amalan sepekan).
     - Pengaturan akun, preferensi tema Earth-Tree, sinkronisasi offline, dan tombol keluar.
- **Rute GoRouter:** `/profile` (Detail) dan `/profile/settings`.
- **Riverpod Provider:** `userProfileNotifierProvider`.

---

### Modul 6: Wiki (Khazanah Ilmu PKN)
*Pusat rujukan intelektual manhaj, dalil shahih, dan perangkat software pembantu.*

- **Peran Manhaj:** Menyediakan perpustakaan artikel terkurasi, bahan ajar, takhrij dalil, serta alat bantu penelaahan.
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
- **Ragam Surface Komponen:**
  1. `WikiHomeWidget`: 
     - *Bentuk Visual:* `SearchTickerBar` (bilah pencarian FTS5/Vector dengan running text kutipan dalil hari ini) + kartu artikel pilihan di `HighlightsCarousel`.
  2. `WikiBottomBarButton`: Tab ke-3 di Bottom Navigation Dock.
  3. `WikiExplorePage`: Halaman penjelajah khazanah dengan segmented switcher `[Penulis & Media | Paradigma & AI | Software Bantuan]`.
  4. `WikiDetailPage`: Layar baca artikel nyaman (font Merriweather & Amiri Arabic, floating audio bar, salin dalil, bookmark offline).
  5. `WikiUserWidget`: Riwayat bacaan & artikel yang dibookmark di halaman Profil User.
- **Rute GoRouter:** `/wiki` (Explore), `/wiki/article/:slug`, `/wiki/tools/:toolCode`.
- **Riverpod Provider:** `wikiDirectoryProvider`, `wikiArticleDetailProvider(slug)`, `wikiSearchNotifierProvider`.

---

### Modul 7: Tafsir Bakat 40 (TB-40)
*Instrumen pemetaan 40 bakat fitrah ciptaan Allah dan dialektika batin.*

> [!NOTE] **Catatan Pra-Implementasi (Ketergantungan Eksternal):**  
> Implementasi teknis Modul 7 mengacu pada basis riset dan repo mandiri **TB-40** (`/home/abuhafi/Project/tb40*`). Sebelum penulisan kode dimulai, **diwajibkan melakukan analisis teknis mendalam terhadap skema dan repositori TB-40 tersebut** guna memastikan konsistensi taksonomi 40 bakat dan formula radar chart.

- **Peran Manhaj:** Membantu orang tua dan pendidik mengenali keunikan syakilah anak tanpa melabeli secara kaku atau mengadu skor komparatif.
- **4 Rumpun Bakat Utama:**
  1. *Al-Qiyadah* (Kepemimpinan & Ketegasan): Misal *Syajaa'ah*, *Himmah*, *Qawiyy*.
  2. *Al-Fashahah* (Komunikasi & Kasih Sayang): Misal *Bayan*, *Rifq*, *Ulfah*.
  3. *Al-Idarah* (Pengelolaan & Keteraturan): Misal *Nidham*, *Amanah*, *Injaz*.
  4. *Al-Fikriyyah* (Analisis & Strategi): Misal *Hikmah*, *Firaasah*, *Tadabbur*.
- **Setiap Bakat Memiliki 2 Sisi Jiwa:**
  - *Sisi Ihsan:* Ketika dibimbing Nafs Muthma'innah.
  - *Sisi Afat:* Ketika jatuh ke over-investment atau dikuasai Nafs Ammarah.
- **Ragam Surface Komponen:**
  1. `Tb40HomeWidget`: 
     - *Bentuk Visual:* Mini spider radar chart preview atau Kartu Bento "Bakat Dominan Anda" di Beranda.
  2. `Tb40ToolPage`: Dashboard asesmen mandiri, visualisasi spider/radar 4 rumpun via `fl_chart`, dan filter bakat dominan.
  3. `Tb40ListPage`: Katalog 40 kartu bakat dengan badge rumpun, nama Arab, dan pencarian.
  4. `Tb40DetailPage`: Ulasan mendalam satu bakat: hakikat penciptaan, dalil Al-Qur'an/Hadits, sisi Ihsan vs Afat, serta peran peradaban (*syakilah*).
  5. `Tb40UserWidget`: Radar chart profil bakat pengguna yang disematkan di Profil User.
- **Rute GoRouter:** `/tb40` (Dashboard & Tools) dan `/tb40/:talentCode` (Detail).
- **Riverpod Provider:** `tb40TalentsListProvider`, `tb40AssessmentNotifierProvider`.

---

### Modul 8: Ceklist Harian (Wirid Amalan Adab & Riyadhotun Nafs)
*Manajemen amalan harian anti-guilt berbasis Tazkiyatun Nafs dan Dawamul 'Amal.*

- **Peran Manhaj:** Membimbing muhasabah harian tanpa memanfaatkan adiksi streak harian, berfokus pada kontinuitas amalan sunnah (*Dawamul 'Amal*, HR. Bukhari 6464).
- **Pembagian Amalan Tazkiyatun Nafs:**
  - **Dimensi Takhalli (Detoksifikasi Hati):**
    - Menahan amarah ego (*kazhmul ghaizh*, QS. Ali 'Imran: 134) saat anak berulah.
    - Menjaga lisan dari celaan, sindiran sarkas, dan keluhan (puasa lisan).
    - Memeriksa kehalalan nafkah dan asupan keluarga dari syubhat.
    - Mengikis riya' pengasuhan dan gengsi sosial.
  - **Dimensi Tahalli (Penghiasan Akhlak):**
    - Shalat berjamaah awal waktu.
    - Qiyamullail / munajat malam (generator spiritualitas pengasuhan, QS. Al-Muzzammil: 1-6).
    - Zikir pagi-petang & istighfar harian minimal 100 kali.
    - Tilawah Al-Qur'an dan tadabbur dalil.
    - Memeluk anak / memberikan hak *Bahasa Hati & Bahasa Lisan santun* tanpa distraksi layar HP.
  - **Kaidah Muhasabah Kapasitas Diri & Realisme Syar'i (Anti-Burnout):**
    - Amalan sunnah disesuaikan dengan kecondongan bakat unik (*muyassarun lima khuliqa lah*).
    - **Pemeriksaan Tangki Cinta Diri:** Jika tangki cinta diri kering karena beban amanah harian, turunkan ekspektasi ke batas minimal (*minimum viable activity*) untuk memberi ruang muhasabah/uzlah sejenak dan mengisi tangki cinta dari Allah Ta'ala (Sang Sumber Tak Terbatas).
    - **Kaidah Bakat:** Kuatkan kelebihan dominan, pelihara kekurangan pada batas fardhu 'ain minimal.
- **Ragam Surface Komponen:**
  1. `CeklistHomeWidget`: 
     - *Bentuk Visual:* `Collapsible List Section` atau `DailyActivityCarousel` di Beranda dengan status progress pill ("3 dari 5 amalan tertunaikan").
  2. `CeklistToolPage`: Halaman manajemen amalan harian terkelompok (*Amanah Diri*, *Amanah Keluarga*, *Target Belajar*, *Ibadah Sunnah*).
  3. `CeklistListPage`: Daftar ceklist aktif dengan tombol centang cepat.
  4. `CeklistReviewModal (Detail)`: Bottom sheet muhasabah non-gamified untuk menilai kualitas batin amalan:
     - **Nafs Muthma'innah:** Amalan ditunaikan dengan keikhlasan, ketenangan, dan kelapangan dada.
     - **Nafs Lawwamah:** Amalan tertunaikan namun diiringi penyesalan atas kekurangan khusyuk atau bisikan ego.
     - **Nafs Ammarah:** Tertunda, lalai, atau dikuasai hawa nafsu (langsung diarahkan ke istighfar dan doa pemulihan).
     - Metrik Adab: **BT** (*Belum Tampak*), **MT** (*Mulai Tampak*), **BK** (*Berkembang*), **MM** (*Membudaya*).
  5. `CeklistUserWidget`: Mizan balance scale / grafik stacked bar istiqomah sepekan di Profil User.
- **Rute GoRouter:** `/daily-tasks` (Tool Page & List).
- **Riverpod Provider:** `dailyTasksNotifierProvider`, `taskReviewNotifierProvider`.

---

### Modul 9: Relasi Keluarga dan Teman Dekat
*Pemantauan ikatan jiwa, dinamika Tangki Cinta, ukhuwah, dan rekomendasi hikmah.*

- **Peran Manhaj:** Mengelola hubungan emosional dan spiritual pengguna terhadap keluarga inti maupun rekan seperjuangan dakwah/sahabat dekat.
- **Cakupan Lingkaran Relasi:**
  1. **Keluarga:** Pasangan, Anak per fase fitrah (*Thufulah, Tamyiz, Murahaqah, Syabab*), Orang Tua / Mertua.
  2. **Teman Dekat:** Sahabat hijrah, rekan kerja/guru seperjuangan, teman belajar santri/murid.
- **Penerapan Tiga Bahasa Mendidik Berdasarkan Fase Usia Anak:**
  1. *Fase Thufulah (0–7 Tahun):* **Bahasa Hati** (tautan batin murni, pelukan hangat, pemenuhan Tangki Cinta penuh tanpa syarat, *Koneksi Sebelum Koreksi*, haram sanksi fisik).
  2. *Fase Tamyiz (7–10 Tahun):* **Bahasa Lisan** (dialog persuasif, kesadaran nalar kausalitas, 6 kaidah bicara Al-Qur'an, pembiasaan shalat 3 tahun tanpa pukulan fisik).
  3. *Fase Murahaqah (10–14 Tahun):* **Bahasa Tangan Terukur** (ketegasan adab *ta'dib*, larangan keras memukul wajah, tidak meremukkan raga/jiwa, pemisahan tempat tidur *madhaji'*).
  4. *Fase Syabab (14–18+ Tahun):* Dialog persahabatan, aqil baligh mukallaf, penjagaan kehormatan (*iffah*), dan penemuan peran peradaban (*syakilah*).
- **Ragam Surface Komponen:**
  1. `RelasiHomeWidget`: 
     - *Bentuk Visual:* `Horizontal Carousel` status cinta keluarga dan teman dekat di Beranda (misal "Ananda Zaid: Penuh Kehangatan", "Sahabat Abu Bakar: Ukhuwah Terjaga").
  2. `RelasiToolPage`: Dashboard neraca qalbiyah, filter periode (Pekan Ini, Bulan Ini, Sepanjang Masa), dan kartu tadabbur asisten batin.
  3. `RelasiListPage`: Daftar profil relasi keluarga dan teman dekat yang terdaftar.
  4. `RelasiDetailPage`: Profil individu: usia fitrah, catatan adab, riwayat dialog hati, dinamika *Tangki Cinta*, dan rekomendasi hikmah esok hari yang bisa disematkan langsung ke Ceklist Harian.
  5. `RelasiUserWidget`: Ringkasan lingkaran relasi keluarga & teman dekat di Profil User.
- **Rute GoRouter:** `/relations` (Dashboard & List) dan `/relations/:id` (Detail).
- **Riverpod Provider:** `relationsNotifierProvider`, `relationDetailProvider(id)`.

---

### Modul 10: Onboarding 4 Langkah (Setup Awal Terpandu + Jalan Pintas TB-40)
*Personalisasi awal tenang, bermartabat, dan tanpa paksaan.*

- **Peran Manhaj:** Mengumpulkan konteks fitrah dasar pengguna sejak hari pertama tanpa paksaan kaku.
- **Alur 4 Langkah Wizard:**
  1. **Langkah 1 — Data Diri:** Nama/Kunyah, panggilan, peran utama (Ayah / Bunda / Guru / Santri / Mandiri), avatar fitrah.
  2. **Langkah 2 — Data Pekerjaan:** Profesi/aktivitas, instansi/sekolah (opsional, bisa memilih dari daftar Modul 3 Lembaga Mitra), zona waktu.
  3. **Langkah 3 — Data Relasi:** Input relasi pertama (keluarga: anak/pasangan, atau sahabat dekat).
  4. **Langkah 4 — Data Ceklist Harian:** Pemilihan 3–5 amanah adab awal yang ingin dibiasakan sesuai peran yang dipilih.
- **Fitur Khusus Onboarding:**
  - **Tombol Akses Langsung TB-40:** Disediakan tombol aksi cepat *"Akses Langsung Tools Tafsir Bakat 40"* di layar onboarding agar pengguna yang hanya ingin menguji asesmen bakat fitrah bisa langsung masuk ke Modul 7 tanpa wajib menuntaskan wizard data diri.
  - Tombol **"Lewati / Nanti Saja"** di setiap langkah untuk pengguna yang ingin langsung melihat Beranda.
  - Data yang diisi otomatis menginisialisasi Modul 5 (User), Modul 8 (Ceklist), dan Modul 9 (Relasi).
  - Dapat diakses dan disunting ulang kapan saja melalui Pengaturan Profil User.
- **Rute GoRouter:** `/onboarding`.
- **Riverpod Provider:** `onboardingWizardNotifierProvider`.

---

### Modul 11: Curhat AI (Teman Curhat Ruang Qalbu)
*Pendampingan batin syar'i berbasis Edge/Offline AI.*

- **Peran Manhaj:** Ruang aman berkeluh kesah saat mengalami kepenatan pengasuhan tanpa takut dihakimi manusia lain, dilengkapi doa penenang jiwa (*zero cloud retention*).
- **Ragam Surface Komponen:**
  1. `CurhatHomeWidget`: 
     - *Bentuk Visual:* Promotional action banner di Beranda ("Hati sedang gundah? Masuki Ruang Qalbu") dengan tombol pemicu satu ketukan.
  2. `CurhatBottomBarButton`: Tab ke-4 di Bottom Navigation Dock dengan ikon dialog hati.
  3. `CurhatToolPage`: Pijakan permulaan (pilihan topik: *Lelah Emosi*, *Bingung Menghadapi Anak*, *Konflik Pasutri*, *Keraguan Jiwa*), tombol Walkie-Talkie Ruang Qalbu (Push-to-Talk) dengan living audio waveform.
  4. `CurhatListPage`: Riwayat sesi dialog batin tersimpan rapi secara lokal (*zero-cloud-retention*).
  5. `CurhatDetailPage`: Layar percakapan interaktif tenang, dilengkapi tombol "Sematkan Doa Ketenangan" dan "Ekspor RPP Adab Keluarga (PDF)".
- **Rute GoRouter:** `/curhat` (Ruang Qalbu & History) dan `/curhat/:sessionId` (Conversation).
- **Riverpod Provider:** `curhatSessionNotifierProvider`, `edgeLlmServiceProvider`.

---

### Modul 12: Cerita Interaktif (Simulasi Rehearsal Adab & Serial Zaid)
*Latihan simulasi pengasuhan berbasis Tazkiyatun Nafs dan dialektika bakat.*

> [!NOTE] **Catatan Pra-Implementasi (Alur Cerita & Kebutuhan Ilustrasi Visual):**  
> Modul 12 membutuhkan **analisis ulang mendalam terhadap alur cerita (branching narrative flow) dan kebutuhan ilustrasi visual (scene art style Earth-Tree)** sebelum implementasi teknis dilakukan, guna memastikan kedalaman nilai manhaj dan konsistensi visual narasi.

- **Peran Manhaj:** Melatih respon spontan orang tua menghadapi krisis nyata (anak tantrum, menolak shalat, benturan ego remaja) menggunakan dialog bercabang dan umpan balik syar'i.
- **Karakteristik Narasi Berbasis Manhaj:**
  - **Respon 3 Derajat Jiwa:** Pilihan dialog mencerminkan *Nafs Muthma'innah* (Mumtaz, adab nabawiyah, koneksi sebelum koreksi), *Nafs Lawwamah* (Wajar/evaluatif), dan *Nafs Ammarah* (Munkar, amarah ego/ghadhab).
  - **Dialektika Batin Bakat TB-40:** Bakat-bakat dalam diri orang tua bersuara di monolog batin (Ketegasan *Al-Qiyadah* vs Kasih Sayang *Al-Fashahah* vs Kebijaksanaan *Al-Fikriyyah*).
  - **Ulasan Takhrij & Pemulihan Hutang Pengasuhan:** Telaah dalil shahih, atsar salaf, dan muhasabah pemulihan luka batin masa lalu orang tua (*debt of parenting recovery*).
- **Ragam Surface Komponen:**
  1. `CeritaHomeWidget`: 
     - *Bentuk Visual:* `MultiSerialStoryCard` (carousel episode aktif Serial Zaid di Beranda dengan penanda progres langkah).
  2. `CeritaToolPage`: Katalog skenario narasi terkelompok berdasarkan fase usia fitrah anak (Thufulah 2-7 th, Tamyiz 7-10 th, Murahaqah 10-14 th, Syabab 14-18 th).
  3. `CeritaListPage`: Daftar bab cerita interaktif dengan status eksplorasi (*Belum Dicoba*, *Sedang Berjalan*, *Selesai Muhasabah*).
  4. `CeritaDetailPage`: Layar interaksi cerita: narasi krisis, pilihan respon dialog, monolog cermin batin TB-40, ulasan hikmah syar'i, dan doa penenang.
- **Rute GoRouter:** `/stories` (Hub Skenario) dan `/stories/:scenarioId` (Play Rehearsal).
- **Riverpod Provider:** `interactiveStoriesProvider`, `storyProgressNotifierProvider`.
