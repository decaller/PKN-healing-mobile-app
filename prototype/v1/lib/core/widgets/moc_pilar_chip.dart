import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/pkn_tokens.dart';

enum MocPilar {
  p1('P1', 'Mulai di Sini', AppColors.pilarMulai, Icons.explore_rounded),
  p2('P2', 'Tumbuh Kembang', AppColors.pilarTumbuh, Icons.child_care_rounded),
  p3('P3', 'Bakat TB-40', AppColors.pilarBakat, Icons.psychology_rounded),
  p4('P4', 'Praktik Keluarga', AppColors.pilarKeluarga, Icons.family_restroom_rounded),
  p5('P5', 'Lembaga & Guru', AppColors.pilarLembaga, Icons.school_rounded),
  p6('P6', 'Khazanah Dalil', AppColors.pilarDalil, Icons.auto_stories_rounded);

  final String code;
  final String label;
  final Color color;
  final IconData icon;

  const MocPilar(this.code, this.label, this.color, this.icon);

  static MocPilar? fromText(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('p1') || lower.contains('mulai')) return MocPilar.p1;
    if (lower.contains('p2') || lower.contains('tumbuh') || lower.contains('fase')) return MocPilar.p2;
    if (lower.contains('p3') || lower.contains('bakat') || lower.contains('tb-40')) return MocPilar.p3;
    if (lower.contains('p4') || lower.contains('keluarga') || lower.contains('parenting')) return MocPilar.p4;
    if (lower.contains('p5') || lower.contains('lembaga') || lower.contains('guru')) return MocPilar.p5;
    if (lower.contains('p6') || lower.contains('dalil') || lower.contains('hadits')) return MocPilar.p6;
    return null;
  }
}

/// 6 Pilar MOC Interactive Chip for taxonomy navigation
class MocPilarChip extends StatelessWidget {
  final MocPilar pilar;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;

  const MocPilarChip({
    super.key,
    required this.pilar,
    this.isSelected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = pilar.color;

    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Pilar MOC ${pilar.code}: ${pilar.label}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onSelected != null ? () => onSelected!(!isSelected) : null,
          borderRadius: PknRadius.roundedPill,
          child: AnimatedContainer(
            duration: PknDurations.quick,
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withValues(alpha: isDark ? 0.28 : 0.16)
                  : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
              borderRadius: PknRadius.roundedPill,
              border: Border.all(
                color: isSelected
                    ? color
                    : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                width: isSelected ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  pilar.icon,
                  size: 16,
                  color: isSelected
                      ? color
                      : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                ),
                const SizedBox(width: 6),
                Text(
                  pilar.code,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isSelected ? color : null,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(width: 4),
                Text(
                  pilar.label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? (isDark ? Colors.white : AppColors.lightTextPrimary)
                            : (isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary),
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
