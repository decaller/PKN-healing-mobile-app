import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class BentoFeaturesGrid extends StatelessWidget {
  final VoidCallback? onAiTap;
  final VoidCallback? onWikiTap;
  final VoidCallback? onAgendaTap;
  final VoidCallback? onCeritaTap;
  final VoidCallback? onToolsTap;

  const BentoFeaturesGrid({
    super.key,
    this.onAiTap,
    this.onWikiTap,
    this.onAgendaTap,
    this.onCeritaTap,
    this.onToolsTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fitur Utama",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              Flexible(
                child: Text(
                  "Ekosistem Pengasuhan",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Bento 1: AI Sanctuary (Span 2 / Full Width)
          GestureDetector(
            onTap: onAiTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.celestialSkyContainer.withValues(alpha: context.isDark ? 0.3 : 0.7),
                    colors.surfaceContainerLow,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.tactileBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A2C2825),
                    offset: Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: colors.celestialSky,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const iconoir.Brain(width: 14, height: 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              "AI Sanctuary",
                              style: context.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.celestialSky.withValues(alpha: 0.15),
                        ),
                        alignment: Alignment.center,
                        child: iconoir.Voice(
                          width: 22,
                          height: 22,
                          color: colors.celestialSky,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Teman Curhat AI",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Ruang dialog batin tanpa rasa bersalah. Dilengkapi panduan fitrah 24/7.",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.meadowCanopy,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "Siap mendengar kapan saja",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Mulai Sesi",
                            style: context.textTheme.labelMedium?.copyWith(
                              color: colors.celestialSky,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          iconoir.NavArrowRight(
                            width: 14,
                            height: 14,
                            color: colors.celestialSky,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // 2x2 Grid untuk 4 Fitur Lainnya
          Row(
            children: [
              // Bento 2: Wiki PKN
              Expanded(
                child: _buildBentoCard(
                  context,
                  title: "Wiki PKN",
                  desc: "6 Pilar Fitrah & Glosarium Syakilah lengkap.",
                  actionLabel: "Eksplorasi",
                  accentColor: colors.meadowCanopy,
                  icon: iconoir.Book(width: 20, height: 20, color: colors.meadowCanopy),
                  onTap: onWikiTap,
                ),
              ),
              const SizedBox(width: 10),
              // Bento 3: Agenda Acara
              Expanded(
                child: _buildBentoCard(
                  context,
                  title: "Agenda Acara",
                  desc: "Daurah tatap muka, webinar & tiket pass.",
                  actionLabel: "Jadwal",
                  accentColor: colors.ancientBark,
                  icon: iconoir.Calendar(width: 20, height: 20, color: colors.ancientBark),
                  onTap: onAgendaTap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Bento 4: Cerita Interaktif
              Expanded(
                child: _buildBentoCard(
                  context,
                  title: "Cerita Interaktif",
                  desc: "Living rehearsal tanpa frustasi 'game over'.",
                  actionLabel: "Mainkan",
                  accentColor: colors.celestialSky,
                  icon: iconoir.Gamepad(width: 20, height: 20, color: colors.celestialSky),
                  onTap: onCeritaTap,
                ),
              ),
              const SizedBox(width: 10),
              // Bento 5: Tools & P3K
              Expanded(
                child: _buildBentoCard(
                  context,
                  title: "Tools & P3K",
                  desc: "Tafsir Bakat & Protokol Darurat 10 Detik.",
                  actionLabel: "Buka Alat",
                  accentColor: colors.error,
                  icon: iconoir.Flash(width: 20, height: 20, color: colors.error),
                  onTap: onToolsTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBentoCard(
    BuildContext context, {
    required String title,
    required String desc,
    required String actionLabel,
    required Color accentColor,
    required Widget icon,
    VoidCallback? onTap,
  }) {
    final colors = context.earthTree;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.tactileBorder),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A2C2825),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: accentColor.withValues(alpha: 0.15),
                  ),
                  alignment: Alignment.center,
                  child: icon,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  actionLabel,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 2),
                iconoir.NavArrowRight(width: 12, height: 12, color: accentColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
