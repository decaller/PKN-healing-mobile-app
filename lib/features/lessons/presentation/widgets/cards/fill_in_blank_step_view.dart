import 'package:flutter/material.dart';
import '../../../../app/theme/color_palette.dart';
import '../../../data/models/lesson_models.dart';

class FillInBlankStepView extends StatelessWidget {
  final FillInBlankCard card;
  final String? selectedWord;
  final bool isAnswerChecked;
  final ValueChanged<String> onSelectWord;

  const FillInBlankStepView({
    super.key,
    required this.card,
    required this.selectedWord,
    required this.isAnswerChecked,
    required this.onSelectWord,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCorrect = isAnswerChecked &&
        selectedWord?.trim().toLowerCase() ==
            card.blankExpected.trim().toLowerCase();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.domainFinance.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'FILL IN THE FRAMEWORK',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: AppColors.domainFinance,
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
                            : (isAnswerChecked
                                ? (isCorrect
                                    ? AppColors.success.withOpacity(0.2)
                                    : AppColors.error.withOpacity(0.2))
                                : AppColors.brandPrimary.withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedWord == null
                              ? AppColors.brandGold.withOpacity(0.6)
                              : (isAnswerChecked
                                  ? (isCorrect ? AppColors.success : AppColors.error)
                                  : AppColors.brandPrimary),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        selectedWord ?? ' [ Tap Word Below ] ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: selectedWord == null
                              ? AppColors.brandGold
                              : (isAnswerChecked
                                  ? (isCorrect ? AppColors.success : AppColors.error)
                                  : AppColors.brandPrimary),
                        ),
                      ),
                    ),
                  ),
                  TextSpan(text: ' ${card.sentenceAfter}'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          Text(
            'WORD BANK',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
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
                onSelected: isAnswerChecked ? null : (_) => onSelectWord(word),
                selectedColor: AppColors.brandPrimary.withOpacity(0.2),
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
          if (isAnswerChecked) ...[
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
                      ? AppColors.success.withOpacity(0.4)
                      : AppColors.error.withOpacity(0.4),
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
                        isCorrect ? 'Correct Placement!' : 'Not quite right',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: isCorrect ? AppColors.success : AppColors.error,
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
