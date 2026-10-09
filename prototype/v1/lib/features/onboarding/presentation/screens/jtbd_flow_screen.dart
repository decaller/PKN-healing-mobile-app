import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pkn_microlearning_app/app/router/route_paths.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/app/theme/pkn_tokens.dart';
import 'package:pkn_microlearning_app/core/widgets/pkn_button.dart';
import 'package:pkn_microlearning_app/core/widgets/segmented_progress_bar.dart';
import 'package:pkn_microlearning_app/features/onboarding/data/jtbd_data.dart';
import 'package:pkn_microlearning_app/features/onboarding/presentation/controllers/onboarding_controller.dart';

class JTBDFlowScreen extends ConsumerWidget {
  const JTBDFlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final questions = JTBDRepository.questions;
    final currentQ = questions[state.currentStepIndex];
    final selectedOptionId = state.answers[currentQ.id];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: state.currentStepIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                onPressed: () => controller.previousStep(),
              )
            : null,
        title: Text(
          currentQ.stepTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Segmented Step Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: SegmentedProgressBar(
                totalSteps: questions.length,
                currentStep: state.currentStepIndex + 1,
                activeColor: AppColors.brandGold,
                inactiveColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              ),
            ),

            // Question Header & Option Cards
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(PknSpacing.lg),
                children: [
                  const SizedBox(height: 12),
                  Text(
                    currentQ.question,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentQ.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                  ),
                  const SizedBox(height: 24),

                  // Option Cards (Modeled on Education Apps Level Screen)
                  ...currentQ.options.map((option) {
                    final isSelected = selectedOptionId == option.id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () {
                          controller.selectOption(currentQ.id, option.id);
                        },
                        borderRadius: PknRadius.roundedCard,
                        child: AnimatedContainer(
                          duration: PknDurations.normal,
                          padding: const EdgeInsets.all(PknSpacing.md),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark
                                    ? AppColors.brandGold.withValues(alpha: 0.14)
                                    : AppColors.brandGold.withValues(alpha: 0.08))
                                : (isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface),
                            borderRadius: PknRadius.roundedCard,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.brandGold
                                  : (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder),
                              width: isSelected ? 1.8 : 1.0,
                            ),
                            boxShadow: isSelected ? PknElevation.cardShadow : null,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? AppColors.darkSurfaceElevated
                                      : AppColors.lightSurfaceElevated,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  option.iconEmoji,
                                  style: const TextStyle(fontSize: 22),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option.title,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            color: isSelected
                                                ? (isDark ? Colors.white : Colors.black87)
                                                : null,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      option.description,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            height: 1.4,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                isSelected
                                    ? Icons.check_circle_rounded
                                    : Icons.circle_outlined,
                                color: isSelected
                                    ? AppColors.brandGold
                                    : (isDark
                                        ? AppColors.darkTextMuted
                                        : AppColors.lightTextMuted),
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Continue Button Dock with WCAG 48dp Minimum Touch Target
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: PknSpacing.lg,
                vertical: PknSpacing.md,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
              ),
              child: PknButton.primary(
                width: double.infinity,
                height: 52,
                text: state.currentStepIndex < questions.length - 1
                    ? 'Lanjutkan'
                    : 'Lihat Trajektori Saya',
                icon: Icons.arrow_forward_rounded,
                onPressed: selectedOptionId == null
                    ? null
                    : () {
                        final isFinished = controller.nextStep();
                        if (isFinished) {
                          context.go(RoutePaths.activationalInsight);
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
