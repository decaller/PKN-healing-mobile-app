import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/app/theme/pkn_tokens.dart';
import 'package:pkn_microlearning_app/core/widgets/arabic_dalil_card.dart';
import 'package:pkn_microlearning_app/core/widgets/moc_pilar_chip.dart';
import 'package:pkn_microlearning_app/core/widgets/pkn_callout_box.dart';
import 'package:pkn_microlearning_app/features/feed/data/models/idea_card.dart';

class IdeaCardWidget extends StatefulWidget {
  final IdeaCard card;
  final VoidCallback onBookmarkToggle;

  const IdeaCardWidget({
    super.key,
    required this.card,
    required this.onBookmarkToggle,
  });

  @override
  State<IdeaCardWidget> createState() => _IdeaCardWidgetState();
}

class _IdeaCardWidgetState extends State<IdeaCardWidget> {
  bool _isDetailsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final card = widget.card;
    final pilarMoc = MocPilar.fromText(card.pilarMoc ?? card.category) ?? MocPilar.p4;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: PknRadius.roundedCard,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: PknElevation.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar: Pilar MOC & Read Time
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MocPilarChip(
                  pilar: pilarMoc,
                  isSelected: true,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${card.readTimeMinutes} menit baca',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Title & Source Citation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              card.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Text(
              card.sourceName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.brandGold,
                  ),
            ),
          ),

          // Lead TL;DR 10-Second Callout (Primacy Rule - Placed Above the Fold)
          if (card.leadTlDr != null && card.leadTlDr!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: PknCalloutBox.tldr(
                content: card.leadTlDr!,
              ),
            ),

          // Two-Column Comparative Card (🔴 Kebiasaan Umum vs ✅ Pendekatan PKN)
          if (card.comparisons != null && card.comparisons!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...card.comparisons!.map((comp) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurfaceElevated
                            : AppColors.lightSurfaceElevated,
                        borderRadius: PknRadius.roundedMd,
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                          width: 0.8,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('🔴 ', style: TextStyle(fontSize: 12)),
                              Expanded(
                                child: Text(
                                  comp.commonPractice,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.error,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('✅ ', style: TextStyle(fontSize: 12)),
                              Expanded(
                                child: Text(
                                  comp.pknApproach,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.adabBK,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

          // Sharia Limits & Child Safety Guardrail (Callout Warning)
          if (card.syariGuardrails != null && card.syariGuardrails!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: PknCalloutBox.warning(
                content: card.syariGuardrails!,
              ),
            ),

          // Expandable Detailed Section: Core Thesis, Dalil, & Sirah Case Study
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InkWell(
              onTap: () => setState(() => _isDetailsExpanded = !_isDetailsExpanded),
              borderRadius: PknRadius.roundedMd,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceElevated
                      : AppColors.lightSurfaceElevated,
                  borderRadius: PknRadius.roundedMd,
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    width: 0.8,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 16,
                          color: AppColors.brandGold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isDetailsExpanded
                              ? 'Tutup Ulasan Mendalam'
                              : 'Baca Ulasan Dalil & Teladan Sirah',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      _isDetailsExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: AppColors.brandGold,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Expanded Content
          if (_isDetailsExpanded) ...[
            const SizedBox(height: 14),
            // Core Thesis
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkSurfaceElevated.withValues(alpha: 0.5)
                      : AppColors.lightSurfaceElevated,
                  borderRadius: PknRadius.roundedMd,
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    width: 0.8,
                  ),
                ),
                child: MarkdownBody(
                  data: card.coreThesis,
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                    p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.55,
                        ),
                    strong: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                  ),
                ),
              ),
            ),

            // Do'a Refleksi Berharakat
            if (card.doaOrMuhasabah != null && card.doaOrMuhasabah!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: ArabicDalilCard(
                  arabicText: card.doaOrMuhasabah!.split('\n').first,
                  translation: card.doaOrMuhasabah!.split('\n').length > 1
                      ? card.doaOrMuhasabah!.split('\n').sublist(1).join('\n')
                      : '',
                  sourceName: 'Do\'a Penenteram Jiwa Keluarga',
                  narrator: 'Al-Qur\'an Al-Karim',
                ),
              ),

            // Real-World Example / Teladan Sirah
            if (card.realWorldExample.isNotEmpty) ...[
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.brandGold.withValues(alpha: isDark ? 0.12 : 0.08),
                    borderRadius: PknRadius.roundedMd,
                    border: Border.all(
                      color: AppColors.brandGold.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.auto_stories_rounded, size: 16, color: AppColors.brandGold),
                          SizedBox(width: 6),
                          Text(
                            'TELADAN SIRAH NABAWIYAH',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                              color: AppColors.brandGold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        card.realWorldExample,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Action Checklist
            if (card.actionChecklist != null && card.actionChecklist!.isNotEmpty) ...[
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DAFTAR TILIK TINDAKAN KONKRET',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...card.actionChecklist!.map((act) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_box_outlined,
                              size: 16,
                              color: AppColors.adabBK,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                act,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      height: 1.4,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],

          const SizedBox(height: 10),

          // Bottom Action Bar: Tags, Bookmark & Share
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tags
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: card.tags.map((tag) {
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurfaceElevated
                                : AppColors.lightSurfaceElevated,
                            borderRadius: PknRadius.roundedPill,
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Bookmark & Share Actions
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        card.isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: card.isBookmarked
                            ? AppColors.brandGold
                            : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                      ),
                      onPressed: () {
                        widget.onBookmarkToggle();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              card.isBookmarked
                                  ? 'Dihapus dari simpanan materi'
                                  : 'Disimpan ke pustaka tarbiyah Anda',
                            ),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tautan materi berhasil disalin!'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
