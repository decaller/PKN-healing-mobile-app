import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../../crisis/presentation/widgets/p3k_crisis_modal.dart';
import '../../../renungan/presentation/screens/mode_renungan_screen.dart';
import '../widgets/milestone1_adab_checklist.dart';
import '../widgets/milestone1_agenda_highlight.dart';
import '../widgets/milestone1_pustaka_carousel.dart';
import '../widgets/milestone1_utility_grid.dart';
import '../widgets/nature_hero_header.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onSwitchTheme;
  final VoidCallback? onOpenEvents;
  final VoidCallback? onOpenPustaka;
  final void Function(int tabIndex)? onOpenMitra;
  final VoidCallback? onOpenProfile;

  const HomeScreen({
    super.key,
    this.onSwitchTheme,
    this.onOpenEvents,
    this.onOpenPustaka,
    this.onOpenMitra,
    this.onOpenProfile,
  });

  void _openRenungan(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ModeRenunganScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  void _openP3k(BuildContext context) {
    P3kCrisisModal.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                // 1. Top 1/3 Nature Tree Hero Header
                NatureHeroHeader(
                  onOpenRenungan: () => _openRenungan(context),
                  onToggleTheme: onSwitchTheme,
                  onAvatarTap: onOpenProfile,
                ),

                // 2. Overlapping Content Sheet (-mt-6 equivalent)
                Transform.translate(
                  offset: const Offset(0, -22),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search Bar Ticker
                        _buildSearchTicker(colors),

                        const SizedBox(height: 16),

                        // P3K Krisis Genting Urgent Card (< 10 Detik SOP)
                        _buildP3kUrgentCard(context, colors),

                        const SizedBox(height: 18),

                        // Amalan Adab Hari Ini (Interactive Checklist)
                        const Milestone1AdabChecklist(),

                        const SizedBox(height: 20),

                        // Highlight 2 Agenda Terdekat (Atas-Bawah)
                        Milestone1AgendaHighlight(
                          onSeeAll: onOpenEvents,
                        ),

                        const SizedBox(height: 20),

                        // Pustaka & Buku Pilihan (Horizontal Carousel)
                        Milestone1PustakaCarousel(
                          onSeeAll: onOpenPustaka,
                        ),

                        const SizedBox(height: 22),

                        // Grid Direktori Layanan & Utilitas Milestone 1 (6 Tile)
                        Milestone1UtilityGrid(
                          onOpenEvents: onOpenEvents,
                          onOpenPustaka: onOpenPustaka,
                          onOpenTokoh: () => onOpenMitra?.call(0),
                          onOpenLembaga: () => onOpenMitra?.call(1),
                          onOpenKemitraan: () => onOpenMitra?.call(2),
                          onOpenP3k: () => _openP3k(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTicker(EarthTreeColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.tactileBorder),
      ),
      child: Row(
        children: [
          iconoir.Search(
            width: 18,
            height: 18,
            color: colors.textMuted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Cari agenda daurah, buku pustaka, atau artikel...",
              style: TextStyle(
                fontSize: 12.5,
                color: colors.textMuted,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "PKN 1.0",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildP3kUrgentCard(BuildContext context, EarthTreeColors colors) {
    return InkWell(
      onTap: () => _openP3k(context),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.errorContainer.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: colors.error.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: iconoir.WarningTriangle(
                width: 22,
                height: 22,
                color: colors.error,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "P3K Krisis Genting",
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: colors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.error,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "< 10 Detik",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "SOP Anak Mengamuk & Ortu Burnout (Maqashid: Hifzhun Nafs)",
                    style: TextStyle(
                      fontSize: 11,
                      color: colors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: colors.error,
            ),
          ],
        ),
      ),
    );
  }
}
