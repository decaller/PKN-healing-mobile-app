import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/route_paths.dart';
import '../../../app/theme/color_palette.dart';
import '../../../core/storage/storage_service.dart';
import '../../feed/presentation/controllers/feed_controller.dart';
import '../../feed/presentation/widgets/idea_card_widget.dart';
import '../../lessons/data/mock_lessons.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final storageService = ref.watch(storageServiceProvider);
    final feedState = ref.watch(feedControllerProvider);
    final feedNotifier = ref.read(feedControllerProvider.notifier);

    final completedLessons = storageService.getCompletedLessonIds();
    final bookmarkedIdeas = feedState.allIdeas.where((i) => i.isBookmarked).toList();
    final userRole = storageService.getUserRole() ?? 'founder_c_suite';
    final userFocus = storageService.getUserFocus() ?? 'Strategy';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EXECUTIVE PROFILE',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Retake Diagnostic',
            onPressed: () {
              context.go(RoutePaths.onboarding);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Executive Profile Card
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF1E222A), const Color(0xFF14171E)]
                    : [Colors.white, const Color(0xFFF6F8FB)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.brandGold.withOpacity(0.3),
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.brandGold.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text('👑', style: TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatRole(userRole),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Focus: ${userFocus.toUpperCase()}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.getDomainColor(userFocus),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(context, '5', 'Day Streak', '🔥'),
                    _buildStatColumn(
                      context,
                      '${completedLessons.length}/${MockLessonsRepository.lessons.length}',
                      'Decks Mastered',
                      '🎯',
                    ),
                    _buildStatColumn(
                      context,
                      '${bookmarkedIdeas.length}',
                      'Saved Ideas',
                      '📌',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Saved Ideas Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saved Mental Models',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                '${bookmarkedIdeas.length} cards',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (bookmarkedIdeas.isEmpty)
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.bookmark_add_outlined,
                      size: 40,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'No saved idea cards yet',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap the bookmark icon on any card in the feed to save it here for fast reference.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            )
          else
            ...bookmarkedIdeas.map((idea) {
              return IdeaCardWidget(
                key: ValueKey(idea.id),
                card: idea,
                onBookmarkToggle: () => feedNotifier.toggleBookmark(idea.id),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context,
    String value,
    String label,
    String emoji,
  ) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.brandGold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  String _formatRole(String role) {
    switch (role) {
      case 'product_tech':
        return 'Product & Tech Leader';
      case 'growth_marketing':
        return 'Revenue & Growth Leader';
      case 'operator_specialist':
        return 'Operations Specialist';
      case 'founder_c_suite':
      default:
        return 'Founder & Executive';
    }
  }
}
