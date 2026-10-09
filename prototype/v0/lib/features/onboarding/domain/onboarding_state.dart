class OnboardingState {
  final int currentStepIndex;
  final Map<String, String> answers;
  final bool isCompleted;

  const OnboardingState({
    this.currentStepIndex = 0,
    this.answers = const {},
    this.isCompleted = false,
  });

  OnboardingState copyWith({
    int? currentStepIndex,
    Map<String, String>? answers,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      answers: answers ?? this.answers,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  String get userRole => answers['current_role'] ?? 'ayah';
  String get targetFase => answers['target_fase'] ?? 'tamyiz';
  String get primaryBottleneck => answers['bottleneck'] ?? 'tantrum_emosi';
  String get dailyCommitment => answers['daily_time'] ?? 'time_5min';
  String get primaryDomain => recommendedPilarMoc;

  String get personaArchetype {
    switch (userRole) {
      case 'bunda':
        return 'Bunda • Madrasah Utama & Pusat Kelekatan';
      case 'guru':
        return 'Pendidik Fitrah & Fasilitator Adab';
      case 'pengelola':
        return 'Pengelola Lembaga & Arsitek Ekosistem Fitrah';
      case 'pembelajar_santri':
        return 'Santri & Pemuda • Penjelajah Fitrah TB-40';
      case 'mandiri_tazkiyah':
        return 'Pembelajar Mandiri • Penata Jiwa & Tazkiyah';
      case 'ayah':
      default:
        return 'Ayah • Qawwamun & Penegak Visi Nabawiyah';
    }
  }

  String get recommendedPilarMoc {
    if (userRole == 'pengelola') {
      return 'P5: Lembaga & Guru';
    }
    if (userRole == 'mandiri_tazkiyah') {
      return 'P1: Mulai di Sini';
    }
    switch (primaryBottleneck) {
      case 'tantrum_emosi':
        return 'P4: Praktik Keluarga';
      case 'disiplin_shalat':
        return 'P2: Fase Tumbuh Kembang';
      case 'bakat_syakilah':
        return 'P3: Fitrah & Bakat TB-40';
      case 'burnout_lelah':
      default:
        return 'P1: Mulai di Sini';
    }
  }

  String get recommendedFocusDescription {
    switch (userRole) {
      case 'bunda':
        return 'Fokus pada teknik Bahasa Hati, pengisian tangki cinta ananda, dan self-care syar\'i untuk mencegah caregiver burnout.';
      case 'guru':
        return 'Fokus pada apersepsi sirah KBM 5 menit, lembar observasi adab fast-tap (BT-MT-BK-MM), dan SOP disiplin positif tanpa ranking.';
      case 'pengelola':
        return 'Fokus pada The Maqashid Program Filter, integrasi adab ke kurikulum KOSP/Kuttab, dan SOP perlindungan fitrah anak.';
      case 'pembelajar_santri':
        return 'Fokus pada pemetaan 40 pilar bakat ciptaan Allah, orientasi penjurusan syakilah, dan penjagaan iffah pemuda.';
      case 'mandiri_tazkiyah':
        return 'Fokus pada pembersihan penyakit hati, pemulihan luka pengasuhan masa lalu, dan penataan ketenangan batin (thuma\'ninah).';
      case 'ayah':
      default:
        return 'Fokus pada sinergi penegakan disiplin shalat usia 7 vs 10 tahun, panduan dialog Luqman akhir pekan, dan penguatan visi keluarga.';
    }
  }
}
