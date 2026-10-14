import '../data/models/book_model.dart';

class PustakaService {
  List<BookItem> getBooks() {
    return _canonicalBooks;
  }

  BookItem? getBookById(String id) {
    try {
      return _canonicalBooks.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  static const List<BookItem> _canonicalBooks = [
    BookItem(
      id: 'buku_1',
      title: 'Tiga Bahasa Mendidik (Hati, Lisan, Tangan Terukur)',
      author: 'Ust. Abdul Kholiq, Lc., M.P.I.',
      category: 'Manhaj & Pondasi',
      coverUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=300&q=80',
      synopsis:
          'Karya agung yang mengupas trilogi komunikasi mendidik dalam Manhaj Nabawiyah: menautkan frekuensi hati sebelum lisan berbicara, menahan kata-kata celaan, dan sentuhan ketegasan fisik yang terukur tanpa melukai jiwa dan raga ananda.',
      goldenQuote:
          '“Koneksi sebelum koreksi. Penuhi bejana cinta anak sebelum menegakkan aturan ibadah.”',
      totalPages: 320,
      isbn: '978-602-5123-01-4',
      publisher: 'Pustaka Khazanah Nabawiyah',
      rating: 4.95,
      priceLabel: 'Rp 115.000',
      tableOfContents: [
        'Bab 1: Menata Niat & Kesucian Qalbu Pendidik',
        'Bab 2: Bahasa Hati — Menatap, Mendengar, dan Validasi Fitrah',
        'Bab 3: Bahasa Lisan — Kalam Thayyib Tanpa Sarkasme & Bentakan',
        'Bab 4: Bahasa Tindakan Terukur — Batasan Syar\'i & Kaidah Tarbiyah',
        'Bab 5: Studi Kasus Pemulihan Anak Korban Luka Pengasuhan',
      ],
    ),
    BookItem(
      id: 'buku_2',
      title: 'Kaidah Syakilah: Menemukan Desain Unik Anak',
      author: 'Ust. Adriano Rusfi, S.Psi',
      category: 'Karakter & Bakat',
      coverUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=300&q=80',
      synopsis:
          'Menyelami QS. Al-Isra ayat 84: Setiap insan beramal menurut syakilah (pola bawaan fitrah)-nya masing-masing. Panduan praktis bagi orang tua untuk memetakan bakat, emosi, dan kecenderungan unik anak tanpa membanding-bandingkan.',
      goldenQuote:
          '“Mendidik bukan mencetak anak menjadi fotokopi orang tua, melainkan mengantarkan anak menjadi versi terbaik dari fitrah yang Allah titipkan padanya.”',
      totalPages: 274,
      isbn: '978-602-5123-02-1',
      publisher: 'SOTAB Press',
      rating: 4.90,
      priceLabel: 'Rp 98.000',
      tableOfContents: [
        'Bab 1: Memahami Ayat Syakilah dalam Konteks Psikologi Islam',
        'Bab 2: Tipologi Fitrah: Pemikir, Penggerak, Pengayom, Penjaga',
        'Bab 3: Mengapa Pendekatan Generalis Gagal Menumbuhkan Adab',
        'Bab 4: Portofolio Bakat Nabawiyah di Lingkup Keluarga',
      ],
    ),
    BookItem(
      id: 'buku_3',
      title: 'Fase Tamyiz: Menumbuhkan Tanggung Jawab Shalat',
      author: 'Ust. Bayu Chandra, S.Pd., M.Ed.',
      category: 'Adab & Ibadah',
      coverUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=300&q=80',
      synopsis:
          'Panduan komprehensif mengawal usia transisi 7-10 tahun. Mengupas seni membangkitkan kerinduan bersujud tanpa paksaan, jadwal bertahap wudhu mandiri, serta transisi hijrah dari kecanduan layar digital ke interaksi sosial nyata.',
      goldenQuote:
          '“Adab shalat tidak dibangun dalam semalam saat anak berusia 10 tahun; ia dirajut melalui keteladanan senyap ribuan kali di hadapan matanya.”',
      totalPages: 240,
      isbn: '978-602-5123-03-8',
      publisher: 'SKIS Publishing',
      rating: 4.88,
      priceLabel: 'Rp 88.000',
      tableOfContents: [
        'Bab 1: Batasan Fiqih Usia Tamyiz dan Hak-hak Anak',
        'Bab 2: Menghidupkan Kerinduan Sujud di Rumah',
        'Bab 3: 19 Indikator Observasi Adab Mandiri SOTAB',
        'Bab 4: Manajemen Waktu & Transisi Hijrah Gawai',
      ],
    ),
    BookItem(
      id: 'buku_4',
      title: 'Living Rehearsal KBM: 19 Butir Observasi Adab',
      author: 'Tim Litbang SOTAB HEBAT',
      category: 'Kurikulum & Guru',
      coverUrl: 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=300&q=80',
      synopsis:
          'Buku pegangan para guru kuttab, sekolah Islam, dan orang tua homeschooling. Memuat lembar instrumen observasi adab harian, matriks rubrik respon batin anak, dan simulasi dialektika adab di kelas.',
      goldenQuote:
          '“Adab tidak cukup diujikan di lembar soal kertas, melainkan diobservasi dalam respon spontan anak saat menghadapi kekecewaan dan kegagalan.”',
      totalPages: 310,
      isbn: '978-602-5123-04-5',
      publisher: 'SOTAB Litbang Press',
      rating: 4.92,
      priceLabel: 'Rp 120.000',
      tableOfContents: [
        'Bab 1: Metodologi Observasi Respon Spontan (Living Rehearsal)',
        'Bab 2: 19 Butir Indikator Adab Terhadap Diri, Kawan, dan Guru',
        'Bab 3: Rubrik Asesmen Non-Angka yang Menguatkan Fitrah',
        'Bab 4: Lembar Kerja Guru & Bank Simulasi Kasus Nyata',
      ],
    ),
    BookItem(
      id: 'buku_5',
      title: 'Mizan Nafs: Keseimbangan Emosi Orang Tua',
      author: 'Ummu Khusna, S.Psi.',
      category: 'Parenting & Emosi',
      coverUrl: 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?auto=format&fit=crop&w=300&q=80',
      synopsis:
          'Sebuah karya reflektif bagi para ibu dan ayah yang lelah. Membimbing proses tazkiyatun nafs, melepaskan trauma masa lalu (inner child), dan melatih seni kazhmul ghaizh agar rumah tangga senantiasa menjadi baiti jannati.',
      goldenQuote:
          '“Sebelum menuntut anak memiliki jiwa muthma\'innah, periksalah apakah hati orang tuanya masih dikuasai nafs ammarah.”',
      totalPages: 215,
      isbn: '978-602-5123-05-2',
      publisher: 'Darul Atsar Media',
      rating: 4.97,
      priceLabel: 'Rp 85.000',
      tableOfContents: [
        'Bab 1: Mengurai Beban Batin Ibu dan Ayah',
        'Bab 2: Psikologi Islam: Ammarah, Lawwamah, Muthma\'innah',
        'Bab 3: Dzikir, Doa, dan Terapi Emosi Berbasis Syar\'i',
        'Bab 4: Membangun Resiliensi Mental Keluarga Muslim',
      ],
    ),
  ];
}
