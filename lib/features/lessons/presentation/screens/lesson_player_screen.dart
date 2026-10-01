import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/color_palette.dart';
import '../../../core/widgets/segmented_progress_bar.dart';
import '../../data/models/lesson_models.dart';
import '../controllers/lesson_player_controller.dart';
import '../widgets/cards/fill_in_blank_step_view.dart';
import '../widgets/cards/multiple_choice_step_view.dart';
import '../widgets/cards/swipe_poll_step_view.dart';
import '../widgets/cards/text_step_view.dart';

class LessonPlayerScreen extends ConsumerWidget {
  final Lesson lesson;

  const LessonPlayerScreen({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lessonPlayerControllerProvider(lesson));
    final controller = ref.read(lessonPlayerControllerProvider(lesson).notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currentCard = state.currentCard;
    final totalSteps = lesson.cards.length;
    final currentStep = state.currentStepIndex + 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            SegmentedProgressBar(
              totalSteps: totalSteps,
              currentStep: currentStep,
              activeColor: AppColors.brandPrimary,
              inactiveColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
            const SizedBox(height: 6),
            Text(
              'Step $currentStep of $totalSteps',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Dynamic Interactive Card Renderer
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: KeyedSubtree(
                  key: ValueKey(currentCard.id),
                  child: _buildCardView(context, currentCard, state, controller),
                ),
              ),
            ),

            // Fixed Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: _buildActionButton(context, state, controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardView(
    BuildContext context,
    LessonStepCard card,
    LessonPlayerState state,
    LessonPlayerController controller,
  ) {
    if (card is TextInsightCard) {
      return TextStepView(card: card);
    } else if (card is MultipleChoiceCard) {
      return MultipleChoiceStepView(
        card: card,
        selectedIndex: state.selectedOptionIndex,
        isAnswerChecked: state.isAnswerChecked,
        onSelectOption: (idx) => controller.selectMultipleChoiceOption(idx),
      );
    } else if (card is SwipePollCard) {
      return SwipePollStepView(
        card: card,
        choice: state.pollChoice,
        onChoose: (agree) => controller.choosePoll(agree),
      );
    } else if (card is FillInBlankCard) {
      return FillInBlankStepView(
        card: card,
        selectedWord: state.selectedBlankWord,
        isAnswerChecked: state.isAnswerChecked,
        onSelectWord: (word) => controller.selectBlankWord(word),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildActionButton(
    BuildContext context,
    LessonPlayerState state,
    LessonPlayerController controller,
  ) {
    final card = state.currentCard;

    // Multiple Choice
    if (card is MultipleChoiceCard) {
      if (!state.isAnswerChecked) {
        final canCheck = state.selectedOptionIndex != null;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: canCheck ? AppColors.brandPrimary : Colors.grey.shade400,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: canCheck ? () => controller.checkAnswer() : null,
          child: const Text('Check My Answer', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        );
      }
    }

    // Fill In Blank
    if (card is FillInBlankCard) {
      if (!state.isAnswerChecked) {
        final canCheck = state.selectedBlankWord != null;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: canCheck ? AppColors.brandPrimary : Colors.grey.shade400,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          onPressed: canCheck ? () => controller.checkAnswer() : null,
          child: const Text('Check Placement', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        );
      }
    }

    // Swipe Poll
    if (card is SwipePollCard && state.pollChoice == null) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: null,
        child: const Text('Select Agree or Disagree to Continue'),
      );
    }

    // Default Continue / Finish Button
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: state.isLastStep ? AppColors.success : AppColors.brandPrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      onPressed: () async {
        final isFinished = await controller.proceedNext();
        if (isFinished && context.mounted) {
          _showCompletionDialog(context);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.isLastStep ? 'Complete Deck' : 'Continue',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Icon(
            state.isLastStep ? Icons.verified_rounded : Icons.arrow_forward_rounded,
            size: 18,
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: AppColors.success,
                  size: 34,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Lesson Mastered!',
                style: Theme.of(ctx).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'You’ve completed "${lesson.title}" and locked in key executive mental models.',
                textAlign: TextAlign.center,
                style: Theme.of(ctx).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandPrimary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(); // Close bottom sheet
                    context.pop(); // Return from player
                  },
                  child: const Text(
                    'Return to Lessons',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
