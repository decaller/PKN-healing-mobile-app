import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/route_paths.dart';
import '../../../app/theme/color_palette.dart';
import '../../../core/widgets/segmented_progress_bar.dart';
import '../../data/jtbd_data.dart';
import '../controllers/onboarding_controller.dart';

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

            // Question Header
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  const SizedBox(height: 12),
                  Text(
                    currentQ.question,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentQ.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),

                  // Option Cards
                  ...currentQ.options.map((option) {
                    final isSelected = selectedOptionId == option.id;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () {
                          controller.selectOption(currentQ.id, option.id);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark
                                    ? AppColors.brandGold.withOpacity(0.12)
                                    : AppColors.brandGold.withOpacity(0.08))
                                : (isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.brandGold
                                  : (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder),
                              width: isSelected ? 1.8 : 1.0,
                            ),
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
                              const SizedBox(width: 16),
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
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      option.description,
                                      style: Theme.of(context).textTheme.bodySmall,
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

            // Continue Button Dock
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOptionId != null
                        ? AppColors.brandGold
                        : (isDark ? AppColors.darkSurfaceElevated : Colors.grey.shade300),
                    foregroundColor: selectedOptionId != null
                        ? Colors.black
                        : Colors.grey,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: selectedOptionId == null
                      ? null
                      : () {
                          final isLastStep = controller.nextStep();
                          if (isLastStep) {
                            context.push(RoutePaths.activationalInsight);
                          }
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.currentStepIndex == questions.length - 1
                            ? 'Generate My Profile'
                            : 'Continue',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
