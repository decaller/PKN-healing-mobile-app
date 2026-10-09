import 'package:flutter/material.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/features/lessons/data/models/lesson_models.dart';

class FillInBlankStepView extends StatelessWidget {
  final FillInBlankCard card;
  final String? selectedWord;
  final bool isSubmitted;
  final ValueChanged<String> onSelectWord;

  const FillInBlankStepView({
    super.key,
    required this.card,
    required this.selectedWord,
    required this.isSubmitted,
    required this.onSelectWord,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCorrect = selectedWord?.trim().toLowerCase() ==
        card.blankExpected.trim().toLowerCase();

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
              'LATIHAN REKONSTRUKSI FITRAH',
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
          const SizedBox(height: 24),

          // Sentence with slot
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1.2,
              ),
            ),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.8,
                    ),
                children: [
                  TextSpan(text: '${card.sentenceBefore} '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: selectedWord == null
                            ? (isDark
                                ? AppColors.darkSurfaceElevated
                                : Colors.grey.shade200)
                            : (isSubmitted
                                ? (isCorrect
                                    ? AppColors.success.withValues(alpha: 0.2)
                                    : AppColors.error.withValues(alpha: 0.2))
                                : AppColors.brandPrimary.withValues(alpha: 0.15)),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedWord == null
                              ? AppColors.brandGold.withValues(alpha: 0.6)
                              : (isSubmitted
                                  ? (isCorrect ? AppColors.success : AppColors.error)
                                  : AppColors.brandPrimary),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        selectedWord ?? ' [ Ketuk Kata di Bawah ] ',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: selectedWord == null
                              ? AppColors.brandGold
                              : (isSubmitted
                                  ? (isCorrect ? AppColors.success : AppColors.error)
                                  : (isDark ? Colors.white : Colors.black87)),
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: card.sentenceAfter),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),
          Text(
            'PILIH KATA DARI BANK KATA',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
            ),
          ),
          const SizedBox(height: 12),

          // Word Bank Chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: card.wordBank.map((word) {
              final isChosen = selectedWord == word;
              return ChoiceChip(
                label: Text(word),
                selected: isChosen,
                onSelected: isSubmitted ? null : (_) => onSelectWord(word),
                selectedColor: AppColors.brandPrimary.withValues(alpha: 0.2),
                labelStyle: TextStyle(
                  fontWeight: isChosen ? FontWeight.w700 : FontWeight.w500,
                  color: isChosen
                      ? AppColors.brandPrimary
                      : (isDark ? Colors.white : Colors.black87),
                ),
              );
            }).toList(),
          ),

          // Feedback explanation
          if (isSubmitted) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkSurfaceElevated
                    : AppColors.lightSurfaceElevated,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isCorrect
                      ? AppColors.success.withValues(alpha: 0.4)
                      : AppColors.error.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isCorrect
                            ? Icons.check_circle_outline_rounded
                            : Icons.cancel_outlined,
                        size: 18,
                        color: isCorrect ? AppColors.success : AppColors.error,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isCorrect ? 'Tepat Sekali!' : 'Perlu Diteliti Kembali',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isCorrect ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card.explanation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
