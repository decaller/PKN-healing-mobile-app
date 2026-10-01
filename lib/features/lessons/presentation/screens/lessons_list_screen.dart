import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/route_paths.dart';
import '../../../app/theme/color_palette.dart';
import '../../../core/storage/storage_service.dart';
import '../../../core/widgets/domain_badge.dart';
import '../../data/mock_lessons.dart';

class LessonsListScreen extends ConsumerWidget {
  const LessonsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final storageService = ref.watch(storageServiceProvider);
    final completedIds = storageService.getCompletedLessonIds();
    final lessons = MockLessonsRepository.lessons;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.brandPrimary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.play_lesson_rounded,
                color: AppColors.brandPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'PRIMER DECKS',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          final isCompleted = completedIds.contains(lesson.lessonId);

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isCompleted
                    ? AppColors.success.withOpacity(0.4)
                    : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                context.push(RoutePaths.lessonDetails(lesson.lessonId));
              },
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DomainBadge(domain: lesson.domain),
                        Row(
                          children: [
                            if (isCompleted) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.check_circle_rounded, size: 12, color: AppColors.success),
                                    SizedBox(width: 4),
                                    Text(
                                      'COMPLETED',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.success,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Icon(
                              Icons.timer_outlined,
                              size: 14,
                              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${lesson.estimatedMinutes} min',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      lesson.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${lesson.cards.length} interactive steps',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              isCompleted ? 'Review Deck' : 'Start Lesson',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandPrimary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: AppColors.brandPrimary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
