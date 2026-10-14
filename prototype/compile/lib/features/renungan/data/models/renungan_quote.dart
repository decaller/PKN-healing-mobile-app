/// Model data untuk Quote Renungan Nabawiyah
class RenunganQuote {
  final String id;
  final String text;
  final String? arabic;
  final String source;
  final String? category;

  const RenunganQuote({
    required this.id,
    required this.text,
    this.arabic,
    required this.source,
    this.category,
  });

  static const List<RenunganQuote> defaultQuotes = [
    RenunganQuote(
      id: 'quote_1',
      text: 'Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan.',
      arabic: null,
      source: 'Prinsip Emas Manhaj PKN',
      category: 'Kaidah Manhaj',
    ),
    RenunganQuote(
      id: 'quote_2',
      arabic: 'لَيْسَ الشَّدِيدُ بِالصُّرَعَةِ، إِنَّمَا الشَّدِيدُ الَّذِي يَمْلِكُ نَفْسَهُ عِنْدَ الْغَضَبِ',
      text: 'Bukanlah orang yang kuat itu yang pandai bergulat, melainkan orang yang mampu menahan dirinya ketika sedang marah.',
      source: 'HR. Bukhari no. 6114 & Muslim no. 2609',
      category: 'Kazhmul Ghaizh',
    ),
    RenunganQuote(
      id: 'quote_3',
      arabic: 'اللَّهُمَّ إِنِّيْ اجْتَهَدْتُ أَنْ أَؤدِّبَهُ فَلَمْ أَقْدِرْ عَلَى تَأَدِيْبِهِ فَأَدِّبْهُ أَنْتَ لِي',
      text: 'Ya Allah, sesungguhnya aku telah berusaha mendidik anakku namun aku tidak berdaya, maka didiklah dia untukku.',
      source: 'Munajat Imam Fudhail bin \'Iyadh (Siyar 7/408)',
      category: 'Munajat Qalbu',
    ),
    RenunganQuote(
      id: 'quote_4',
      arabic: 'إِذَا غَضِبَ أَحَدُكُمْ فَلْيَسْكُتْ',
      text: 'Bila salah seorang di antara kalian sedang marah, hendaklah ia diam.',
      source: 'HR. Ahmad no. 2136 (Shahih)',
      category: 'Adab Marah',
    ),
    RenunganQuote(
      id: 'quote_5',
      text: 'Anak kecil belum mukallaf. Jangan menuntut kedewasaan sebelum waktunya. Peluk hak egosentris fitrahnya agar kelak tidak memberontak saat pubertas.',
      arabic: null,
      source: 'Ustadz Abdul Kholiq, Lc., M.P.I. (SKIS & SOTAB)',
      category: 'Fitrah Usia',
    ),
    RenunganQuote(
      id: 'quote_6',
      arabic: 'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
      text: 'Ya Rabb kami, anugerahkanlah kepada kami pasangan dan keturunan kami sebagai penyejuk hati kami, dan jadikanlah kami pemimpin bagi orang-orang yang bertakwa.',
      source: 'QS. Al-Furqan: 74',
      category: 'Doa Qurani',
    ),
  ];
}
