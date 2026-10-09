import 'package:flutter/material.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/features/lessons/data/models/lesson_models.dart';

class MultipleChoiceStepView extends StatelessWidget {
  final MultipleChoiceCard card;
  final int? selectedIndex;
  final bool isSubmitted;
  final ValueChanged<int> onSelectOption;

  const MultipleChoiceStepView({
    super.key,
    required this.card,
    required this.selectedIndex,
    required this.isSubmitted,
    required this.onSelectOption,
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
              color: AppColors.brandPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'STUDI KASUS PRAKTIK LAPANGAN',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: AppColors.brandPrimary,
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
          const SizedBox(height: 12),
          Text(
            card.question,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 24),

          // Options List (Directly modeled on Education Apps Test node 0:429)
          ...List.generate(card.options.length, (index) {
            final optionText = card.options[index];
            final isSelected = selectedIndex == index;
            final isCorrect = index == card.correctIndex;

            Color borderColor;
            Color bgColor;
            Widget? trailingIcon;

            if (isSubmitted) {
              if (isCorrect) {
                borderColor = AppColors.adabBK;
                bgColor = AppColors.adabBK.withValues(alpha: 0.15);
                trailingIcon = const Icon(Icons.check_circle_rounded, color: AppColors.adabBK);
              } else if (isSelected && !isCorrect) {
                borderColor = AppColors.error;
                bgColor = AppColors.error.withValues(alpha: 0.15);
                trailingIcon = const Icon(Icons.cancel_rounded, color: AppColors.error);
              } else {
                borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
                bgColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
              }
            } else {
              if (isSelected) {
                borderColor = AppColors.brandPrimary;
                bgColor = AppColors.brandPrimary.withValues(alpha: 0.12);
                trailingIcon = const Icon(Icons.radio_button_checked, color: AppColors.brandPrimary);
              } else {
                borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
                bgColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
                trailingIcon = Icon(
                  Icons.radio_button_off,
                  color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                );
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: isSubmitted ? null : () => onSelectOption(index),
                borderRadius: BorderRadius.circular(14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderColor, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          optionText,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                        ),
                      ),
                      if (trailingIcon != null) ...[
                        const SizedBox(width: 8),
                        trailingIcon,
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),

          // Post-Verification Explanation
          if (isSubmitted) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceElevated
                    : AppColors.lightSurfaceElevated,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        selectedIndex == card.correctIndex
                            ? Icons.check_circle_outline_rounded
                            : Icons.info_outline_rounded,
                        size: 18,
                        color: selectedIndex == card.correctIndex
                            ? AppColors.adabBK
                            : AppColors.brandGold,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        selectedIndex == card.correctIndex
                            ? 'Jawaban Tepat!'
                            : 'Hikmah & Penjelasan',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: selectedIndex == card.correctIndex
                              ? AppColors.adabBK
                              : AppColors.brandGold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card.explanation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
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
