import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/storage_service.dart';
import '../../data/mock_ideas.dart';
import '../../data/models/idea_card.dart';

class FeedState {
  final List<IdeaCard> allIdeas;
  final String selectedCategory; // 'All' or specific domain
  final String searchQuery;

  const FeedState({
    this.allIdeas = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  List<IdeaCard> get filteredIdeas {
    return allIdeas.where((idea) {
      final matchesCategory = selectedCategory == 'All' ||
          idea.category.toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch = searchQuery.isEmpty ||
          idea.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          idea.coreThesis.toLowerCase().contains(searchQuery.toLowerCase()) ||
          idea.tags.any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  FeedState copyWith({
    List<IdeaCard>? allIdeas,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return FeedState(
      allIdeas: allIdeas ?? this.allIdeas,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

final feedControllerProvider =
    StateNotifierProvider<FeedController, FeedState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return FeedController(storageService);
});

class FeedController extends StateNotifier<FeedState> {
  final StorageService _storageService;

  FeedController(this._storageService) : super(const FeedState()) {
    _loadIdeas();
  }

  void _loadIdeas() {
    final bookmarkedIds = _storageService.getBookmarkedIds();
    final userFocus = _storageService.getUserFocus();

    final mappedIdeas = MockIdeasRepository.ideas.map((idea) {
      return idea.copyWith(isBookmarked: bookmarkedIds.contains(idea.id));
    }).toList();

    state = state.copyWith(
      allIdeas: mappedIdeas,
      selectedCategory: userFocus != null ? _capitalize(userFocus) : 'All',
    );
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> toggleBookmark(String ideaId) async {
    await _storageService.toggleBookmark(ideaId);
    final updatedIdeas = state.allIdeas.map((idea) {
      if (idea.id == ideaId) {
        return idea.copyWith(isBookmarked: !idea.isBookmarked);
      }
      return idea;
    }).toList();

    state = state.copyWith(allIdeas: updatedIdeas);
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
