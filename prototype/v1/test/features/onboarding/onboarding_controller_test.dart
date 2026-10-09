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
      controller.selectOption('current_role', 'ayah');
      expect(controller.state.personaArchetype, 'Ayah • Qawwamun & Penegak Visi Nabawiyah');

      controller.selectOption('current_role', 'bunda');
      expect(controller.state.personaArchetype, 'Bunda • Madrasah Utama & Pusat Kelekatan');

      controller.selectOption('current_role', 'guru');
      expect(controller.state.personaArchetype, 'Pendidik Fitrah & Fasilitator Adab');

      controller.selectOption('current_role', 'pengelola');
      expect(controller.state.personaArchetype, 'Pengelola Lembaga & Arsitek Ekosistem Fitrah');
      expect(controller.state.recommendedPilarMoc, 'P5: Lembaga & Guru');

      controller.selectOption('current_role', 'pembelajar_santri');
      expect(controller.state.personaArchetype, 'Santri & Pemuda • Penjelajah Fitrah TB-40');

      controller.selectOption('current_role', 'mandiri_tazkiyah');
      expect(controller.state.personaArchetype, 'Pembelajar Mandiri • Penata Jiwa & Tazkiyah');
      expect(controller.state.recommendedPilarMoc, 'P1: Mulai di Sini');
    });

    test('Finalizes onboarding and writes flags to storage', () async {
      final controller = OnboardingController(storageService);
      controller.selectOption('current_role', 'ayah');
      controller.selectOption('bottleneck', 'tantrum_emosi');

      await controller.finalizeOnboarding();
      expect(controller.state.isCompleted, isTrue);
      expect(storageService.isOnboardingCompleted, isTrue);
      expect(storageService.getUserRole(), 'ayah');
      expect(storageService.getUserFocus(), 'P4: Praktik Keluarga');
    });
  });
}
