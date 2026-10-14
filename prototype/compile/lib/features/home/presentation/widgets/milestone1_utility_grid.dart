import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class Milestone1UtilityGrid extends StatelessWidget {
  final VoidCallback? onOpenEvents;
  final VoidCallback? onOpenPustaka;
  final VoidCallback? onOpenTokoh;
  final VoidCallback? onOpenLembaga;
  final VoidCallback? onOpenKemitraan;
  final VoidCallback? onOpenP3k;

  const Milestone1UtilityGrid({
    super.key,
    this.onOpenEvents,
    this.onOpenPustaka,
    this.onOpenTokoh,
    this.onOpenLembaga,
    this.onOpenKemitraan,
    this.onOpenP3k,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    final tiles = [
      _TileData(
        title: "Agenda Daurah",
        subtitle: "Jadwal Majelis",
        tag: "Event",
        color: const Color(0xFF235347),
        icon: (c) => iconoir.Calendar(width: 20, height: 20, color: c),
        onTap: onOpenEvents,
      ),
      _TileData(
        title: "Pustaka Buku",
        subtitle: "Karya Asatidzah",
        tag: "Buku",
        color: const Color(0xFF006194),
        icon: (c) => iconoir.Book(width: 20, height: 20, color: c),
        onTap: onOpenPustaka,
      ),
      _TileData(
        title: "Tokoh Pakar",
        subtitle: "4 Asatidzah PKN",
        tag: "Figur",
        color: const Color(0xFFD97706),
        icon: (c) => iconoir.User(width: 20, height: 20, color: c),
        onTap: onOpenTokoh,
      ),
      _TileData(
        title: "Lembaga Mitra",
        subtitle: "6 Sekolah & Kuttab",
        tag: "Jaringan",
        color: const Color(0xFF4F46E5),
        icon: (c) => iconoir.Building(width: 20, height: 20, color: c),
        onTap: onOpenLembaga,
      ),
      _TileData(
        title: "Kemitraan",
        subtitle: "4 Layanan Resmi",
        tag: "Mitra",
        color: const Color(0xFF7C3AED),
        icon: (c) => iconoir.Community(width: 20, height: 20, color: c),
        onTap: onOpenKemitraan,
      ),
      _TileData(
        title: "P3K Jiwa",
        subtitle: "SOP < 10 Detik",
        tag: "Darurat",
        color: const Color(0xFFBA1A1A),
        icon: (c) => iconoir.WarningTriangle(width: 20, height: 20, color: c),
        onTap: onOpenP3k,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const iconoir.Dashboard(
              width: 18,
              height: 18,
              color: Color(0xFF235347),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Direktori Layanan & Pustaka",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.1,
          ),
          itemBuilder: (context, index) {
            final t = tiles[index];
            return InkWell(
              onTap: t.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.tactileBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: t.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: t.icon(t.color),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.title,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            t.subtitle,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: colors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TileData {
  final String title;
  final String subtitle;
  final String tag;
  final Color color;
  final Widget Function(Color) icon;
  final VoidCallback? onTap;

  const _TileData({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.color,
    required this.icon,
    this.onTap,
  });
}
