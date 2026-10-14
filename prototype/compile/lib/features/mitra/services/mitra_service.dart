import '../data/models/mitra_models.dart';

class MitraService {
  List<TokohItem> getTokohList() => _canonicalTokoh;
  List<LembagaItem> getLembagaList() => _canonicalLembaga;
  List<KemitraanServiceItem> getKemitraanServices() => _canonicalServices;

  TokohItem? getTokohById(String id) {
    try {
      return _canonicalTokoh.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  LembagaItem? getLembagaById(String id) {
    try {
      return _canonicalLembaga.firstWhere((l) => l.id == id);
    } catch (_) {
      return null;
    }
  }

  static const List<TokohItem> _canonicalTokoh = [
    TokohItem(
      id: 'abdul-kholiq',
      name: 'Ust. Abdul Kholiq, Lc., M.P.I.',
      title: 'Dewan Pembina PKN & Pengasuh SKIS',
      focus: 'Manhaj Tarbiyah Nabawiyah, Fitrah Iman, & Pendidikan Kuttab',
      works: 'Buku "Tiga Bahasa Mendidik (Hati, Lisan, Tangan Terukur)", Pengasuh 12 Pesantren & Kuttab',
      goldenQuote: '“Koneksi sebelum koreksi. Penuhi bejana cinta anak sebelum menegakkan aturan ibadah.”',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
      audioSeries: 'Daurah Fitrah Iman & Adab Batin (8 Sesi Audio Eksklusif)',
      expertiseTags: ['Tarbiyah Nabawiyah', 'Fitrah Iman', 'Kuttab', 'Koneksi Qalbu'],
    ),
    TokohItem(
      id: 'bayu',
      name: 'Ust. Bayu Chandra, S.Pd., M.Ed.',
      title: 'Kepala Litbang SOTAB & Kurikulum Karakter',
      focus: 'Living Rehearsal KBM, 19 Indikator Observasi Adab, Simulasi Kasus Nyata',
      works: 'RPP Adab 1 Lembar, Modul Living Rehearsal Zaid, Bank Prompt AI Guru Karakter',
      goldenQuote: '“Adab tidak diajarkan dengan hafalan teks kaku, melainkan dilatihkan lewat dialektika respon batin.”',
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
      audioSeries: 'Workshop KBM Berbasis Syakilah & Observasi Spontan (6 Sesi)',
      expertiseTags: ['Living Rehearsal', 'Kurikulum Adab', 'Fase Tamyiz', 'Observasi 19 Butir'],
    ),
    TokohItem(
      id: 'iman-santoso',
      name: 'Prof. Dr. Iman Santoso, M.Pd.',
      title: 'Ketua Dewan Pakar Kurikulum Karakter & Dosen Tarbiyah',
      focus: 'Integrasi Kurikulum Nasional, Asesmen Autentik Adab, & Standarisasi Lembaga Islam',
      works: 'Framework Penilaian Portofolio Adab, 14 Jurnal Internasional Tarbiyah Islamiyah',
      goldenQuote: '“Asesmen karakter yang sejati bukanlah deretan angka rapor, melainkan kematangan respon saat diuji.”',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80',
      audioSeries: 'Kuliah Pakar: Standarisasi Mutu Sekolah Berbasis Adab (4 Sesi)',
      expertiseTags: ['Asesmen Autentik', 'Kebijakan Pendidikan', 'Audit Lembaga', 'Mutu Guru'],
    ),
    TokohItem(
      id: 'ummu-khusna',
      name: 'Ummu Khusna, S.Psi., Psikolog',
      title: 'Konselor Keluarga Nabawiyah & Terapis Emosi Anak',
      focus: 'Inner Child Orang Tua, Pemulihan Trauma Pengasuhan, & Terapi Kazhmul Ghaizh',
      works: 'Buku "Mizan Nafs: Keseimbangan Emosi Orang Tua", Panduan P3K Emosi Bunda',
      goldenQuote: '“Sebelum menuntut anak memiliki jiwa muthma\'innah, periksalah bejana emosi ayah dan bunda.”',
      imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80',
      audioSeries: 'Terapi Qalbu: Menyembuhkan Luka Asuh & Regulasi Emosi Ortu (10 Sesi)',
      expertiseTags: ['Konseling Keluarga', 'Tazkiyatun Nafs', 'Inner Child', 'Regulasi Emosi'],
    ),
  ];

  static const List<LembagaItem> _canonicalLembaga = [
    LembagaItem(
      id: 'skis',
      name: 'Sekolah Karakter Imam Syafi\'i',
      acronym: 'SKIS',
      city: 'Balikpapan',
      type: 'Sekolah Karakter Dasar & Menengah',
      description: 'Pionir implementasi kurikulum adab sebelum ilmu dan 19 indikator observasi syakilah anak di Kalimantan Timur.',
      partnershipProgram: 'Sentra Magang Guru Kuttab, Laboratorium Living Rehearsal KBM, & Daurah Praktik Lapangan',
      imageUrl: 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=300&q=80',
      studentsCount: 420,
    ),
    LembagaItem(
      id: 'hu',
      name: 'Homeschooling Usrati Mandiri',
      acronym: 'HU',
      city: 'Yogyakarta',
      type: 'Komunitas Homeschooling Berbasis Masjid',
      description: 'Jaringan 180+ keluarga praktisi pendidikan berbasis rumah yang mengadopsi kurikulum parenting karakter nabawiyah.',
      partnershipProgram: 'Modul Home-Curriculum PKN, Sesi Konseling Keluarga Berkala, & Portofolio Bakat Mandiri',
      imageUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=300&q=80',
      studentsCount: 260,
    ),
    LembagaItem(
      id: 'sotab',
      name: 'Sekolah Orang Tua Ahsanul Balad',
      acronym: 'SOTAB HEBAT',
      city: 'Bandung',
      type: 'Pusat Diklat Parenting Nabawiyah',
      description: "Lembaga kaderisasi orang tua pejuang adab dengan silabus berjenjang 3 tingkatan (Bidayah, Mutawassith, 'Aali).",
      partnershipProgram: 'Sertifikasi Fasilitator Parenting PKN, Workshop P3K Krisis Jiwa, & Modul AI Simulasi Interaktif',
      imageUrl: 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?auto=format&fit=crop&w=300&q=80',
      studentsCount: 850,
    ),
    LembagaItem(
      id: 'darul-atsar',
      name: 'Pesantren Mahad Darul Atsar',
      acronym: 'Darul Atsar',
      city: 'Temanggung',
      type: 'Pondok Pesantren Tahfizh & Adab',
      description: 'Pesantren rujukan pembentukan kemandirian adab murahaqah (usia 11-15 tahun) berbasis sunnah dan khidmat umat.',
      partnershipProgram: 'Program Asistensi Adab Asrama, Standarisasi Musyrif/Musyrifah, & Modul Kazhmul Ghaizh Santri',
      imageUrl: 'https://images.unsplash.com/photo-1541829070764-84a7d30dd3f3?auto=format&fit=crop&w=300&q=80',
      studentsCount: 310,
    ),
    LembagaItem(
      id: 'ybit',
      name: 'Yayasan Bina Insan Teladan',
      acronym: 'YBIT',
      city: 'Solo',
      type: 'Jaringan Sekolah Islam Terpadu',
      description: 'Membawahi 4 unit TK-SD-SMP dengan fokus integrasi nilai tauhid dan adab dalam sains alamiah.',
      partnershipProgram: 'Audit Ekosistem Adab Sekolah, Coaching Kepala Sekolah, & Sinkronisasi RPP Tematik Nabawiyah',
      imageUrl: 'https://images.unsplash.com/photo-1509062522246-3755977927d7?auto=format&fit=crop&w=300&q=80',
      studentsCount: 650,
    ),
    LembagaItem(
      id: 'ybim',
      name: 'Yayasan Baitul Izzah Mandiri',
      acronym: 'YBIM',
      city: 'Surabaya',
      type: 'Lembaga Sosial & Pendidikan Keluarga',
      description: 'Berfokus pada pemulihan keluarga rentan, anak yatim dhuafa, dan bimbingan pranikah berlandaskan manhaj nabawiyah.',
      partnershipProgram: 'Klinik Konseling Keluarga Gratis, Pelatihan Guru TPA Desa Binaan, & Beasiswa Santri Karakter',
      imageUrl: 'https://images.unsplash.com/photo-1491438590914-bc09fcaaf77a?auto=format&fit=crop&w=300&q=80',
      studentsCount: 190,
    ),
  ];

  static const List<KemitraanServiceItem> _canonicalServices = [
    KemitraanServiceItem(
      id: 'serv_1',
      title: 'Konsultasi Kurikulum & SOP Karakter',
      target: 'Yayasan, Kepala Sekolah & Pengembang Kurikulum',
      duration: 'Program 1 - 3 Bulan Intensif',
      description: 'Penyusunan blueprint kurikulum adab sebelum ilmu yang disesuaikan dengan kultur dan visi-misi yayasan/sekolah.',
      deliverables: [
        'Dokumen Roadmap Kurikulum Karakter 6 Tahun (TK/SD)',
        '19 Indikator Observasi Adab versi kustom lembaga',
        'Pedoman SOP Krisis Disiplin tanpa hukuman fisik',
        'Template RPP Adab Terintegrasi 1 Lembar',
      ],
      iconName: 'book',
    ),
    KemitraanServiceItem(
      id: 'serv_2',
      title: 'Visitasi & Audit Ekosistem Adab',
      target: 'Sekolah, Pesantren & Lembaga Pendidikan',
      duration: '3 Hari Observasi Lapangan + 1 Bulan Pendampingan',
      description: 'Tim auditor pakar PKN turun langsung ke lapangan mengamati interaksi nyata guru-siswa di kelas, masjid, kantin, dan asrama.',
      deliverables: [
        'Laporan Diagnostik 360 Derajat Iklim Emosi Sekolah',
        'Analisis Titik Rawan Pelanggaran Adab & Solusi Syar\'i',
        'Sesi Rekomendasi Khusus bersama Dewan Pembina/Yayasan',
        'Sertifikat Kelayakan Ekosistem Ramah Adab PKN',
      ],
      iconName: 'eye',
    ),
    KemitraanServiceItem(
      id: 'serv_3',
      title: 'In-House Coaching Guru & Fasilitator',
      target: 'Seluruh Dewan Asatidzah & Guru Kelas',
      duration: 'Workshop 16 Jam Tatap Muka + 4x Supervisi KBM',
      description: 'Pelatihan praktis Living Rehearsal: melatih guru menguasai dialektika respon batin saat menghadapi anak sulit.',
      deliverables: [
        'Simulasi Roleplay Menangani Kasus Nyata di Kelas',
        'Pelatihan Kazhmul Ghaizh (Menahan Marah bagi Pendidik)',
        'Akses Eksklusif Bank Modul & Bahan Ajar Digital',
        'Sertifikat Kompetensi Guru Karakter Nabawiyah',
      ],
      iconName: 'user',
    ),
    KemitraanServiceItem(
      id: 'serv_4',
      title: 'Daurah Tematik Wali Santri / Parenting Day',
      target: 'Orang Tua / Wali Murid Seluruh Jenjang',
      duration: 'Seminar Akbar 1 Hari Penuh atau Serial Bulanan',
      description: 'Menyelaraskan frekuensi pengasuhan antara rumah dan sekolah agar tidak terjadi kontradiksi pola asuh pada ananda.',
      deliverables: [
        'Pemaparan Materi oleh Tokoh/Asatidzah Pakar PKN',
        'Buku Panduan Adab Orang Tua di Rumah untuk Peserta',
        'Sesi Tanya Jawab & Konsultasi Kasus Pribadi',
        'Pembentukan Komunitas Lingkar Ayah & Bunda Tangguh',
      ],
      iconName: 'community',
    ),
  ];
}
