import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

enum HighlightColorCategory { celestial, meadow, ancient }

class HighlightItem {
  final String title;
  final String categoryTag;
  final String metaLabel;
  final String ctaLabel;
  final String imageUrl;
  final HighlightColorCategory colorCategory;

  const HighlightItem({
    required this.title,
    required this.categoryTag,
    required this.metaLabel,
    required this.ctaLabel,
    required this.imageUrl,
    this.colorCategory = HighlightColorCategory.celestial,
  });

  Color getTagColor(EarthTreeColors colors) {
    switch (colorCategory) {
      case HighlightColorCategory.celestial:
        return colors.celestialSkyContainer;
      case HighlightColorCategory.meadow:
        return colors.meadowCanopyContainer;
      case HighlightColorCategory.ancient:
        return colors.ancientBarkContainer;
    }
  }

  Color getTagTextColor(EarthTreeColors colors) {
    switch (colorCategory) {
      case HighlightColorCategory.celestial:
        return colors.onCelestialSkyContainer;
      case HighlightColorCategory.meadow:
        return colors.onMeadowCanopyContainer;
      case HighlightColorCategory.ancient:
        return colors.onAncientBarkContainer;
    }
  }
}

class HighlightsCarousel extends StatelessWidget {
  final ValueChanged<HighlightItem>? onItemTap;

  const HighlightsCarousel({super.key, this.onItemTap});

  static final List<HighlightItem> _items = [
    const HighlightItem(
      title: "Daurah Akbar Parenting Nabawiyah: Menempa Adab Usia Tamyiz",
      categoryTag: "Event Terdekat • 18 Okt",
      metaLabel: "Masjid Agung Nurul Izzah",
      ctaLabel: "Daftar",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuDerIK-TwdjaC0cfTYckjElE4Sj4wtOKKMbkMd47cpXtPmru_heOMk53Q2oyEeGLuOi4j4fDgALAeYWE0hWZMUUDql-2AcuD8j13Kvx3vLsJ-zX3JJpIp1JLmC_rWTbdCkDg_WWoyYiq1C0ef69lupJD2Vv5vc7T-UvAQe6h3DMQMG1FJqfIkhevkLCep985g8ftVC-VMcXLoxmx7qn5JViXGcY0_nGs1i0QYr1Rfp2ruRS9wuP4WkcMA",
      colorCategory: HighlightColorCategory.celestial,
    ),
    const HighlightItem(
      title: "Mengenal Syakilah TB-40: Membaca Cetak Biru Bakat Bawaan Anak",
      categoryTag: "Khazanah Pilihan • 5 Menit",
      metaLabel: "Ust. Harry Santosa",
      ctaLabel: "Baca",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuD27LoCC5UVlAWXQO5BMLJih2h7jOy9NPek4akW3QWR3Yp7_xE6vl9aCEABvyteX1kT3wLp_Oza9pp-nhv9kwhy_5fa5x01cMWHruGfp8GUqL9cS1UpHCfqcBdK9jCec9r74TgBulCnw-S9pp-Up6nqtR6geYSBzkVonYvxNph2cpT4Vas5IWo-2R4-tOJJqU94MXFEggFFmBBmnJuLwmyJcQ6JMFLD1jxdPpN7Uhd2tSjl_VbKh01eEw",
      colorCategory: HighlightColorCategory.meadow,
    ),
    const HighlightItem(
      title: "Webinar Interaktif: Menata Jiwa & Thuma'ninah Ayah Bunda",
      categoryTag: "Live Zoom • Malam Ahad",
      metaLabel: "1,240 Terdaftar",
      ctaLabel: "Ikuti",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAGXdc1elsOdW8HkNqNIHtsVO0Y16GPpXfQuhX2vKP7sKlJY4-omahQyabzby_YGtFwC3igCt_cB7qBQWGEjv6vc-hmuYOMhryo4P-1Qi5x3DKF_4pCQ8ZhrEJ0ZnndrvgvEuODwdIP5yUSRaJ5DUmDfKBjaLVNzUl0ZS5oIYkCc6qPAUsConU1J5I-z6f6l_JcmO193b9pF8jVfTn3l7fAIqtEt61H34S-K_L2-LHyFOZdGS-3e2JxUw",
      colorCategory: HighlightColorCategory.ancient,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Highlights",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              Text(
                "Lihat Semua",
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.celestialSky,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 285,
          child: ListView.separated(
            key: const PageStorageKey<String>('highlights_carousel_v4'),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = _items[index];
              return _buildCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, HighlightItem item) {
    final colors = context.earthTree;

    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        width: 310,
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.tactileBorder),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A2C2825),
              offset: Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar 16:9 Banner dengan Shader Gradient
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: colors.surfaceContainerHigh,
                      child: Center(
                        child: iconoir.Page(
                          width: 32,
                          height: 32,
                          color: colors.textMuted,
                        ),
                      ),
                    ),
                  ),
                  // Gradient Vignette
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          colors.textPrimary.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  // Kategori Chip
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: item.getTagColor(colors),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.categoryTag,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: item.getTagTextColor(colors),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Teks Konten & Aksi
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            iconoir.Pin(
                              width: 14,
                              height: 14,
                              color: colors.ancientBark,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item.metaLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: colors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.ctaLabel,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: colors.celestialSky,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
