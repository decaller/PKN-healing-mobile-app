class JTBDQuestion {
  final String id;
  final String stepTitle;
  final String question;
  final String subtitle;
  final List<JTBDAnswerOption> options;

  const JTBDQuestion({
    required this.id,
    required this.stepTitle,
    required this.question,
    required this.subtitle,
    required this.options,
  });
}

class JTBDAnswerOption {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;

  const JTBDAnswerOption({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
  });
}

class JTBDRepository {
  static const List<JTBDQuestion> questions = [
    JTBDQuestion(
      id: 'current_role',
      stepTitle: 'Langkah 1 dari 4 • Amanah Peran',
      question: 'Apa peran utama Anda dalam ekosistem tarbiyah?',
      subtitle: 'Memastikan materi dan panduan disesuaikan dengan konteks tugas harian Anda.',
      options: [
        JTBDAnswerOption(
          id: 'ayah',
          title: 'Ayah / Kepala Keluarga',
          description: 'Qawwamun spiritual, penegak visi keluarga, keteladanan Luqman & Ibrahim.',
          iconEmoji: '🛡️',
        ),
        JTBDAnswerOption(
          id: 'bunda',
          title: 'Ibu / Bunda (Madrasah Utama)',
          description: 'Pusat kelekatan batin (bonding), pengasuhan harian & penanganan emosi anak.',
          iconEmoji: '🏡',
        ),
        JTBDAnswerOption(
          id: 'guru',
          title: 'Guru & Pendidik Karakter',
          description: 'Fasilitator KBM adab di PAUD, SD Tamyiz, SMP Murahaqah, atau Asrama.',
          iconEmoji: '🏫',
        ),
        JTBDAnswerOption(
          id: 'pengelola',
          title: 'Pengelola Lembaga & Mudir',
          description: 'SIT, Madrasah, Kuttab, Homeschooling, SOP iklim adab & kurikulum fitrah.',
          iconEmoji: '🏛️',
        ),
        JTBDAnswerOption(
          id: 'pembelajar_santri',
          title: 'Santri, Siswa & Pemuda',
          description: 'Penemuan potensi bakat TB-40, adab thalabul ilmi, dan orientasi syakilah.',
          iconEmoji: '🎒',
        ),
        JTBDAnswerOption(
          id: 'mandiri_tazkiyah',
          title: 'Pembelajar Mandiri & Tazkiyatun Nafs',
          description: 'Pembersihan jiwa, recovery luka pengasuhan, dan sakinah kepribadian.',
          iconEmoji: '🌿',
        ),
      ],
    ),
    JTBDQuestion(
      id: 'target_fase',
      stepTitle: 'Langkah 2 dari 4 • Fase Usia Fokus',
      question: 'Fase usia anak/santri mana yang paling Anda dampingi?',
      subtitle: 'Setiap fase memiliki kaidah perkembangan fitrah dan batasan syar\'i spesifik.',
      options: [
        JTBDAnswerOption(
          id: 'thufulah',
          title: 'Fase Thufulah (Usia 2–7 Tahun)',
          description: 'Fitrah bermain riang, pengenalan cinta Allah, larangan keras sanksi fisik.',
          iconEmoji: '🌱',
        ),
        JTBDAnswerOption(
          id: 'tamyiz',
          title: 'Fase Tamyiz (Usia 7–10 Tahun)',
          description: 'Pembiasaan shalat gembira, pembedaan baik-buruk, observasi 19 butir adab.',
          iconEmoji: '☀️',
        ),
        JTBDAnswerOption(
          id: 'murahaqah',
          title: 'Fase Murahaqah (Usia 10–14 Tahun)',
          description: 'Pemisahan tempat tidur, sanksi disiplin mendidik syar\'i, pematangan rasa malu.',
          iconEmoji: '🌙',
        ),
        JTBDAnswerOption(
          id: 'syabab_dewasa',
          title: 'Fase Baligh, Syabab & Dewasa (14+ Tahun)',
          description: 'Orientasi kontribusi (Syakilah TB-40), kesiapan aqil baligh, dan pemulihan luka batin.',
          iconEmoji: '🦅',
        ),
      ],
    ),
    JTBDQuestion(
      id: 'bottleneck',
      stepTitle: 'Langkah 3 dari 4 • Tantangan Utama',
      question: 'Apa tantangan paling mendesak yang Anda hadapi?',
      subtitle: 'Solusi Lead TL;DR 10 detik akan langsung diprioritaskan di beranda harian Anda.',
      options: [
        JTBDAnswerOption(
          id: 'tantrum_emosi',
          title: 'Anak Tantrum / Sulit Regulasi Emosi',
          description: 'Anak menangis berguling, membangkang, atau menjerit saat keinginannya ditolak.',
          iconEmoji: '⛈️',
        ),
        JTBDAnswerOption(
          id: 'disiplin_shalat',
          title: 'Anak Menolak / Menunda Shalat',
          description: 'Sulit diajak shalat tanpa bentakan atau ancaman yang melelahkan hati.',
          iconEmoji: '🕌',
        ),
        JTBDAnswerOption(
          id: 'burnout_lelah',
          title: 'Kelelahan Pengasuhan & Merasa Bersalah',
          description: 'Burnout setelah bekerja/mengurus rumah tangga, mudah terpancing emosi.',
          iconEmoji: '🔋',
        ),
        JTBDAnswerOption(
          id: 'bakat_syakilah',
          title: 'Bingung Membaca Bakat & Karakter Unik',
          description: 'Khawatir anak salah jurusan/profesi, butuh asesmen bakat fitrah TB-40.',
          iconEmoji: '🧭',
        ),
      ],
    ),
    JTBDQuestion(
      id: 'daily_time',
      stepTitle: 'Langkah 4 dari 4 • Komitmen Harian',
      question: 'Berapa waktu ideal Anda membaca & refleksi per hari?',
      subtitle: 'Seluruh materi PKN dirancang tuntas 3–5 menit tanpa basa-basi bertele-tele.',
      options: [
        JTBDAnswerOption(
          id: 'time_3min',
          title: '3 Menit Sehari (Executive Lead TL;DR)',
          description: 'Intisari solusi kilat yang dapat dibaca tuntas saat jeda istirahat.',
          iconEmoji: '⚡',
        ),
        JTBDAnswerOption(
          id: 'time_5min',
          title: '5 Menit Sehari (Interactive Primer Deck)',
          description: 'Kuis interaktif, studi kasus praktis, dan do\'a refleksi harian.',
          iconEmoji: '📱',
        ),
        JTBDAnswerOption(
          id: 'time_10min',
          title: '10 Menit Sehari (Kajian Sirah & Tazkiyah)',
          description: 'Mendengarkan audio sirah shahabat atau muhasabah penenang batin.',
          iconEmoji: '🎧',
        ),
      ],
    ),
  ];
}
