import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_microlearning_app/core/storage/storage_service.dart';
import 'package:pkn_microlearning_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FeedController Tests', () {
    late StorageService storageService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'bookmarked_idea_ids': ['idea_jtbd_milkshake'],
        'user_focus': 'Strategy',
      });
      final prefs = await SharedPreferences.getInstance();
      storageService = StorageService(prefs);
    });

    test('Initializes with stored focus category and bookmarks', () {
      final controller = FeedController(storageService);
      expect(controller.state.selectedCategory, 'Strategy');

      final jtbdCard = controller.state.allIdeas.firstWhere(
        (i) => i.id == 'idea_jtbd_milkshake',
      );
      expect(jtbdCard.isBookmarked, isTrue);
    });

    test('Filters ideas properly by domain category', () {
      final controller = FeedController(storageService);
      controller.selectCategory('Product');

      final filtered = controller.state.filteredIdeas;
      expect(filtered.isNotEmpty, isTrue);
      expect(filtered.every((i) => i.category.toLowerCase() == 'product'), isTrue);
    });

    test('Toggles bookmark and updates state', () async {
      final controller = FeedController(storageService);
      const testId = 'idea_counter_positioning';

      // Initially false
      expect(
        controller.state.allIdeas.firstWhere((i) => i.id == testId).isBookmarked,
        isFalse,
      );

      // Toggle to true
      await controller.toggleBookmark(testId);
      expect(
        controller.state.allIdeas.firstWhere((i) => i.id == testId).isBookmarked,
        isTrue,
      );
      expect(storageService.getBookmarkedIds().contains(testId), isTrue);

      // Toggle back to false
      await controller.toggleBookmark(testId);
      expect(
        controller.state.allIdeas.firstWhere((i) => i.id == testId).isBookmarked,
        isFalse,
      );
    });

    test('Searches by keyword in title or thesis', () {
      final controller = FeedController(storageService);
      controller.selectCategory('All');
      controller.updateSearch('Netflix');

      final results = controller.state.filteredIdeas;
      expect(results.length, 1);
      expect(results.first.id, 'idea_counter_positioning');
    });
  });
}
