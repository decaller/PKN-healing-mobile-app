import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/storage_service.dart';
import '../../data/jtbd_data.dart';
import '../../domain/onboarding_state.dart';

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return OnboardingController(storageService);
});

class OnboardingController extends StateNotifier<OnboardingState> {
  final StorageService _storageService;

  OnboardingController(this._storageService)
      : super(const OnboardingState());

  void selectOption(String questionId, String optionId) {
    final updatedAnswers = Map<String, String>.from(state.answers);
    updatedAnswers[questionId] = optionId;
    state = state.copyWith(answers: updatedAnswers);
  }

  bool nextStep() {
    final questions = JTBDRepository.questions;
    if (state.currentStepIndex < questions.length - 1) {
      state = state.copyWith(currentStepIndex: state.currentStepIndex + 1);
      return false; // Still within questionnaire
    } else {
      // Finished all questions -> Ready for Activational Insight
      return true;
    }
  }

  void previousStep() {
    if (state.currentStepIndex > 0) {
      state = state.copyWith(currentStepIndex: state.currentStepIndex - 1);
    }
  }

  Future<void> finalizeOnboarding() async {
    await _storageService.setOnboardingCompleted(true);
    await _storageService.setUserRole(state.userRole);
    await _storageService.setUserFocus(state.primaryDomain);
    state = state.copyWith(isCompleted: true);
  }
}
