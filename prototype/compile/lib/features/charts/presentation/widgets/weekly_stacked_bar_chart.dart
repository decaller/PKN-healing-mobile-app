import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class WeeklyStackedBarChart extends StatelessWidget {
  final bool isInteractive;

  const WeeklyStackedBarChart({
    super.key,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    // Data sepekan (Sn, Sl, Rb, Km, Jm, Sb, Ah)
    // Nilai: [Diri (secondary), Hati (primary), Ilmu (tertiaryContainer)]
    final weeklyData = [
      [38.0, 24.0, 12.0], // Sn
      [44.0, 28.0, 10.0], // Sl
      [48.0, 32.0, 14.0], // Rb
      [36.0, 30.0, 8.0],  // Km
      [52.0, 36.0, 16.0], // Jm
      [30.0, 48.0, 20.0], // Sb
      [32.0, 54.0, 18.0], // Ah
    ];

    const days = ['Sn', 'Sl', 'Rb', 'Km', 'Jm', 'Sb', 'Ah'];

    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 110,
          barTouchData: BarTouchData(
            enabled: isInteractive,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => colors.surfaceContainerHighest,
              tooltipBorderRadius: BorderRadius.circular(8),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final day = days[groupIndex];
                final d = weeklyData[groupIndex];
                return BarTooltipItem(
                  '$day: ${(d[0] + d[1] + d[2]).round()} Ikhtiar\n',
                  TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: colors.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Diri: ${d[0].round()} • Hati: ${d[1].round()} • Ilmu: ${d[2].round()}',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 26,
                interval: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 10,
                      color: colors.textSecondary,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < days.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        days[index],
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: colors.textSecondary,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 35,
            getDrawingHorizontalLine: (value) => FlLine(
              color: colors.tactileBorder,
              strokeWidth: 0.8,
              dashArray: [4, 4],
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(weeklyData.length, (i) {
            final d = weeklyData[i];
            final total = d[0] + d[1] + d[2];
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: total,
                  width: 18,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                  rodStackItems: [
                    BarChartRodStackItem(0, d[0], colors.meadowCanopy),
                    BarChartRodStackItem(d[0], d[0] + d[1], colors.celestialSky),
                    BarChartRodStackItem(d[0] + d[1], total, colors.ancientBark),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
