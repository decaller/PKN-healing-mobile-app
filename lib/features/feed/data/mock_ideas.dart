import 'models/idea_card.dart';

class MockIdeasRepository {
  static final List<IdeaCard> ideas = [
    const IdeaCard(
      id: 'idea_koneksi_sebelum_koreksi',
      title: 'Koneksi Sebelum Koreksi: Menuntun Emosi Sebelum Menuntut Logika',
      category: 'Praktik Keluarga',
      pilarMoc: 'P4: Praktik Keluarga',
      targetRole: 'Ibu',
      sourceName: 'Hadits Riwayat Bukhari & Konsep Bahasa Hati PKN',
      readTimeMinutes: 2,
      tags: ['Bahasa Hati', 'Regulasi Emosi', 'Tantrum', 'Thufulah'],
      leadTlDr:
          'Duduk sejajar mata anak, peluk lembut saat reda, dan validasi emosinya sebelum menuntut ketertiban atau memberikan nasehat panjang.',
      comparisons: [
        PknComparison(
          commonPractice: 'Membentak atau mendebat logika anak di puncak amarah/tantrum.',
          pknApproach: 'Hadirkan keheningan yang menenangkan, peluk erat, dan validasi perasaan.',
        ),
        PknComparison(
          commonPractice: 'Mengancam dengan siksa neraka agar anak seketika diam.',
          pknApproach: 'Tanamkan rasa aman dan kasih sayang Allah sang Ar-Rahman.',
        ),
      ],
      syariGuardrails:
          'Dilarang keras memberikan sanksi fisik pada anak balita (usia di bawah 7 tahun). Pengasuhan usia ini berlandaskan kasih sayang dan keteladanan murni.',
      practicalRecipe:
          'Gunakan 3 kalimat penenang: "Bunda ada di sini", "Adik boleh sedih atau marah", "Nanti kalau sudah lega, kita cari jalan keluar bersama ya."',
      actionChecklist: [
        'Duduk sejajar dengan pandangan mata anak',
        'Tahan diri untuk tidak mengeluarkan kata-kata nasehat selama 90 detik pertama',
        'Berikan sentuhan fisik atau pelukan hangat',
      ],
      doaOrMuhasabah:
          'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا\n"Ya Tuhan kami, anugerahkanlah kepada kami pasangan kami dan keturunan kami sebagai penyenang hati."',
      coreThesis:
          'Anak-anak tidak dapat menyerap logika dan pelajaran adab saat otak limbik (pusat emosi) mereka sedang membajak nalar.\n\nKoneksi (*attachment & bonding*) membuka pintu hati anak. Tanpa koneksi, koreksi hanya melahirkan kepatuhan semu yang didorong oleh rasa takut, bukan kesadaran fitrah.',
      realWorldExample:
          'Rasulullah ﷺ membiarkan cucunya Hasan dan Husain menaiki punggung beliau saat sujud, lalu memperpanjang sujudnya agar anak merasa tuntas bermain tanpa merasa dimarahi di hadapan para sahabat.',
    ),
    const IdeaCard(
      id: 'idea_batas_disiplin_shalat',
      title: 'Disiplin Shalat Usia 7 vs 10 Tahun: Batas Toleransi Syar\'i',
      category: 'Fase Tumbuh Kembang',
      pilarMoc: 'P2: Fase Tumbuh Kembang',
      targetRole: 'Ayah',
      sourceName: 'HR. Abu Dawud No. 495 (Shahih)',
      readTimeMinutes: 3,
      tags: ['Tamyiz', 'Murahaqah', 'Shalat', 'Disiplin Syar\'i'],
      leadTlDr:
          'Usia 7–10 tahun adalah masa pembiasaan gembira tanpa hukuman fisik. Sanksi kedisiplinan mendidik hanya diizinkan setelah genap 10 tahun bila membangkang, tanpa memukul wajah dan tanpa melukai.',
      comparisons: [
        PknComparison(
          commonPractice: 'Memukul atau memarahi anak usia 7-9 tahun yang bolong shalat.',
          pknApproach: 'Memberikan ajakan riang, teladan wudhu, dan apresiasi pembiasaan.',
        ),
        PknComparison(
          commonPractice: 'Memukul wajah anak sebagai luapan amarah orang tua.',
          pknApproach: 'Haram memukul wajah. Pukulan mendidik usia 10+ tahun bersifat simbolis dan tidak menyakiti.',
        ),
      ],
      syariGuardrails:
          'Batasan ketat: Tidak boleh memukul wajah, tidak boleh meninggalkan bekas merah/lebam, tidak boleh memukul dalam kondisi murka, dan tidak boleh sebelum usia 10 tahun.',
      practicalRecipe:
          'Terapkan 3 tahun teladan tanpa putus (365 hari x 3 tahun = 1.095 hari pembiasaan shalat bersama sebelum menginjak usia 10 tahun).',
      actionChecklist: [
        'Ajak wudhu bersama dengan keceriaan',
        'Gunakan jam alarm shalat ramah anak di kamar',
        'Rayakan pencapaian shalat 5 waktu sepekan dengan pelukan bangga',
      ],
      doaOrMuhasabah:
          'رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِنْ ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ\n"Ya Tuhanku, jadikanlah aku dan anak cucuku orang-orang yang tetap mendirikan shalat."',
      coreThesis:
          'Hadits Nabi ﷺ: "Perintahkanlah anak-anakmu shalat ketika berusia 7 tahun, dan pukullah mereka (bila membangkang) ketika berusia 10 tahun, serta pisahkanlah tempat tidur mereka."\n\nRentang 3 tahun antara usia 7 ke 10 adalah masa emas pembiasaan psikologis tanpa paksaan kasar.',
      realWorldExample:
          'Seorang ayah yang mengajak anaknya ke masjid sejak usia 7 tahun dengan senyuman dan sapaan hangat kepada jamaah masjid menumbuhkan kerinduan anak pada rumah Allah secara mandiri.',
    ),
    const IdeaCard(
      id: 'idea_dialog_ayah_luqman',
      title: 'Executive 3-Minute Parenting: Menghidupkan Dialog Luqman di Akhir Pekan',
      category: 'Praktik Keluarga',
      pilarMoc: 'P4: Praktik Keluarga',
      targetRole: 'Ayah',
      sourceName: 'QS. Luqman: 13-19 & Manhaj Tarbiyah Nabawiyah',
      readTimeMinutes: 3,
      tags: ['Qawwamun', 'Dialog Ayah', 'Tauhid', 'Adab'],
      leadTlDr:
          'Ayah adalah penegak visi tauhid (*Qawwamun*). Luangkan 15 menit obrolan santai berdua dengan anak di akhir pekan dengan panggilan sayang (*Yaa Bunayya*).',
      comparisons: [
        PknComparison(
          commonPractice: 'Menyerahkan urusan pendidikan adab anak 100% kepada ibu.',
          pknApproach: 'Ayah memimpin visi aqidah dan ketahanan spiritual keluarga.',
        ),
        PknComparison(
          commonPractice: 'Berbicara dengan anak hanya saat memberi uang saku atau memarahi.',
          pknApproach: 'Membangun dialog intim penuh kelembutan (*Yaa Bunayya / Wahai anakku sayang*).',
        ),
      ],
      practicalRecipe:
          'Pilih 1 topik akhir pekan: Mengamati langit (Tauhid), etika berbicara (Adab Lisan), atau bersyukur atas nikmat rezeki sepekan.',
      actionChecklist: [
        'Jadwalkan jalan pagi atau shalat shubuh berdua ke masjid',
        'Panggil anak dengan sebutan kehormatan atau kasih sayang',
        'Dengarkan cita-cita anak tanpa meremehkannya',
      ],
      coreThesis:
          'Di dalam Al-Qur\'an, mayoritas ayat dialog pengasuhan dicontohkan oleh Ayah (Ibrahim, Luqman, Ya\'qub). Kehadiran figur ayah yang hangat melindungi anak dari kerapuhan identitas (*father hunger*).',
      realWorldExample:
          'Luqman memulai nasihatnya bukan dengan ancaman, melainkan dengan larangan syirik berlandaskan keadilan: "Wahai anakku, janganlah mempersekutukan Allah, sesungguhnya syirik adalah kezaliman yang amat besar."',
    ),
    const IdeaCard(
      id: 'idea_tangki_cinta_bunda',
      title: 'Meteran "Tangki Cinta" Harian: 5 Bahasa Cinta Nabawiyah Bunda',
      category: 'Praktik Keluarga',
      pilarMoc: 'P4: Praktik Keluarga',
      targetRole: 'Ibu',
      sourceName: 'Tazkiyatun Nafs Bunda & Sirah Nabawiyah',
      readTimeMinutes: 2,
      tags: ['Tangki Cinta', 'Bonding', 'Bahasa Cinta', 'Self-Care'],
      leadTlDr:
          'Sebelum menuntut kepatuhan anak, pastikan tangki cintanya penuh setiap hari melalui 4 hal: pelukan hangat, mendengar tanpa menyela, tatapan mata tersenyum, dan sentuhan tulus.',
      comparisons: [
        PknComparison(
          commonPractice: 'Menuntut anak rajin belajar saat batinnya merasa terabaikan.',
          pknApproach: 'Penuhi tangki cinta anak terlebih dahulu agar jiwanya tenang dan kooperatif.',
        ),
        PknComparison(
          commonPractice: 'Ibu memendam stres hingga meledak menjadi bentakan pada anak.',
          pknApproach: 'Mengambil jeda muhasabah syar\'i (self-care) untuk memulihkan sakinah batin.',
        ),
      ],
      practicalRecipe:
          'Luangkan 1 menit sebelum tidur malam untuk memeluk anak dan membisikkan: "Bunda bersyukur Allah menitipkan anak shalih/shalihah seperti kamu."',
      actionChecklist: [
        'Minimal 4 pelukan hangat hari ini',
        'Menatap mata anak dengan senyuman tulus saat ia bercerita',
        'Dengarkan celotehnya tanpa memegang gawai/smartphone',
      ],
      coreThesis:
          'Sebagian besar kenakalan anak adalah sinyal SOS karena tangki cintanya kosong. Anak yang merasa dicintai tanpa syarat memiliki imunitas tinggi terhadap perundungan dan pengaruh buruk pergaulan.',
      realWorldExample:
          'Aisyah radhiyallahu \'anha meriwayatkan bahwa Rasulullah ﷺ apabila didatangi putrinya Fathimah, beliau berdiri menyambutnya, memegang tangannya, menciumnya, dan mendudukkannya di tempat duduk beliau.',
    ),
    const IdeaCard(
      id: 'idea_observasi_adab_kualitatif',
      title: 'Observasi Adab Kualitatif: Menghapus Budaya Angka Mati (BT-MT-BK-MM)',
      category: 'Lembaga & Guru',
      pilarMoc: 'P5: Lembaga & Guru',
      targetRole: 'Guru',
      sourceName: 'Standar Evaluasi Karakter Nabawiyah SIT & Kuttab',
      readTimeMinutes: 3,
      tags: ['Observasi KBM', 'BT-MT-BK-MM', 'Fast-Tap', 'Anti-Ranking'],
      leadTlDr:
          'Gantikan nilai angka 0–100 pada adab dengan pelacakan kualitatif 4 tingkat pertumbuhan: BT (Belum Terlihat), MT (Mulai Terlihat), BK (Berkembang Konsisten), dan MM (Membudaya Mandiri).',
      comparisons: [
        PknComparison(
          commonPractice: 'Memberikan ranking rapor adab (Anak A rangking 1, Anak B rangking terakhir).',
          pknApproach: 'Mencatat bukti kualitatif perilaku tanpa membanding-bandingkan santri.',
        ),
        PknComparison(
          commonPractice: 'Menilai adab hanya saat ujian semester secara administratif.',
          pknApproach: 'Observasi cepat harian (Fast-Tap < 15 detik) berbasis pembiasaan nyata.',
        ),
      ],
      practicalRecipe:
          'Fokuskan pada 1-2 indikator adab per pekan (misal: Menjaga Lisan dan Merapikan Sandal) dan beri umpan balik naratif deskriptif.',
      actionChecklist: [
        'Buka lembar Fast-Tap observasi kelas',
        'Pilih indikator adab pekanan',
        'Catat status capaian santri dalam < 10 detik per anak',
      ],
      coreThesis:
          'Karakter dan adab adalah buah dari keimanan, bukan komoditas kompetisi angka. Budaya ranking adab menciptakan kepalsuan (*riya*) pada anak unggul dan keputusasaan (*putus asa*) pada anak yang tertinggal.',
      realWorldExample:
          'Di Kuttab PKN, saat santri mengembalikan pensil temannya yang jatuh tanpa diminta, guru mencatat status MM (Membudaya Mandiri) pada indikator Amanah & Kejujuran.',
    ),
    const IdeaCard(
      id: 'idea_tafsir_bakat_tb40',
      title: 'Tafsir Bakat TB-40: Mengenal Syakilah & Rukun 3A Ciptaan Allah',
      category: 'Fitrah & Bakat',
      pilarMoc: 'P3: Fitrah & Bakat TB-40',
      targetRole: 'Santri',
      sourceName: 'QS. Al-Isra: 84 & Riset Tafsir Bakat 40 Ustadz Abdul Kholiq',
      readTimeMinutes: 3,
      tags: ['TB-40', 'Syakilah', 'Rukun 3A', 'Penjurusan'],
      leadTlDr:
          'Setiap manusia diciptakan dengan syakilah (pola bakat) unik. Temukan titik kontribusi terbaik melalui Rukun 3A: Suka (Raghibah), Bisa (Qudrah), dan Bermanfaat (Naf\'ah).',
      comparisons: [
        PknComparison(
          commonPractice: 'Memaksa seluruh anak menguasai semua bidang dengan standar seragam.',
          pknApproach: 'Mengakui keberagaman fitrah bakat sebagai karunia hikmah dari Allah.',
        ),
        PknComparison(
          commonPractice: 'Menilai bakat hanya dari tes IQ kognitif dan angka matematika.',
          pknApproach: 'Mengevaluasi 4 kluster jiwa: Berpikir, Menggerakkan, Hubungan, dan Pelaksana.',
        ),
      ],
      practicalRecipe:
          'Uji aktivitas anak dengan Rukun 3A: Apakah ia melakukannya dengan gembira (Suka)? Apakah ia menghasilkan karya berkualitas (Bisa)? Apakah orang lain terberkahi (Bermanfaat)?',
      actionChecklist: [
        'Amati aktivitas yang membuat santri lupa waktu karena asyik berkarya',
        'Identifikasi kecenderungan kutub energi (Introvert/As-Sirr vs Ekstrovert/Al-\'Alaniyah)',
        'Arahkan bakat dominan sebagai wasilah dakwah dan kemanfaatan umat',
      ],
      coreThesis:
          'Katakanlah: "Tiap-tiap orang berbuat menurut keadaannya (syakilah-nya) masing-masing." (QS. Al-Isra: 84). Syakilah adalah rancangan fitrah bakat yang Allah titipkan untuk memikul amanah kekhalifahan di muka bumi.',
      realWorldExample:
          'Rasulullah ﷺ menugaskan Khalid bin Walid sebagai panglima perang karena bakat kepemimpinan lapangannya (*Al-Qiyadah*), sementara Abu Dzar dilarang memimpin wilayah karena sifat kelembutannya yang lebih cocok untuk kezuhudan pribadi.',
    ),
    const IdeaCard(
      id: 'idea_recovery_luka_pengasuhan',
      title: '4 Tahap Syar\'i Recovery Luka Pengasuhan Masa Lalu',
      category: 'Mulai di Sini',
      pilarMoc: 'P1: Mulai di Sini',
      targetRole: 'Dewasa',
      sourceName: 'Tazkiyatun Nafs Dewasa & Modul SOTAB Lanjutan',
      readTimeMinutes: 3,
      tags: ['Tazkiyatun Nafs', 'Inner Child', 'Recovery', 'Keluarga'],
      leadTlDr:
          'Sembuhkan luka pengasuhan masa kecil melalui 4 langkah syar\'i: 1. Pengakuan Fakta, 2. Taubat Nasuha, 3. Tahallul (Menghalalkan Hak), dan 4. Pengisian Tangki Cinta.',
      comparisons: [
        PknComparison(
          commonPractice: 'Menyalahkan orang tua terus menerus atas kegagalan emosional diri hari ini.',
          pknApproach: 'Menerima takdir masa lalu, mendoakan orang tua, dan memutus rantai trauma generasi.',
        ),
        PknComparison(
          commonPractice: 'Mengabaikan luka batin hingga tidak sengaja menyakiti anak kandung.',
          pknApproach: 'Menempuh pemulihan batin (*tazkiyah*) agar tidak menularkan luka kepada generasi berikutnya.',
        ),
      ],
      practicalRecipe:
          'Tuliskan unek-unek luka masa lalu di atas kertas, akui kepedihan tersebut di hadapan Allah dalam sujud tahajjud, lalu maafkan orang tua yang telah mendidik dengan keterbatasan mereka.',
      actionChecklist: [
        'Akui emosi luka tanpa rasa malu di hadapan Allah',
        'Lakukan taubat nasuha atas segala amarah batin',
        'Doakan orang tua: Rabbighfirlii waliwaalidayya warhamhuma...',
      ],
      coreThesis:
          'Pengasuhan yang keras di masa lampau sering kali diwariskan secara otomatis (*transgenerational trauma*). Pemulihan sejati terjadi saat seorang hamba menyerahkan penghakimannya kepada Allah dan memilih menjadi pemutus rantai luka.',
      realWorldExample:
          'Seorang ayah yang dulunya sering dipukul ayahnya, memutuskan bersujud memohon kekuatan kepada Allah agar lisannya hanya mengucapkan doa dan tangannya hanya memeluk anak-anaknya.',
    ),
    const IdeaCard(
      id: 'idea_pemisahan_tempat_tidur',
      title: 'Batas Usia 10 Tahun: Pemisahan Tempat Tidur (Madhaji\') & Penjagaan Haya\'',
      category: 'Fase Tumbuh Kembang',
      pilarMoc: 'P2: Fase Tumbuh Kembang',
      targetRole: 'Guru',
      sourceName: 'HR. Abu Dawud & SOP Asrama Murahaqah PKN',
      readTimeMinutes: 2,
      tags: ['Murahaqah', 'Madhaji\'', 'Haya\'', 'Pencegahan'],
      leadTlDr:
          'Saat anak genap berusia 10 tahun, pisahkan tempat tidur antar saudara kandung serta antara santri asrama putra dan putri untuk membentengi fitrah rasa malu (*haya\'*).',
      comparisons: [
        PknComparison(
          commonPractice: 'Membiarkan anak pra-baligh tidur satu selimut dengan saudaranya.',
          pknApproach: 'Memisahkan kasur atau selimut secara tegas sejak usia 10 tahun.',
        ),
        PknComparison(
          commonPractice: 'Menganggap tabu edukasi thaharah pubertas bermartabat.',
          pknApproach: 'Mengajarkan adab isti\'dzan (meminta izin masuk kamar) dan thaharah secara terhormat.',
        ),
      ],
      syariGuardrails:
          'Kewajiban syar\'i sunnah muakkadah: pemisahan tempat tidur (*farriqu bainahum fil madhaji\'*) berlaku tegas di usia 10 tahun.',
      practicalRecipe:
          'Edukasi anak 3 waktu meminta izin masuk kamar orang tua (QS. An-Nur: 58): sebelum shubuh, tengah hari, dan sesudah shalat isya.',
      actionChecklist: [
        'Pastikan anak usia 10 tahun memiliki tempat tidur atau selimut terpisah',
        'Ajarkan mengetuk pintu 3 kali sebelum masuk kamar orang tua',
        'Jelaskan batasan aurat sesama jenis dan lawan jenis',
      ],
      coreThesis:
          'Fitrah seksualitas dan rasa malu (*haya\'*) dijaga melalui keteraturan tata ruang fisik. Perintah pemisahan tempat tidur adalah pagar pencegahan dini dari fitnah moral sejak usia pra-baligh.',
      realWorldExample:
          'Di pesantren binaan PKN, kamar santri kelas 5 SD ke atas dirancang dengan tempat tidur single berkasur mandiri dan sekat privasi yang tertib.',
    ),
  ];
}
