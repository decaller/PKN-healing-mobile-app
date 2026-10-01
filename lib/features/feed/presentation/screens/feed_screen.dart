import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/route_paths.dart';
import '../../../app/theme/color_palette.dart';
import '../../../core/widgets/domain_badge.dart';
import '../controllers/feed_controller.dart';
import '../widgets/idea_card_widget.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<String> _categories = [
    'All',
    'Strategy',
    'Product',
    'Finance',
    'Marketing',
    'Leadership',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedControllerProvider);
    final feedNotifier = ref.read(feedControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ideas = feedState.filteredIdeas;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search mental models, authors, frameworks...',
                  border: InputBorder.none,
                ),
                onChanged: (val) => feedNotifier.updateSearch(val),
              )
            : Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.brandGold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.insights_rounded,
                      color: AppColors.brandGold,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'CURATED FEED',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  feedNotifier.updateSearch('');
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            onPressed: () => context.go(RoutePaths.profile),
          ),
        ],
      ),
      body: Column(
        children: [
          // Domain Category Chips Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _categories.map((cat) {
                final isSelected =
                    feedState.selectedCategory.toLowerCase() == cat.toLowerCase();
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) => feedNotifier.selectCategory(cat),
                    showCheckmark: false,
                    selectedColor: AppColors.brandPrimary.withOpacity(0.2),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.brandPrimary
                          : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 6),

          // Cards Feed
          Expanded(
            child: ideas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No mental models found',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Try clearing your search or picking another domain',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    itemCount: ideas.length,
                    itemBuilder: (context, index) {
                      final idea = ideas[index];
                      return IdeaCardWidget(
                        key: ValueKey(idea.id),
                        card: idea,
                        onBookmarkToggle: () =>
                            feedNotifier.toggleBookmark(idea.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
