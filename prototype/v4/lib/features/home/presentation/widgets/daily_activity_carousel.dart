import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class DailyActivityCarousel extends StatelessWidget {
  const DailyActivityCarousel({super.key});

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
                "Aktivitas",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              Text(
                "Langkah Harian",
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 195,
          child: ListView(
            key: const PageStorageKey<String>('daily_activity_carousel_v4'),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              // Card 1: Modul Lanjutan
              _buildProgressCard(
                context,
                tag: "Modul Lanjutan",
                progressText: "65% Selesai",
                title: "Tamyiz 7–10 Thn: Fondasi Sholat Khusyu'",
                progress: 0.65,
                btnLabel: "Lanjutkan",
                btnColor: colors.celestialSky,
                btnTextColor: colors.onCelestialSky,
                icon: iconoir.Play(width: 14, height: 14, color: colors.onCelestialSky),
              ),
              const SizedBox(width: 12),

              // Card 2: Latihan Suara Rendah
              _buildSimpleTaskCard(
                context,
                tag: "3 Menit",
                tagColor: colors.meadowCanopyContainer,
                tagTextColor: colors.onMeadowCanopyContainer,
                title: "Latihan Resonansi Suara Rendah",
                desc: "Latih wibawa qalbiyah saat ananda mulai meninggikan volume nada.",
                btnLabel: "Mulai Latihan",
                btnColor: colors.meadowCanopy,
                btnTextColor: colors.onMeadowCanopy,
                headerIcon: iconoir.Microphone(width: 18, height: 18, color: colors.meadowCanopy),
              ),
              const SizedBox(width: 12),

              // Card 3: Muhasabah
              _buildSimpleTaskCard(
                context,
                tag: "Hening Qalbu",
                tagColor: colors.ancientBarkContainer,
                tagTextColor: colors.onAncientBarkContainer,
                title: "Muhasabah: Refleksi Pengasuhan",
                desc: "5 pertanyaan tenang menjelang tidur untuk menjernihkan cinta.",
                btnLabel: "Buka Jurnal",
                btnColor: colors.ancientBark,
                btnTextColor: colors.onAncientBark,
                headerIcon: iconoir.HalfMoon(width: 18, height: 18, color: colors.ancientBark),
              ),
              const SizedBox(width: 12),

              // Card 4: Kisah RPG
              _buildSimpleTaskCard(
                context,
                tag: "RPG Ep. 2",
                tagColor: colors.surfaceContainerHigh,
                tagTextColor: colors.textSecondary,
                title: "Kisah RPG: Pintu Maghrib Zaid",
                desc: "Simulasi dialog interaktif menghadapi ketakutan anak pada petang.",
                btnLabel: "Mainkan Peran",
                btnColor: colors.celestialSky,
                btnTextColor: colors.onCelestialSky,
                headerIcon: iconoir.Gamepad(width: 18, height: 18, color: colors.celestialSky),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard(
    BuildContext context, {
    required String tag,
    required String progressText,
    required String title,
    required double progress,
    required String btnLabel,
    required Color btnColor,
    required Color btnTextColor,
    required Widget icon,
  }) {
    final colors = context.earthTree;

    return Container(
      width: 250,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      tag.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.celestialSky,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    progressText,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: colors.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(colors.celestialSky),
                ),
              ),
            ],
          ),
          Material(
            color: btnColor,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      btnLabel,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: btnTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    icon,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleTaskCard(
    BuildContext context, {
    required String tag,
    required Color tagColor,
    required Color tagTextColor,
    required String title,
    required String desc,
    required String btnLabel,
    required Color btnColor,
    required Color btnTextColor,
    required Widget headerIcon,
  }) {
    final colors = context.earthTree;

    return Container(
      width: 250,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: tagColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tag,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: tagTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  headerIcon,
                ],
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
              const SizedBox(height: 4),
              Text(
                desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Material(
            color: btnColor,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  btnLabel,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: btnTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
