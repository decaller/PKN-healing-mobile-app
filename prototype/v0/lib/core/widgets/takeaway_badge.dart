import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';

class TakeawayBadge extends StatelessWidget {
  final String label;

  const TakeawayBadge({
    super.key,
    this.label = 'CORE THESIS',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.brandGold.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.brandGold.withValues(alpha: 0.4),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            size: 13,
            color: AppColors.brandGold,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: AppColors.brandGold,
            ),
          ),
        ],
      ),
    );
  }
}
