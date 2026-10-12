import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/config/feature_flags.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../charts/presentation/screens/chart_testbed_screen.dart';
import '../../../curhat_ai/presentation/screens/curhat_ai_screen.dart';
import '../../../events/presentation/screens/events_list_screen.dart';
import '../../../knowledge/presentation/screens/knowledge_screen.dart';
import '../../../lessons/presentation/screens/lessons_list_screen.dart';
import '../../../walkie_talkie/presentation/walkie_talkie_screen.dart';

class BentoFeaturesGrid extends ConsumerWidget {
  final VoidCallback? onAiTap;
  final VoidCallback? onWikiTap;
  final VoidCallback? onAgendaTap;
  final VoidCallback? onP3kTap;
  final VoidCallback? onToolsTap;

  const BentoFeaturesGrid({
    super.key,
    this.onAiTap,
    this.onWikiTap,
    this.onAgendaTap,
    this.onP3kTap,
    this.onToolsTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.earthTree;
    final flags = ref.watch(featureFlagsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Fitur Ekosistem",
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Text(
                "${flags.enabledCount} Modul Aktif",
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.meadowCanopy,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Bento 1: Teman Curhat AI (Full Width)
          if (flags.enableCurhatAi) ...[
            GestureDetector(
              onTap: onAiTap ?? () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => CurhatAiScreen(
                      onBack: () => Navigator.of(context).pop(),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.celestialSkyContainer.withValues(
                          alpha: context.isDark ? 0.3 : 0.7),
                      colors.surfaceContainerLow,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.tactileBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: colors.celestialSky,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: iconoir.ChatBubble(
                          width: 24,
                          height: 24,
                          color: colors.onCelestialSky,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              Text(
                                "Teman Curhat AI",
                                style: context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colors.textPrimary,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: colors.meadowCanopy.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "On-Device",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: colors.meadowCanopy,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Konsultasi tazkiyah privat tanpa kebocoran data kalbu",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: colors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Bento 2: Walkie-Talkie Ruang Qalbu
          if (flags.enableWalkieTalkie) ...[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => WalkieTalkieScreen(
                      onBack: () => Navigator.of(context).pop(),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.tactileBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colors.ancientBarkContainer.withValues(
                            alpha: context.isDark ? 0.3 : 0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: iconoir.Microphone(
                          width: 20,
                          height: 20,
                          color: colors.ancientBark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Walkie-Talkie Ruang Qalbu",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            "Push-to-talk suara thuma'ninah untuk melepas penat emosi",
                            style: TextStyle(
                              fontSize: 11,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 12, color: colors.textSecondary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Grid 2 Kolom untuk Modul Khazanah & Agenda
          if (flags.enableKnowledgeWiki || flags.enableEvents)
            Row(
              children: [
                if (flags.enableKnowledgeWiki)
                  Expanded(
                    child: GestureDetector(
                      onTap: onWikiTap ?? () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => KnowledgeScreen(
                              onBack: () => Navigator.of(context).pop(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colors.tactileBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: colors.meadowCanopy.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: iconoir.Book(
                                  width: 18,
                                  height: 18,
                                  color: colors.meadowCanopy,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Khazanah Fitrah",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Wiki & Vector Search",
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (flags.enableKnowledgeWiki && flags.enableEvents)
                  const SizedBox(width: 10),
                if (flags.enableEvents)
                  Expanded(
                    child: GestureDetector(
                      onTap: onAgendaTap ?? () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => EventsListScreen(
                              onBack: () => Navigator.of(context).pop(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colors.tactileBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: colors.celestialSky.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: iconoir.Calendar(
                                  width: 18,
                                  height: 18,
                                  color: colors.celestialSky,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Agenda Majelis",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Jadwal Kajian Akbar",
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 10),

          // Grid 2 Kolom untuk Micro-Learning & Lab Chart
          if (flags.enablePrimerLessons || flags.enableChartsTestbed)
            Row(
              children: [
                if (flags.enablePrimerLessons)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => LessonsListScreen(
                              onBack: () => Navigator.of(context).pop(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colors.tactileBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: colors.ancientBark.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: iconoir.Bookmark(
                                  width: 18,
                                  height: 18,
                                  color: colors.ancientBark,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Micro-Learning",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Primer Quiz Adab",
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (flags.enablePrimerLessons && flags.enableChartsTestbed)
                  const SizedBox(width: 10),
                if (flags.enableChartsTestbed)
                  Expanded(
                    child: GestureDetector(
                      onTap: onToolsTap ?? () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ChartTestbedScreen(
                              onBack: () => Navigator.of(context).pop(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colors.tactileBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: colors.meadowCanopy.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: iconoir.GraphUp(
                                  width: 18,
                                  height: 18,
                                  color: colors.meadowCanopy,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Lab Visual Mizan",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Timbangan & TB40",
                              style: TextStyle(
                                fontSize: 11,
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
