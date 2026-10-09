import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/pkn_tokens.dart';

enum AdabRubricLevel {
  bt('BT', 'Belum Terlihat', AppColors.adabBT),
  mt('MT', 'Mulai Terlihat', AppColors.adabMT),
  bk('BK', 'Berkembang Konsisten', AppColors.adabBK),
  mm('MM', 'Membudaya Mandiri', AppColors.adabMM);

  final String code;
  final String label;
  final Color color;

  const AdabRubricLevel(this.code, this.label, this.color);

  static AdabRubricLevel fromCode(String code) {
    switch (code.toUpperCase()) {
      case 'BT':
        return AdabRubricLevel.bt;
      case 'MT':
        return AdabRubricLevel.mt;
      case 'BK':
        return AdabRubricLevel.bk;
      case 'MM':
        return AdabRubricLevel.mm;
      default:
        return AdabRubricLevel.bk;
    }
  }
}

/// Qualitative Adab Badge (BT, MT, BK, MM)
/// Replaces toxic numerical ranking with fitrah character growth observation.
class AdabBadge extends StatelessWidget {
  final AdabRubricLevel level;
  final bool showLabel;
  final VoidCallback? onTap;

  const AdabBadge({
    super.key,
    required this.level,
    this.showLabel = true,
    this.onTap,
  });

  factory AdabBadge.fromCode(
    String code, {
    Key? key,
    bool showLabel = true,
    VoidCallback? onTap,
  }) {
    return AdabBadge(
      key: key,
      level: AdabRubricLevel.fromCode(code),
      showLabel: showLabel,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = level.color;

    return Semantics(
      label: 'Indikator Adab: ${level.code} - ${level.label}',
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        borderRadius: PknRadius.roundedPill,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: showLabel ? PknSpacing.sm : PknSpacing.xs,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.20 : 0.12),
            borderRadius: PknRadius.roundedPill,
            border: Border.all(
              color: color.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                level.code,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              if (showLabel) ...[
                const SizedBox(width: 4),
                Text(
                  level.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
