import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_prototype_compile/core/config/feature_flags.dart';

void main() {
  group('FeatureFlagsConfig Unit Tests', () {
    test('Default configuration enables all modules', () {
      const config = FeatureFlagsConfig();
      expect(config.enableCurhatAi, isTrue);
      expect(config.enableWalkieTalkie, isTrue);
      expect(config.enableDailyTask, isTrue);
      expect(config.enableRelationsProgress, isTrue);
      expect(config.enableEvents, isTrue);
      expect(config.enableKnowledgeWiki, isTrue);
      expect(config.enablePrimerLessons, isTrue);
      expect(config.enableP3kCrisis, isTrue);
      expect(config.enableChartsTestbed, isTrue);
      expect(config.enableStories, isTrue);
      expect(config.enabledCount, equals(10));
      expect(config.totalCount, equals(10));
    });

    test('Minimal core preset disables optional modules except P3K Crisis', () {
      final minimal = FeatureFlagsConfig.minimalCore();
      expect(minimal.enableCurhatAi, isFalse);
      expect(minimal.enableWalkieTalkie, isFalse);
      expect(minimal.enableDailyTask, isFalse);
      expect(minimal.enableRelationsProgress, isFalse);
      expect(minimal.enableEvents, isFalse);
      expect(minimal.enableKnowledgeWiki, isFalse);
      expect(minimal.enablePrimerLessons, isFalse);
      expect(minimal.enableP3kCrisis, isTrue);
      expect(minimal.enableChartsTestbed, isFalse);
      expect(minimal.enableStories, isFalse);
      expect(minimal.enabledCount, equals(1));
    });

    test('AI focused preset enables only AI and Walkie Talkie', () {
      final ai = FeatureFlagsConfig.aiFocused();
      expect(ai.enableCurhatAi, isTrue);
      expect(ai.enableWalkieTalkie, isTrue);
      expect(ai.enableDailyTask, isFalse);
      expect(ai.enableEvents, isFalse);
      expect(ai.enableKnowledgeWiki, isFalse);
      expect(ai.enablePrimerLessons, isFalse);
    });

    test('Learning focused preset enables Knowledge, Events, Lessons', () {
      final learning = FeatureFlagsConfig.learningFocused();
      expect(learning.enableKnowledgeWiki, isTrue);
      expect(learning.enableEvents, isTrue);
      expect(learning.enablePrimerLessons, isTrue);
      expect(learning.enableCurhatAi, isFalse);
      expect(learning.enableDailyTask, isFalse);
    });

    test('copyWith modifies only specified flags', () {
      const initial = FeatureFlagsConfig();
      final updated = initial.copyWith(enableCurhatAi: false, enableEvents: false);
      expect(updated.enableCurhatAi, isFalse);
      expect(updated.enableEvents, isFalse);
      expect(updated.enableKnowledgeWiki, isTrue);
      expect(updated.enabledCount, equals(8));
    });

    test('toMap and fromMap serialization roundtrip is lossless', () {
      final original = FeatureFlagsConfig.minimalCore();
      final map = original.toMap();
      final reconstructed = FeatureFlagsConfig.fromMap(map);
      expect(reconstructed.enableCurhatAi, equals(original.enableCurhatAi));
      expect(reconstructed.enableWalkieTalkie, equals(original.enableWalkieTalkie));
      expect(reconstructed.enableDailyTask, equals(original.enableDailyTask));
      expect(reconstructed.enableP3kCrisis, equals(original.enableP3kCrisis));
      expect(reconstructed.enabledCount, equals(original.enabledCount));
    });

    test('FeatureFlagsNotifier toggles individual flags reactively', () async {
      final notifier = FeatureFlagsNotifier(const FeatureFlagsConfig());
      expect(notifier.state.enableCurhatAi, isTrue);

      await notifier.toggleFlag('enableCurhatAi');
      expect(notifier.state.enableCurhatAi, isFalse);

      await notifier.toggleFlag('enableCurhatAi');
      expect(notifier.state.enableCurhatAi, isTrue);

      await notifier.setFlag('enableEvents', false);
      expect(notifier.state.enableEvents, isFalse);
    });
  });
}
