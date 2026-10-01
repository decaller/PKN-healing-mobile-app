import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';

class DomainBadge extends StatelessWidget {
  final String domain;
  final bool isSelected;
  final VoidCallback? onTap;

  const DomainBadge({
    super.key,
    required this.domain,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getDomainColor(domain);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? color : color.withOpacity(isDark ? 0.18 : 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : color.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.white : color,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            domain.toUpperCase(),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: isSelected
                  ? Colors.white
                  : (isDark ? Colors.white70 : color.withOpacity(0.95)),
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: badge,
      );
    }
    return badge;
  }
}
