import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_microlearning_app/core/storage/storage_service.dart';
import 'package:pkn_microlearning_app/features/onboarding/data/jtbd_data.dart';
import 'package:pkn_microlearning_app/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('OnboardingController Tests', () {
    late StorageService storageService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      storageService = StorageService(prefs);
    });

    test('Initializes with step 0 and empty answers', () {
      final controller = OnboardingController(storageService);
      expect(controller.state.currentStepIndex, 0);
      expect(controller.state.answers.isEmpty, isTrue);
      expect(controller.state.isCompleted, isFalse);
    });

    test('Records answer selection and navigates through steps', () {
      final controller = OnboardingController(storageService);
      final questions = JTBDRepository.questions;

      // Step 1
      controller.selectOption(questions[0].id, questions[0].options[0].id);
      expect(controller.state.answers[questions[0].id], questions[0].options[0].id);

      final isLast = controller.nextStep();
      expect(isLast, isFalse);
      expect(controller.state.currentStepIndex, 1);
    });

    test('Computes persona archetype correctly', () {
      final controller = OnboardingController(storageService);
      controller.selectOption('current_role', 'product_tech');
      expect(controller.state.personaArchetype, 'Strategic Product Architect');

      controller.selectOption('current_role', 'growth_marketing');
      expect(controller.state.personaArchetype, 'Venture Growth Strategist');
    });

    test('Finalizes onboarding and writes flags to storage', () async {
      final controller = OnboardingController(storageService);
      controller.selectOption('current_role', 'founder_c_suite');
      controller.selectOption('primary_domain', 'strategy');

      await controller.finalizeOnboarding();
      expect(controller.state.isCompleted, isTrue);
      expect(storageService.isOnboardingCompleted, isTrue);
      expect(storageService.getUserRole(), 'founder_c_suite');
      expect(storageService.getUserFocus(), 'strategy');
    });
  });
}
