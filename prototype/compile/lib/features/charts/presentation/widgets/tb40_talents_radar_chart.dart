import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class Tb40TalentsRadarChart extends StatelessWidget {
  const Tb40TalentsRadarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    const titles = [
      'Al-Qiyadah',
      'Al-Fashahah',
      'Al-Idarah',
      'Al-Fikriyyah',
      'Al-Ihsan',
      'Asy-Syaja\'ah',
    ];

    return AspectRatio(
      aspectRatio: 1.3,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          radarBorderData: BorderSide(color: colors.tactileBorder, width: 1.2),
          gridBorderData: BorderSide(
            color: colors.tactileBorder.withValues(alpha: 0.6),
            width: 0.8,
          ),
          tickBorderData: BorderSide(color: colors.tactileBorder.withValues(alpha: 0.4)),
          ticksTextStyle: TextStyle(
            color: colors.textSecondary,
            fontSize: 9,
            fontFamily: 'Plus Jakarta Sans',
          ),
          tickCount: 3,
          getTitle: (index, angle) {
            if (index >= 0 && index < titles.length) {
              return RadarChartTitle(
                text: titles[index],
                angle: 0,
                positionPercentageOffset: 0.18,
              );
            }
            return const RadarChartTitle(text: '');
          },
          titleTextStyle: TextStyle(
            color: colors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            fontFamily: 'Plus Jakarta Sans',
          ),
          dataSets: [
            RadarDataSet(
              fillColor: colors.celestialSky.withValues(alpha: 0.22),
              borderColor: colors.celestialSky,
              borderWidth: 2,
              entryRadius: 3.5,
              dataEntries: const [
                RadarEntry(value: 82), // Al-Qiyadah
                RadarEntry(value: 94), // Al-Fashahah (Tinggi: Kelembutan)
                RadarEntry(value: 70), // Al-Idarah
                RadarEntry(value: 88), // Al-Fikriyyah
                RadarEntry(value: 90), // Al-Ihsan
                RadarEntry(value: 76), // Asy-Syaja'ah
              ],
            ),
          ],
        ),
      ),
    );
  }
}
