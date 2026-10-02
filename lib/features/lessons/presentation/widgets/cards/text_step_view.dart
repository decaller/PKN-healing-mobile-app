import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/core/widgets/takeaway_badge.dart';
import 'package:pkn_microlearning_app/features/lessons/data/models/lesson_models.dart';

class TextStepView extends StatelessWidget {
  final TextInsightCard card;

  const TextStepView({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card.stepHeadline,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 20),
          MarkdownBody(
            data: card.contentMarkdown,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.65,
                    fontSize: 17,
                  ),
              strong: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
              listBullet: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.brandGold,
                    fontSize: 17,
                  ),
            ),
          ),
          if (card.keyTakeaway != null) ...[
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceElevated
                    : AppColors.lightSurfaceElevated,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.brandGold.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TakeawayBadge(label: 'KEY TAKEAWAY'),
                  const SizedBox(height: 10),
                  Text(
                    card.keyTakeaway!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
