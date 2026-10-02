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
      case 'pembelajar_santri':
        return 'Pembelajar Mandiri • Penjelajah Fitrah TB-40';
      case 'ayah':
      default:
        return 'Ayah • Qawwamun & Penegak Visi Nabawiyah';
    }
  }

  String get recommendedPilarMoc {
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
      case 'pembelajar_santri':
        return 'Fokus pada pemetaan 40 pilar bakat ciptaan Allah, orientasi penjurusan syakilah, dan penjagaan iffah pemuda.';
      case 'ayah':
      default:
        return 'Fokus pada sinergi penegakan disiplin shalat usia 7 vs 10 tahun, panduan dialog Luqman akhir pekan, dan penguatan visi keluarga.';
    }
  }
}
