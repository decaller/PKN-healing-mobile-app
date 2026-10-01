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

  String get userRole => answers['current_role'] ?? 'founder_c_suite';
  String get primaryBottleneck => answers['bottleneck'] ?? 'strategy_clarity';
  String get primaryDomain => answers['primary_domain'] ?? 'strategy';

  String get personaArchetype {
    if (userRole == 'product_tech') return 'Strategic Product Architect';
    if (userRole == 'growth_marketing') return 'Venture Growth Strategist';
    if (userRole == 'founder_c_suite') return 'High-Leverage Executive';
    return 'Systems & Operations Specialist';
  }

  String get recommendedFocusDescription {
    switch (primaryDomain) {
      case 'product':
        return 'Focusing on activation loops, user friction elimination, and defensible moats.';
      case 'finance':
        return 'Optimizing capital efficiency, burn multiple, and margin expansion.';
      case 'marketing':
        return 'Mastering product positioning, viral coefficient, and category design.';
      case 'strategy':
      default:
        return 'Mastering high-output delegation, 7 Powers, and ruthlessly clear prioritization.';
    }
  }
}
