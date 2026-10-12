import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../../crisis/presentation/screens/p3k_crisis_screen.dart';

class InstrumentItem {
  final String title;
  final String subtitle;
  final Widget icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback? onTap;

  const InstrumentItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.onTap,
  });
}

class P3kInstrumentGrid extends StatelessWidget {
  final ValueChanged<String>? onInstrumentTap;

  const P3kInstrumentGrid({super.key, this.onInstrumentTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    final instruments = [
      InstrumentItem(
        title: "P3K Tantrum",
        subtitle: "SOP 10 Detik",
        icon: iconoir.Flash(width: 20, height: 20, color: colors.error),
        iconBg: colors.errorContainer,
        iconColor: colors.error,
        onTap: () {
          if (onInstrumentTap != null) {
            onInstrumentTap!("P3K Tantrum");
          } else {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const P3kCrisisScreen()),
            );
          }
        },
      ),
      InstrumentItem(
        title: "Mizan Fitrah",
        subtitle: "Kalkulator",
        icon: iconoir.WeightAlt(width: 20, height: 20, color: colors.meadowCanopy),
        iconBg: colors.meadowCanopyContainer,
        iconColor: colors.meadowCanopy,
        onTap: () => onInstrumentTap?.call("Mizan Fitrah"),
      ),
      InstrumentItem(
        title: "Rapor TB-40",
        subtitle: "Analisis Bakat",
        icon: iconoir.GraphUp(width: 20, height: 20, color: colors.celestialSky),
        iconBg: colors.celestialSkyContainer,
        iconColor: colors.celestialSky,
        onTap: () => onInstrumentTap?.call("Rapor TB-40"),
      ),
      InstrumentItem(
        title: "Deteksi Suara",
        subtitle: "Cek Intonasi",
        icon: iconoir.Voice(width: 20, height: 20, color: colors.celestialSky),
        iconBg: colors.celestialSky.withValues(alpha: 0.15),
        iconColor: colors.celestialSky,
        onTap: () => onInstrumentTap?.call("Deteksi Suara"),
      ),
      InstrumentItem(
        title: "Doa Penenang",
        subtitle: "Hisnul Muslim",
        icon: iconoir.Heart(width: 20, height: 20, color: colors.ancientBark),
        iconBg: colors.ancientBarkContainer,
        iconColor: colors.ancientBark,
        onTap: () => onInstrumentTap?.call("Doa Penenang"),
      ),
      InstrumentItem(
        title: "Kamus Adab",
        subtitle: "Indeks Istilah",
        icon: iconoir.Compass(width: 20, height: 20, color: colors.textSecondary),
        iconBg: colors.surfaceContainerHighest,
        iconColor: colors.textSecondary,
        onTap: () => onInstrumentTap?.call("Kamus Adab"),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Instrumen Praktis",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              Text(
                "Atur Pintasan",
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.celestialSky,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: instruments.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = instruments[index];
              return _buildToolCard(context, item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, InstrumentItem item) {
    final colors = context.earthTree;

    return Material(
      color: colors.surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: item.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.tactileBorder),
            boxShadow: const [
              BoxShadow(
                color: Color(0x062C2825),
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.iconBg,
                ),
                alignment: Alignment.center,
                child: item.icon,
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: colors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
