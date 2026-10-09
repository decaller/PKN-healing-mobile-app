import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/app/theme/pkn_tokens.dart';
import 'package:pkn_microlearning_app/core/widgets/adab_badge.dart';
import 'package:pkn_microlearning_app/core/widgets/pkn_button.dart';
import 'package:pkn_microlearning_app/features/lessons/data/models/lesson_models.dart';

/// Screen 4: Adab Growth & Reflection Completion Report
/// Directly adapted from Figma template "14 Screen Education Apps.fig" (Node 0:379 - Test Report)
/// Replaces toxic grade percentages with qualitative Fitrah & Adab growth indicators.
class AdabGrowthReportScreen extends StatelessWidget {
  final Lesson lesson;

  const AdabGrowthReportScreen({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Laporan Pertumbuhan Adab',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(PknSpacing.lg),
                children: [
                  // Donut Visual Card (Derived from Node 0:379 Group 1154)
                  Container(
                    padding: const EdgeInsets.all(PknSpacing.xl),
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
                      children: [
                        Text(
                          lesson.domain,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: AppColors.getDomainColor(lesson.domain),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          lesson.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                height: 1.25,
                              ),
                        ),
                        const SizedBox(height: 24),

                        // Donut Progress Indicator
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 140,
                              height: 140,
                              child: CircularProgressIndicator(
                                value: 1.0,
                                strokeWidth: 14,
                                backgroundColor: isDark
                                    ? AppColors.darkSurfaceElevated
                                    : AppColors.lightSurfaceElevated,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.brandPrimary,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.verified_rounded,
                                  color: AppColors.brandGold,
                                  size: 32,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Tuntas',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.brandPrimary,
                                      ),
                                ),
                                Text(
                                  '5/5 Langkah',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Adab Indicators Legend
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AdabBadge(
                              level: AdabRubricLevel.bk,
                              showLabel: true,
                            ),
                            SizedBox(width: 8),
                            AdabBadge(
                              level: AdabRubricLevel.mm,
                              showLabel: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: PknSpacing.xl),

                  // Metrics Summary Table (Derived from Node 0:379 Content rows)
                  Container(
                    padding: const EdgeInsets.all(PknSpacing.lg),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      borderRadius: PknRadius.roundedCard,
                      border: Border.all(
                        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildMetricRow(
                          context,
                          'Total Langkah Terrefleksi',
                          '5 Langkah',
                          Icons.checklist_rounded,
                        ),
                        const Divider(height: 24),
                        _buildMetricRow(
                          context,
                          'Estimasi Waktu Resap',
                          '${lesson.estimatedMinutes} Menit',
                          Icons.schedule_rounded,
                        ),
                        const Divider(height: 24),
                        _buildMetricRow(
                          context,
                          'Pilar Navigasi MOC',
                          lesson.domain,
                          Icons.category_rounded,
                          valueColor: AppColors.getDomainColor(lesson.domain),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: PknSpacing.xl),

                  // Action Checklist for the Real World (Recency Rule)
                  Text(
                    'RESEP AKSI HARI INI',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildActionChecklistCard(
                    context,
                    isDark,
                    'Tatap mata anak dengan senyuman tulus sebelum mulai berdialog',
                  ),
                  const SizedBox(height: 8),
                  _buildActionChecklistCard(
                    context,
                    isDark,
                    'Bila anak membangkang, tahan lisan 90 detik dari ancaman dan bentakan',
                  ),
                  const SizedBox(height: 8),
                  _buildActionChecklistCard(
                    context,
                    isDark,
                    'Hadirkan pelukan hangat penenang jiwa (Bahasa Hati Nabawiyah)',
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Bottom Action Bar (48dp height compliant)
            Container(
              padding: const EdgeInsets.all(PknSpacing.lg),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PknButton.primary(
                    width: double.infinity,
                    height: 52,
                    text: 'Terapkan Hari Ini',
                    icon: Icons.check_circle_rounded,
                    onPressed: () {
                      context.pop(); // Return to previous screen
                    },
                  ),
                  const SizedBox(height: 8),
                  PknButton.outline(
                    width: double.infinity,
                    height: 48,
                    text: 'Kembali ke Katalog Modul',
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.brandGold),
        const SizedBox(width: 10),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
        ),
      ],
    );
  }

  Widget _buildActionChecklistCard(BuildContext context, bool isDark, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
        borderRadius: PknRadius.roundedMd,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.task_alt_rounded,
            color: AppColors.adabBK,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
