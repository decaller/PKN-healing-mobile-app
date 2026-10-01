// ==============================================================================
// CONCEPTING PHASE: DEEPSTASH BOOKMARKS STATE BLUEPRINT
// ------------------------------------------------------------------------------
// Manages local state for saved/bookmarked idea cards. In the current concepting
// phase, this is synced with local SharedPreferences as a lightweight local cache.
// ==============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/storage_service.dart';

/// Riverpod StateNotifier for managing saved Deepstash-style idea cards locally.
final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, Set<String>>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return BookmarksNotifier(storageService);
});

class BookmarksNotifier extends StateNotifier<Set<String>> {
  final StorageService _storageService;

  BookmarksNotifier(this._storageService) : super({}) {
    _loadInitialBookmarks();
  }

  void _loadInitialBookmarks() {
    state = _storageService.getBookmarkedIds();
  }

  Future<void> toggleBookmark(String cardId) async {
    final currentBookmarks = Set<String>.from(state);
    if (currentBookmarks.contains(cardId)) {
      currentBookmarks.remove(cardId);
    } else {
      currentBookmarks.add(cardId);
    }
    state = currentBookmarks;
    await _storageService.toggleBookmark(cardId);
  }

  bool isBookmarked(String cardId) => state.contains(cardId);
}
