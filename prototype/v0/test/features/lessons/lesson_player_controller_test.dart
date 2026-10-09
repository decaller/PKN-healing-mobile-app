import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_microlearning_app/core/storage/storage_service.dart';
import 'package:pkn_microlearning_app/features/lessons/data/mock_lessons.dart';
import 'package:pkn_microlearning_app/features/lessons/data/models/lesson_models.dart';
import 'package:pkn_microlearning_app/features/lessons/presentation/controllers/lesson_player_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LessonPlayerController Tests', () {
    late StorageService storageService;
    final lesson = MockLessonsRepository.lessons.first;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      storageService = StorageService(prefs);
    });

    test('Initializes with step 0 and correct lesson', () {
      final controller = LessonPlayerController(storageService, lesson);
      expect(controller.state.currentStepIndex, 0);
      expect(controller.state.currentCard.id, 'kk_1');
      expect(controller.state.isDeckCompleted, isFalse);
    });

    test('Transitions from text step to interactive swipe poll step', () async {
      final controller = LessonPlayerController(storageService, lesson);

      final isFinished = await controller.proceedNext();
      expect(isFinished, isFalse);
      expect(controller.state.currentStepIndex, 1);
      expect(controller.state.currentCard is SwipePollCard, isTrue);

      // Choose poll
      controller.choosePoll(false);
      expect(controller.state.pollChoice, isFalse);
      expect(controller.state.isAnswerChecked, isTrue);
    });

    test('Validates multiple choice answer correctly', () async {
      final controller = LessonPlayerController(storageService, lesson);
      // Advance to multiple choice step (index 2)
      await controller.proceedNext();
      await controller.proceedNext();

      expect(controller.state.currentCard is MultipleChoiceCard, isTrue);
      final mcCard = controller.state.currentCard as MultipleChoiceCard;

      // Select wrong answer
      controller.selectMultipleChoiceOption((mcCard.correctIndex + 1) % 4);
      controller.checkAnswer();
      expect(controller.state.isAnswerChecked, isTrue);
      expect(controller.state.isAnswerCorrect, isFalse);
    });
  });
}
