import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/pkn_tokens.dart';
import '../../app/theme/typography.dart';

/// Arabic Dalil Card conforming to PKN Turats & WCAG 2.1 AA specifications:
/// - Native RTL layout with Amiri font (>= 22sp, line height 1.85)
/// - Authentic Indonesian translation
/// - Progressive disclosure for Takhrij & Sanad details
class ArabicDalilCard extends StatefulWidget {
  final String arabicText;
  final String translation;
  final String sourceName;
  final String? narrator;
  final String? hadithGrade;
  final String? syarahHikmah;

  const ArabicDalilCard({
    super.key,
    required this.arabicText,
    required this.translation,
    required this.sourceName,
    this.narrator,
    this.hadithGrade,
    this.syarahHikmah,
  });

  @override
  State<ArabicDalilCard> createState() => _ArabicDalilCardState();
}

class _ArabicDalilCardState extends State<ArabicDalilCard> {
  bool _isTakhrijExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: PknRadius.roundedCard,
        border: Border.all(
          color: AppColors.brandGold.withValues(alpha: isDark ? 0.35 : 0.25),
          width: 1,
        ),
        boxShadow: PknElevation.cardShadow,
      ),
      padding: const EdgeInsets.all(PknSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Dalil Source & Grade Badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.brandGold.withValues(alpha: 0.15),
                  borderRadius: PknRadius.roundedSm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.menu_book_rounded,
                      size: 14,
                      color: AppColors.brandGold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.sourceName,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.brandGold,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (widget.hadithGrade != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.adabBK.withValues(alpha: 0.15),
                    borderRadius: PknRadius.roundedPill,
                    border: Border.all(
                      color: AppColors.adabBK.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    widget.hadithGrade!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.adabBK,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: PknSpacing.md),

          // Arabic Matan Text (Native RTL, Amiri >= 22sp)
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              widget.arabicText,
              textAlign: TextAlign.right,
              style: AppTypography.arabicText(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                height: 1.85,
              ),
            ),
          ),
          const SizedBox(height: PknSpacing.md),

          // Divider with subtle gold accent
          Divider(
            color: AppColors.brandGold.withValues(alpha: 0.2),
            thickness: 1,
          ),
          const SizedBox(height: PknSpacing.sm),

          // Indonesian Translation
          Text(
            widget.translation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  height: 1.55,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
          ),

          // Progressive Disclosure: Collapsible Takhrij / Syarah
          if (widget.syarahHikmah != null || widget.narrator != null) ...[
            const SizedBox(height: PknSpacing.sm),
            InkWell(
              onTap: () => setState(() => _isTakhrijExpanded = !_isTakhrijExpanded),
              borderRadius: PknRadius.roundedSm,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(
                      _isTakhrijExpanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      size: 18,
                      color: AppColors.brandGold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _isTakhrijExpanded ? 'Tutup Takhrij' : 'Lihat Takhrij & Hikmah',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.brandGold,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isTakhrijExpanded) ...[
              const SizedBox(height: PknSpacing.xs),
              Container(
                padding: const EdgeInsets.all(PknSpacing.sm),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceElevated
                      : AppColors.lightSurfaceElevated,
                  borderRadius: PknRadius.roundedSm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.narrator != null)
                      Text(
                        'Sanad / Perawi: ${widget.narrator}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    if (widget.syarahHikmah != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.syarahHikmah!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              height: 1.45,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
