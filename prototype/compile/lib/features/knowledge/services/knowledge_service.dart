import '../data/models/knowledge_article.dart';

class KnowledgeService {
  Future<List<KnowledgeArticle>> getFeaturedArticles() async {
    return _curatedArticles;
  }

  Future<List<KnowledgeArticle>> searchArticles({
    required String query,
    String? categoryFilter,
    bool? onlyExpertVerified,
  }) async {
    final q = query.trim().toLowerCase();
    return _curatedArticles.where((a) {
      if (onlyExpertVerified == true && !a.isExpertVerified) return false;
      if (categoryFilter != null &&
          categoryFilter != 'Semua' &&
          a.category != categoryFilter) {
        return false;
      }
      if (q.isEmpty) return true;
      return a.title.toLowerCase().contains(q) ||
          a.summary.toLowerCase().contains(q) ||
          a.tags.any((t) => t.toLowerCase().contains(q)) ||
          a.body.toLowerCase().contains(q);
    }).toList();
  }

  static const List<KnowledgeArticle> _curatedArticles = [
    KnowledgeArticle(
      id: 'art_1',
      title: 'Tazkiyatun Nafs Orang Tua Sebagai Pondasi Utama Adab Anak',
      category: 'Kaidah Fitrah',
      contentType: 'guide',
      provenance: 'expert_verified',
      author: 'Ustadz Adriano Rusfi, S.Psi',
      summary:
          'Penyucian jiwa orang tua mendahului pembentukan karakter anak. Anak adalah spons spiritual yang menyerap getaran batin ayah bundanya.',
      body:
          'Sesungguhnya pendidikan karakter nabawiyah bertumpu pada kesucian kalbu pendidiknya. '
          'Ketika orang tua gelisah, anak akan merespon dengan kegelisahan sensorik atau perlawanan emosi. '
          'Rasulullah ﷺ mendidik para sahabat bukan dengan rumus-rumus teknis belaka, melainkan dengan pancaran '
          'akhlak yang bersumber dari hati yang senantiasa berdzikir dan beristighfar.\n\n'
          'Tiga Langkah Tazkiyah Harian:\n'
          '1. Muhasabah subuh sebelum berinteraksi dengan anak.\n'
          '2. Istighfar saat dorongan amarah mulai merayap di dada.\n'
          '3. Mendoakan kebaikan spesifik untuk setiap anak dalam sujud terakhir shalat.',
      tags: ['Tazkiyah', 'Adab', 'Qalbu', 'Fitrah'],
      similarityScore: 0.94,
    ),
    KnowledgeArticle(
      id: 'art_2',
      title: 'Kaidah Mizan: Keseimbangan Antara Kasih Sayang dan Ketegasan',
      category: 'Kaidah Fitrah',
      contentType: 'essay',
      provenance: 'expert_verified',
      author: 'Kutub Khazanah Nabawiyah',
      summary:
          'Fitrah anak memerlukan kelembutan yang tidak memanjakan dan ketegasan yang tidak melukai martabat ruhaniahnya.',
      body:
          'Mizan adalah timbangan keadilan. Dalam pendidikan nabawiyah, kasih sayang tanpa ketegasan akan melahirkan anak yang rapuh, '
          'sedangkan ketegasan tanpa kasih sayang akan menumbuhkan anak yang munafik atau memberontak.\n\n'
          'Kaidah ini membagi peran Ayah sebagai pilar ketegasan visioner dan Bunda sebagai pilar kehangatan tempat berteduh.',
      tags: ['Mizan', 'Keseimbangan', 'Tamyiz'],
      similarityScore: 0.89,
    ),
    KnowledgeArticle(
      id: 'art_3',
      title: 'Peta Perkembangan Fitrah: Fase Thufulah (0-7 Tahun) & Bermain Riang',
      category: 'Fase Usia',
      contentType: 'curriculum',
      provenance: 'ai_assisted',
      author: 'Wiki PKN AI Corpus Synthesizer',
      summary:
          'Pada fase 0-7 tahun, anak adalah raja yang dilayani dengan cinta. Belum ada beban syariat maupun penegakan disiplin kaku.',
      body:
          'Berdasarkan konsensus manhaj nabawiyah, anak usia di bawah 7 tahun berada dalam masa penanaman rasa aman dan cinta.\n'
          'Larangan keras syariat: Jangan memukul atau memberi hukuman fisik pada fase ini. '
          'Fokus utama adalah memperbanyak pelukan, teladan ketenangan, dan dialog kasih sayang.',
      tags: ['0-7 Tahun', 'Thufulah', 'Bermain'],
      similarityScore: 0.86,
    ),
    KnowledgeArticle(
      id: 'art_4',
      title: 'Fase Tamyiz (7-10 Tahun): Menumbuhkan Kesadaran Membedakan Baik & Buruk',
      category: 'Fase Usia',
      contentType: 'curriculum',
      provenance: 'expert_verified',
      author: 'Dewan Pakar PKN',
      summary:
          'Fase transisi dari bermain bebas menuju pembiasaan shalat dan tanggung jawab tugas rumah secara bertahap.',
      body:
          'Hadits Abu Dawud 495: “Perintahkan anak-anakmu shalat ketika berusia 7 tahun...”\n'
          'Perintah di sini bermakna ajakan yang konsisten, berulang hingga ribuan kali dengan senyuman dan bimbingan, bukan ancaman kemarahan.',
      tags: ['Tamyiz', 'Shalat', '7-10 Tahun'],
      similarityScore: 0.88,
    ),
    KnowledgeArticle(
      id: 'art_5',
      title: 'SOP Thuma\'ninah 10 Detik Saat Emosi Memuncak',
      category: 'P3K Jiwa',
      contentType: 'guide',
      provenance: 'expert_verified',
      author: 'Tim Konseling PKN',
      summary:
          'Protokol tanggap darurat saat orang tua merasa ingin berteriak atau meledak emosi di depan anak.',
      body:
          'Langkah SOP:\n'
          '1. Berhenti berbicara seketika (diam adalah emas di kala amarah).\n'
          '2. Tarik nafas dalam 4 detik, tahan 4 detik, hembuskan sambil mengucap ta\'awwudz.\n'
          '3. Jika berdiri maka duduklah, jika duduk maka berbaringlah atau segera ambil air wudhu.',
      tags: ['P3K', 'Emosi', 'Thuma\'ninah'],
      similarityScore: 0.92,
    ),
  ];
}
