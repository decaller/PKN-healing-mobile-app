import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../widgets/mizan_fitrah_balance_scale.dart';
import '../widgets/multi_segment_progress_pill.dart';
import '../widgets/tb40_talents_radar_chart.dart';
import '../widgets/weekly_stacked_bar_chart.dart';

class ChartTestbedScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const ChartTestbedScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface.withValues(alpha: 0.95),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: onBack != null
            ? IconButton(
                icon: iconoir.ArrowLeft(width: 22, height: 22, color: colors.textPrimary),
                onPressed: onBack,
              )
            : null,
        title: Text(
          'Lab Evaluasi Chart PKN',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Callout
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.tactileBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colors.celestialSky.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: iconoir.StatsReport(width: 18, height: 18, color: colors.celestialSky),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BENCHMARK KELAYAKAN CHART FLUTTER',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            color: colors.celestialSky,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Uji Coba Visualisasi Data Manhaj Nabawiyah',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Membandingkan pustaka fl_chart dan CustomPainter untuk memastikan kepatuhan Calm Tech: bebas stres numerik, ramah baterai, dan kontras WCAG 2.2 AAA.',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            color: colors.textSecondary,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Case 1: Stacked Bar Activity Chart
            _buildChartSection(
              title: 'Case 1: Aktivitas Sepekan (Stacked Bar)',
              subtitle: 'Implementasi: fl_chart.BarChart (Rod Stack Items)',
              badgeText: 'fl_chart',
              badgeColor: colors.meadowCanopy,
              colors: colors,
              description:
                  'Menampilkan agregasi 3 pilar amalan harian (Diri [Pine Green], Hati [Ocean Blue], Ilmu [Terracotta]). Touch tooltip memberikan umpan balik lembut tanpa pop-up yang menyilaukan.',
              chartWidget: const WeeklyStackedBarChart(),
            ),
            const SizedBox(height: 20),

            // Case 2: Multi-tier Stacked Progress Pill
            _buildChartSection(
              title: 'Case 2: Ketercapaian Amanah (Stacked Horizon)',
              subtitle: 'Implementasi: Custom Lightweight Flex Row',
              badgeText: 'Zero Dependency',
              badgeColor: colors.ancientBark,
              colors: colors,
              description:
                  'Visualisasi linear ringkas pengganti pie chart konvensional. Menampilkan perbandingan porsi usaha orang tua secara proporsional.',
              chartWidget: const MultiSegmentProgressPill(),
            ),
            const SizedBox(height: 20),

            // Case 3: Radar Chart TB-40
            _buildChartSection(
              title: 'Case 3: Matriks 6 Rumpun Bakat TB-40 (Radar / Spider)',
              subtitle: 'Implementasi: fl_chart.RadarChart',
              badgeText: 'fl_chart',
              badgeColor: colors.celestialSky,
              colors: colors,
              description:
                  'Memetakan 6 rumpun bakat (Al-Qiyadah, Al-Fashahah, Al-Idarah, Al-Fikriyyah, Al-Ihsan, Asy-Syaja\'ah). Garis polygon lembut menghindari kesan vonis mutlak, sesuai prinsip bahwa bakat adalah kecenderungan alami (Jibilliy).',
              chartWidget: const Tb40TalentsRadarChart(),
            ),
            const SizedBox(height: 20),

            // Case 4: Mizan Fitrah Dynamic Balance Scale
            _buildChartSection(
              title: 'Case 4: Timbangan Resonansi Jiwa (Mizan Fitrah)',
              subtitle: 'Implementasi: Flutter CustomPainter + Spring Animation',
              badgeText: 'CustomPainter',
              badgeColor: colors.nafsLawwamah,
              colors: colors,
              description:
                  'Visualisasi timbangan non-kartesian berosilasi interaktif. Menunjukkan keselarasan frekuensi nada suara pengasuh: Thuma\'ninah (Kiri) vs Reaktif/Amarah (Kanan). Ketuk timbangan untuk mencoba osilasi elastis!',
              chartWidget: const MizanFitrahBalanceScale(),
            ),
            const SizedBox(height: 24),

            // Evaluasi Rekomendasi Kasus PKN
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.tactileBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C2C2825),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      iconoir.CheckCircle(width: 20, height: 20, color: colors.meadowCanopy),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Rekomendasi Arsitektural Chart PKN',
                          style: TextStyle(
                            fontFamily: 'Merriweather',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildRecommendationItem(
                    title: '1. fl_chart untuk Data Tren & Multidimensi:',
                    desc: 'Sangat direkomendasikan untuk Stacked Bar sepekan dan Radar Bakat TB-40. Mendukung touch event mulus, performa 60-120fps, dan isolasi memori rendah.',
                    colors: colors,
                  ),
                  const SizedBox(height: 8),
                  _buildRecommendationItem(
                    title: '2. CustomPainter untuk Metafora Jiwa (Mizan Scale):',
                    desc: 'Untuk konsep timbangan mizan atau mandala nafs, CustomPainter jauh lebih fleksibel daripada library chart standar, karena memvisualisasikan fisika gravitasi dan kedamaian batin.',
                    colors: colors,
                  ),
                  const SizedBox(height: 8),
                  _buildRecommendationItem(
                    title: '3. Hindari Chart Numerik Kaku yang Menghakimi Anak:',
                    desc: 'Tidak menampilkan label "Anak Ammarah 80%" secara numerik; visualisasi difokuskan pada ikhtiar pengasuh dan kehangatan relasi qalbiyah.',
                    colors: colors,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeColor,
    required dynamic colors,
    required String description,
    required Widget chartWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.tactileBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x062C2825),
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 11,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              color: colors.textSecondary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          chartWidget,
        ],
      ),
    );
  }

  Widget _buildRecommendationItem({
    required String title,
    required String desc,
    required dynamic colors,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: colors.ancientBark,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 12,
                color: colors.textSecondary,
                height: 1.35,
              ),
              children: [
                TextSpan(
                  text: '$title ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                TextSpan(text: desc),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
