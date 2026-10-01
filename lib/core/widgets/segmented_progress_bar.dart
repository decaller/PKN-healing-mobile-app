import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';

/// A segmented progress bar replicating Google Primer's snackable lesson header.
/// Shows total steps as distinct blocks that illuminate as the user progresses.
class SegmentedProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final Color activeColor;
  final Color inactiveColor;

  const SegmentedProgressBar({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor = AppColors.brandPrimary,
    this.inactiveColor = AppColors.darkBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 3.0,
              right: index == totalSteps - 1 ? 0 : 3.0,
            ),
            height: 4.5,
            decoration: BoxDecoration(
              color: isCompleted
                  ? activeColor
                  : (isCurrent
                      ? activeColor.withOpacity(0.85)
                      : inactiveColor),
              borderRadius: BorderRadius.circular(4),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: activeColor.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
