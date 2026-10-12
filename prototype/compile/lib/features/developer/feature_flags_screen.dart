import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../core/config/feature_flags.dart';
import '../../core/theme/theme_extensions.dart';

class FeatureFlagsScreen extends ConsumerWidget {
  const FeatureFlagsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flags = ref.watch(featureFlagsProvider);
    final notifier = ref.read(featureFlagsProvider.notifier);
    final colors = context.earthTree;

    final moduleDefinitions = [
      _ModuleItem(
        key: 'enableCurhatAi',
        title: 'Teman Curhat AI (Edge LLM)',
        subtitle:
            'Konsultasi pengasuhan privat di perangkat (Edge LLM / Gemma LiteRT)',
        icon: iconoir.ChatBubble(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableCurhatAi,
      ),
      _ModuleItem(
        key: 'enableWalkieTalkie',
        title: 'Walkie-Talkie Ruang Qalbu',
        subtitle: 'Push-to-talk voice journaling & refleksi thuma\'ninah',
        icon: iconoir.Microphone(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableWalkieTalkie,
      ),
      _ModuleItem(
        key: 'enableDailyTask',
        title: 'Jurnal Adab Harian (BT-MT-BK-MM)',
        subtitle:
            'Penilaian observasi adab fitrah anak dengan dialog modal evaluasi',
        icon: iconoir.CheckCircle(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableDailyTask,
      ),
      _ModuleItem(
        key: 'enableRelationsProgress',
        title: 'Relasi Qalbiyah & Mizan Balance',
        subtitle:
            'Pertumbuhan keseimbangan fitrah (Diri, Pasangan, Anak, Komunitas)',
        icon: iconoir.Heart(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableRelationsProgress,
      ),
      _ModuleItem(
        key: 'enableEvents',
        title: 'Agenda & Majelis Parenting',
        subtitle:
            'Sinkronisasi jadwal kajian & majelis akbar parenting nabawiyah',
        icon: iconoir.Calendar(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableEvents,
      ),
      _ModuleItem(
        key: 'enableKnowledgeWiki',
        title: 'Khazanah Fitrah & Vector Search',
        subtitle:
            'Pencarian hybrid semantic & artikel khazanah nabawiyah offline',
        icon: iconoir.Book(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableKnowledgeWiki,
      ),
      _ModuleItem(
        key: 'enablePrimerLessons',
        title: 'Micro-Learning Adab (Primer Player)',
        subtitle: 'Kartu belajar interaktif, quiz bertahap, dan growth report',
        icon: iconoir.Bookmark(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enablePrimerLessons,
      ),
      _ModuleItem(
        key: 'enableP3kCrisis',
        title: 'P3K Jiwa (Crisis First-Aid)',
        subtitle: 'Tombol darurat thuma\'ninah ketika emosi orang tua meluap',
        icon: iconoir.ShieldAlert(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableP3kCrisis,
      ),
      _ModuleItem(
        key: 'enableChartsTestbed',
        title: 'Mizan Balance Scale & Charts',
        subtitle: 'Visualisasi timbangan keadilan adab & radar bakat TB40',
        icon: iconoir.GraphUp(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableChartsTestbed,
      ),
      _ModuleItem(
        key: 'enableStories',
        title: 'Serial Kisah Pengasuhan Nabawiyah',
        subtitle: 'Dongeng pengantar tidur adab & kisah teladan sahabat',
        icon: iconoir.MediaVideo(color: colors.textPrimary, width: 22, height: 22),
        value: flags.enableStories,
      ),
    ];

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Modular Feature Flags',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Reset Default',
            icon: Icon(Icons.refresh, color: colors.textSecondary),
            onPressed: () async {
              await notifier.resetAll();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Semua flags direset ke default')),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Banner Status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.meadowCanopy.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colors.meadowCanopy.withOpacity(0.25),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.meadowCanopy.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: iconoir.Settings(
                      color: colors.meadowCanopy,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modularitas Tanpa Rusak',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Setiap modul terisolasi. Mematikan modul apa pun akan secara anggun menyembunyikan navigasi & kartu tanpa crash.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Presets
          Text(
            'PRESET CEPAT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _PresetChip(
                  label: 'Semua Aktif (${flags.totalCount}/${flags.totalCount})',
                  isActive: flags.enabledCount == flags.totalCount,
                  onTap: () => notifier.applyPreset(FeatureFlagsConfig.allEnabled()),
                ),
                const SizedBox(width: 8),
                _PresetChip(
                  label: 'Minimal Core (1/10)',
                  isActive: !flags.enableCurhatAi &&
                      !flags.enableKnowledgeWiki &&
                      !flags.enableEvents &&
                      flags.enableP3kCrisis,
                  onTap: () => notifier.applyPreset(FeatureFlagsConfig.minimalCore()),
                ),
                const SizedBox(width: 8),
                _PresetChip(
                  label: 'AI & Voice Focus',
                  isActive: flags.enableCurhatAi &&
                      flags.enableWalkieTalkie &&
                      !flags.enableKnowledgeWiki,
                  onTap: () => notifier.applyPreset(FeatureFlagsConfig.aiFocused()),
                ),
                const SizedBox(width: 8),
                _PresetChip(
                  label: 'Literasi & Agenda',
                  isActive: flags.enableKnowledgeWiki &&
                      flags.enableEvents &&
                      !flags.enableCurhatAi,
                  onTap: () =>
                      notifier.applyPreset(FeatureFlagsConfig.learningFocused()),
                ),
                const SizedBox(width: 8),
                _PresetChip(
                  label: 'Parenting & Adab',
                  isActive: flags.enableDailyTask &&
                      flags.enableRelationsProgress &&
                      !flags.enableCurhatAi,
                  onTap: () => notifier
                      .applyPreset(FeatureFlagsConfig.parentingAdabFocused()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Daftar Modul
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DAFTAR MODUL MANDIRI',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                  color: colors.textSecondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.tactileBorder.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${flags.enabledCount} dari ${flags.totalCount} aktif',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ...moduleDefinitions.map((item) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: item.value
                    ? colors.tactileBorder.withOpacity(0.12)
                    : colors.tactileBorder.withOpacity(0.04),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: item.value
                      ? colors.meadowCanopy.withOpacity(0.3)
                      : colors.tactileBorder.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: item.value
                          ? colors.meadowCanopy.withOpacity(0.12)
                          : colors.tactileBorder.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: item.icon),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: item.value
                                ? colors.textPrimary
                                : colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.3,
                            color: colors.textSecondary.withOpacity(0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch.adaptive(
                    value: item.value,
                    activeColor: colors.meadowCanopy,
                    onChanged: (val) {
                      notifier.setFlag(item.key, val);
                    },
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _PresetChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? colors.meadowCanopy : colors.tactileBorder.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? colors.meadowCanopy : colors.tactileBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? colors.onMeadowCanopy : colors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ModuleItem {
  final String key;
  final String title;
  final String subtitle;
  final Widget icon;
  final bool value;

  _ModuleItem({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
  });
}
