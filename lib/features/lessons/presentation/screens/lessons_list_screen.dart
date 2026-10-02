import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pkn_microlearning_app/app/router/route_paths.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/app/theme/pkn_tokens.dart';
import 'package:pkn_microlearning_app/core/storage/storage_service.dart';
import 'package:pkn_microlearning_app/core/widgets/adab_badge.dart';
import 'package:pkn_microlearning_app/core/widgets/moc_pilar_chip.dart';
import 'package:pkn_microlearning_app/features/lessons/data/mock_lessons.dart';

class LessonsListScreen extends ConsumerWidget {
  const LessonsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lessons = MockLessonsRepository.lessons;
    final storageService = ref.watch(storageServiceProvider);
    final completedIds = storageService.getCompletedLessonIds();

    return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary.withValues(alpha: 0.15),
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
                  'MODUL PRIMER 5 MENIT',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 1.0,
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
              final pilar = MocPilar.fromText(lesson.domain) ?? MocPilar.p4;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  borderRadius: PknRadius.roundedCard,
                  border: Border.all(
                    color: isCompleted
                        ? AppColors.adabBK.withValues(alpha: 0.4)
                        : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    width: 1.2,
                  ),
                  boxShadow: PknElevation.cardShadow,
                ),
                child: InkWell(
                  onTap: () {
                    context.push(RoutePaths.lessonDetails(lesson.lessonId));
                  },
                  borderRadius: PknRadius.roundedCard,
                  child: Padding(
                    padding: const EdgeInsets.all(PknSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MocPilarChip(
                              pilar: pilar,
                              isSelected: true,
                            ),
                            Row(
                              children: [
                                if (isCompleted) ...[
                                  const AdabBadge(
                                    level: AdabRubricLevel.bk,
                                    showLabel: true,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Icon(
                                  Icons.timer_outlined,
                                  size: 14,
                                  color: isDark
                                      ? AppColors.darkTextMuted
                                      : AppColors.lightTextMuted,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${lesson.estimatedMinutes} menit',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          lesson.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                height: 1.3,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          lesson.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                height: 1.45,
                              ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${lesson.cards.length} langkah interaktif',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.darkTextMuted
                                    : AppColors.lightTextMuted,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  isCompleted ? 'Pelajari Ulang' : 'Mulai Deck',
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
