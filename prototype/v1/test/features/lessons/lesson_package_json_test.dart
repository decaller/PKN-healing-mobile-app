import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_microlearning_app/features/lessons/data/models/lesson_package.dart';
import 'package:pkn_microlearning_app/features/lessons/presentation/controllers/lesson_player_provider.dart';

void main() {
  group('LessonPackage JSON Schema Tests', () {
    const rawJson = '''
    {
      "lessonId": "growth-01-cac-ltv",
      "title": "Mastering the CAC to LTV Ratio",
      "category": "Growth Marketing",
      "estimatedMinutes": 4,
      "cards": [
        {
          "stepId": "step_01",
          "type": "text",
          "title": "The Golden Rule of Unit Economics",
          "body": "A healthy business model requires your Customer Lifetime Value (**LTV**) to be at least 3x higher than your Customer Acquisition Cost (**CAC**)."
        },
        {
          "stepId": "step_02",
          "type": "multiple_choice",
          "question": "What is the standard benchmark LTV:CAC ratio target for a healthy subscription business?",
          "options": [
            { "id": "opt_a", "text": "1:1 (Break-even)", "isCorrect": false },
            { "id": "opt_b", "text": "3:1 or higher", "isCorrect": true },
            { "id": "opt_c", "text": "0.5:1 (Loss leader)", "isCorrect": false }
          ],
          "explanation": "A 3:1 ratio ensures enough margin to cover operational overhead, churn, and sustainable scaling."
        },
        {
          "stepId": "step_03",
          "type": "summary",
          "title": "Key Takeaway",
          "body": "Never scale ad spend until your LTV:CAC ratio consistently crosses the 3x threshold."
        }
      ]
    }
    ''';

    test('Parses raw JSON schema into strongly typed LessonPackage', () {
      final Map<String, dynamic> jsonMap = jsonDecode(rawJson);
      final package = LessonPackage.fromJson(jsonMap);

      expect(package.lessonId, 'growth-01-cac-ltv');
      expect(package.title, 'Mastering the CAC to LTV Ratio');
      expect(package.category, 'Growth Marketing');
      expect(package.estimatedMinutes, 4);
      expect(package.cards.length, 3);

      final step1 = package.cards[0];
      expect(step1.stepId, 'step_01');
      expect(step1.type, 'text');
      expect(step1.title, 'The Golden Rule of Unit Economics');

      final step2 = package.cards[1];
      expect(step2.stepId, 'step_02');
      expect(step2.type, 'multiple_choice');
      expect(step2.options.length, 3);
      expect(step2.options.firstWhere((o) => o.isCorrect).id, 'opt_b');

      final step3 = package.cards[2];
      expect(step3.type, 'summary');
    });

    test('LessonPlayerNotifier manages session progression and answers', () {
      final notifier = LessonPlayerNotifier(3);
      expect(notifier.state.currentIndex, 0);
      expect(notifier.state.isCompleted, isFalse);

      notifier.answerQuestion('step_02', 'opt_b');
      expect(notifier.state.userAnswers['step_02'], 'opt_b');

      notifier.nextCard();
      expect(notifier.state.currentIndex, 1);

      notifier.nextCard();
      expect(notifier.state.currentIndex, 2);

      notifier.nextCard();
      expect(notifier.state.isCompleted, isTrue);

      notifier.previousCard();
      expect(notifier.state.currentIndex, 1);
    });
  });
}
