import 'package:flutter/material.dart';
import '../../../../app/theme/color_palette.dart';
import '../../../data/models/lesson_models.dart';

class SwipePollStepView extends StatelessWidget {
  final SwipePollCard card;
  final bool? choice;
  final ValueChanged<bool> onChoose;

  const SwipePollStepView({
    super.key,
    required this.card,
    required this.choice,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.domainStrategy.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'INTUITION CHECK',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: AppColors.domainStrategy,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            card.stepHeadline,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 24),

          // The Statement Card
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.help_center_outlined,
                  size: 32,
                  color: AppColors.brandGold,
                ),
                const SizedBox(height: 16),
                Text(
                  card.statement,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 24),

                // Choice Buttons: Agree / Disagree
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: choice == true
                              ? AppColors.brandPrimary
                              : (isDark ? AppColors.darkSurfaceElevated : Colors.grey.shade200),
                          foregroundColor: choice == true
                              ? Colors.white
                              : (isDark ? Colors.white : Colors.black87),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.thumb_up_rounded, size: 16),
                        label: const Text('Yes / Agree'),
                        onPressed: () => onChoose(true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: choice == false
                              ? AppColors.brandGold
                              : (isDark ? AppColors.darkSurfaceElevated : Colors.grey.shade200),
                          foregroundColor: choice == false
                              ? Colors.black
                              : (isDark ? Colors.white : Colors.black87),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.thumb_down_rounded, size: 16),
                        label: const Text('No / Disagree'),
                        onPressed: () => onChoose(false),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Feedback Box
          if (choice != null) ...[
            const SizedBox(height: 24),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1.0,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceElevated
                      : AppColors.lightSurfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.brandGold.withOpacity(0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.lightbulb_rounded,
                          size: 18,
                          color: AppColors.brandGold,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'EXPERT PERSPECTIVE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: AppColors.brandGold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      choice == true ? card.agreeFeedback : card.disagreeFeedback,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.55,
                            fontSize: 15,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
