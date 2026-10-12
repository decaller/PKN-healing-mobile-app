import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import 'package:pkn_prototype_v5/features/charts/presentation/widgets/multi_segment_progress_pill.dart';
import 'package:pkn_prototype_v5/features/charts/presentation/widgets/weekly_stacked_bar_chart.dart';
import 'package:pkn_prototype_v5/features/daily_task/data/models/task_model.dart';
import 'package:pkn_prototype_v5/features/daily_task/presentation/controllers/daily_task_controller.dart';

enum TimeframeFilter { pekanIni, bulanIni, sepanjangMasa }

class RelationsProgressScreen extends ConsumerStatefulWidget {
  final VoidCallback? onBack;

  const RelationsProgressScreen({super.key, this.onBack});

  @override
  ConsumerState<RelationsProgressScreen> createState() => _RelationsProgressScreenState();
}

class _RelationsProgressScreenState extends ConsumerState<RelationsProgressScreen> {
  TimeframeFilter _selectedTimeframe = TimeframeFilter.pekanIni;
  bool _taskScheduled = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface.withValues(alpha: 0.95),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: widget.onBack != null
            ? IconButton(
                icon: iconoir.ArrowLeft(width: 22, height: 22, color: colors.textPrimary),
                onPressed: widget.onBack,
              )
            : null,
        title: Text(
          'Neraca Jiwa & Relasi',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: iconoir.Bell(width: 20, height: 20, color: colors.textSecondary),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: colors.celestialSky,
              child: const Icon(Icons.person, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Timeframe Filter Pills
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: colors.tactileBorder),
              ),
              child: Row(
                children: [
                  _buildTimeframePill('Pekan Ini', TimeframeFilter.pekanIni, colors),
                  _buildTimeframePill('Bulan Ini', TimeframeFilter.bulanIni, colors),
                  _buildTimeframePill('Sepanjang Masa', TimeframeFilter.sepanjangMasa, colors),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Ringkasan Ketercapaian Amanah
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colors.tactileBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A2C2825),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TINGKAT KETERCAPAIAN AMANAH',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                color: colors.meadowCanopy,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  '88%',
                                  style: TextStyle(
                                    fontFamily: 'Merriweather',
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: colors.textPrimary,
                                  ),
                                ),
                                Text(
                                  '28 dari 32 Ikhtiar Selesai',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 12,
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colors.meadowCanopy.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.trending_up, size: 16, color: colors.meadowCanopy),
                            const SizedBox(width: 4),
                            Text(
                              '+14% vs Lalu',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: colors.meadowCanopy,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const MultiSegmentProgressPill(
                    diriRatio: 0.48,
                    hatiRatio: 0.32,
                    ilmuRatio: 0.08,
                    height: 10,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Aktivitas Sepekan (Sen - Ahd)',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: colors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const WeeklyStackedBarChart(),
                  const SizedBox(height: 14),
                  // AI Grounding Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colors.celestialSky.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: iconoir.Brain(width: 16, height: 16, color: colors.celestialSky),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tadabbur Asisten AI PKN',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: colors.celestialSky,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '“Stabilitas emosi Ayah meningkat pesat di hari kerja. Interaksi senja dengan Zaid menunjukkan tren kelekatan yang sangat positif.”',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 12,
                                  color: colors.textPrimary,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // 3. Matriks Relasi Qalbiyah (3 Amanah Utama)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      iconoir.Community(width: 20, height: 20, color: colors.celestialSky),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Matriks Relasi Qalbiyah',
                          overflow: TextOverflow.ellipsis,
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
                ),
                const SizedBox(width: 8),
                Text(
                  '3 Amanah Utama',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Relasi 1: Ananda Zaid
            _buildPersonCard(
              name: 'Ananda Zaid',
              phase: '8 Thn • Fase Tamyiz',
              scoreText: '85%',
              scoreStatus: 'Amanah Terjaga',
              accentColor: colors.meadowCanopy,
              colors: colors,
              metrics: const [
                {'label': 'Sholat Jamaah', 'value': '6/7 Hari'},
                {'label': 'Bebas Bentakan', 'value': '92%'},
                {'label': 'Tangki Jiwa', 'value': 'Penuh'},
              ],
              highlightNote:
                  'Respon terhadap bentakan turun 80% sejak diterapkannya SOP 10 Detik Dekapan Senja.',
            ),
            const SizedBox(height: 12),

            // Relasi 2: Ananda Maryam
            _buildPersonCard(
              name: 'Ananda Maryam',
              phase: '4 Thn • Fase Thufulah',
              scoreText: '95%',
              scoreStatus: 'Berlimpah Kasih',
              accentColor: colors.celestialSky,
              colors: colors,
              metrics: const [
                {'label': 'Main Bersama', 'value': '35 mnt/hari'},
                {'label': 'Adab Tidur', 'value': '5 Malam'},
              ],
            ),
            const SizedBox(height: 12),

            // Relasi 3: Ummu Zaid
            _buildPersonCard(
              name: 'Ummu Zaid',
              phase: 'Mitra Tarbiyah • Istri',
              scoreText: '78%',
              scoreStatus: 'Harmonis',
              accentColor: colors.ancientBark,
              colors: colors,
              metrics: const [
                {'label': 'Deep Talk No-Gadget', 'value': '4 Sesi / Pkn'},
                {'label': 'Munajat Sepertiga', 'value': 'Tercapai Rutin'},
              ],
            ),
            const SizedBox(height: 22),

            // 4. Pilar Bakat Terbina (TB-40)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colors.tactileBorder),
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
                              'TAZKIYATUN NAFS • TB-40',
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.6,
                                color: colors.meadowCanopy,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Pilar Bakat Terbina',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Merriweather',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '1.420 XP',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: colors.celestialSky,
                            ),
                          ),
                          Text(
                            'Poin Thuma\'ninah',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 11,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Maqam Banner
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.tactileBorder),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colors.meadowCanopy.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.workspace_premium, size: 20, color: colors.meadowCanopy),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Maqam / Gelar Adab:',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 11,
                                  color: colors.textSecondary,
                                ),
                              ),
                              Text(
                                '“Ayah Penyejuk Qalbu”',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 20, color: colors.textSecondary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildTalentProgress('Shidq (Kejujuran Autentik)', 'Level 3', 0.75, colors.celestialSky, colors),
                  const SizedBox(height: 8),
                  _buildTalentProgress('Rifq (Kelemahlembutan Suara)', 'Level 4', 0.90, colors.meadowCanopy, colors),
                  const SizedBox(height: 8),
                  _buildTalentProgress('Shabr (Daya Tahan Jiwa)', 'Level 2', 0.50, colors.ancientBark, colors),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // 5. Rekomendasi Hikmah Esok Hari + Add to Daily Task
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colors.tactileBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: colors.ancientBark.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: iconoir.LightBulb(width: 18, height: 18, color: colors.ancientBark),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Rekomendasi Hikmah Esok Hari',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Berdasarkan tren sinkronisasi pekan ini, tingkatkan 1 sesi apresiasi verbal khusus untuk Ummu Zaid saat sarapan pagi esok hari.',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12.5,
                      color: colors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: _taskScheduled
                          ? null
                          : () {
                              ref.read(dailyTaskProvider.notifier).addTask(
                                    const DailyTaskItem(
                                      id: 'task-scheduled-1',
                                      title: 'Sesi Apresiasi Verbal Sarapan untuk Ummu Zaid',
                                      description: 'Sampaikan ucapan terima kasih tulus atas keteladanan mendidik anak-anak saat makan pagi bersama.',
                                      category: TaskCategory.relasiHati,
                                      tag: 'Relasi Pasangan',
                                      timeLabel: 'Pagi Besok',
                                    ),
                                  );
                              setState(() => _taskScheduled = true);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: colors.meadowCanopy,
                                  content: const Text(
                                    'Ikhtiar berhasil disematkan ke agenda pagi besok!',
                                    style: TextStyle(fontFamily: 'Plus Jakarta Sans'),
                                  ),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.meadowCanopy,
                        foregroundColor: colors.surfaceContainerLowest,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_taskScheduled ? Icons.check : Icons.add_task, size: 18),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _taskScheduled ? 'Telah Dijadwalkan ke Daily Task' : '+ Jadwalkan ke Daily Task Besok',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ),
    );
  }

  Widget _buildTimeframePill(String label, TimeframeFilter filter, dynamic colors) {
    final isSelected = _selectedTimeframe == filter;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTimeframe = filter),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? colors.celestialSky : Colors.transparent,
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? colors.surfaceContainerLowest : colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonCard({
    required String name,
    required String phase,
    required String scoreText,
    required String scoreStatus,
    required Color accentColor,
    required dynamic colors,
    required List<Map<String, String>> metrics,
    String? highlightNote,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.tactileBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x062C2825),
            offset: Offset(0, 2),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: accentColor.withValues(alpha: 0.15),
                      child: Icon(Icons.person_outline, color: accentColor, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            phase,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 11.5,
                              color: colors.ancientBark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    scoreText,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  Text(
                    scoreStatus,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: accentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: metrics.map((m) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        m['label']!,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 10,
                          color: colors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        m['value']!,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (highlightNote != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  iconoir.CheckCircle(width: 14, height: 14, color: colors.meadowCanopy),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      highlightNote,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 11.5,
                        color: colors.textPrimary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTalentProgress(String title, String level, double progress, Color barColor, dynamic colors) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colors.tactileBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                level,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  color: barColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: colors.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
        ],
      ),
    );
  }
}
