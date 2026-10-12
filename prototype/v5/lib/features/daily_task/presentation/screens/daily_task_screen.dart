import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/task_model.dart';
import '../controllers/daily_task_controller.dart';
import '../widgets/modal_review_adab.dart';

class DailyTaskScreen extends ConsumerWidget {
  final VoidCallback? onBack;

  const DailyTaskScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.earthTree;
    final state = ref.watch(dailyTaskProvider);
    final notifier = ref.read(dailyTaskProvider.notifier);

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
          'Amanah Harian',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colors.meadowCanopy.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Row(
              children: [
                iconoir.CheckCircle(width: 14, height: 14, color: colors.meadowCanopy),
                const SizedBox(width: 6),
                Text(
                  '${state.completedCount}/${state.totalCount} Tuntas',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: colors.meadowCanopy,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Tanggal Hijriah & Fase Hari
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      iconoir.Calendar(width: 15, height: 15, color: colors.ancientBark),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Senin, 14 Rabiul Awwal • 1446 H',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colors.ancientBark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    'Fase Maghrib',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 2. Judul & Ringkasan Progress Bar
            Text(
              'Amanah Harian Abu Hafi',
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.tactileBorder),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            iconoir.Check(width: 16, height: 16, color: colors.meadowCanopy),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${state.completedCount} dari ${state.totalCount} Amanah Terlaksana',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 13,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${state.percentage}%',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colors.meadowCanopy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: state.completionRatio,
                      minHeight: 8,
                      backgroundColor: colors.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(colors.meadowCanopy),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. Rekomendasi Pintar (Firasat Modul Nabawiyah)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.tactileBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x082C2825),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: colors.ancientBark.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: iconoir.LightBulbOn(width: 20, height: 20, color: colors.ancientBark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FIRASAT MODUL NABAWIYAH',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            color: colors.ancientBark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rekomendasi dari Penelusuran Wiki & Masalah Zaid (8 Thn)',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Karena Anda baru menelaah "Perintah Sholat Usia 7–10 Thn" dan mencatat transisi Maghrib, modul menyiapkan aksi lisan konkret sore ini.',
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
            const SizedBox(height: 18),

            // 4. Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    label: 'Semua (${state.totalCount})',
                    isSelected: state.filter == null,
                    onTap: () => notifier.setFilter(null),
                    colors: colors,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: 'Relasi Hati (${state.tasks.where((t) => t.category == TaskCategory.relasiHati).length})',
                    isSelected: state.filter == TaskCategory.relasiHati,
                    onTap: () => notifier.setFilter(TaskCategory.relasiHati),
                    colors: colors,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: 'Mujahadah Diri (${state.tasks.where((t) => t.category == TaskCategory.mujahadahDiri).length})',
                    isSelected: state.filter == TaskCategory.mujahadahDiri,
                    onTap: () => notifier.setFilter(TaskCategory.mujahadahDiri),
                    colors: colors,
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    label: 'Target Belajar (${state.tasks.where((t) => t.category == TaskCategory.targetBelajar).length})',
                    isSelected: state.filter == TaskCategory.targetBelajar,
                    onTap: () => notifier.setFilter(TaskCategory.targetBelajar),
                    colors: colors,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 5. Daftar Tugas
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.filteredTasks.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final task = state.filteredTasks[index];
                return _buildTaskCard(context, task, notifier, colors);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required dynamic colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? colors.meadowCanopy : colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(
            color: isSelected ? colors.meadowCanopy : colors.tactileBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? colors.surfaceContainerLowest : colors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context,
    DailyTaskItem task,
    DailyTaskNotifier notifier,
    dynamic colors,
  ) {
    final isCompleted = task.isCompleted;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCompleted ? colors.surfaceContainerLow : colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.tactileBorder),
        boxShadow: isCompleted
            ? null
            : const [
                BoxShadow(
                  color: Color(0x0A2C2825),
                  offset: Offset(0, 2),
                  blurRadius: 6,
                )
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox Trigger
          GestureDetector(
            onTap: isCompleted
                ? null
                : () {
                    ModalReviewAdab.show(
                      context: context,
                      task: task,
                      onSubmitted: (resonance, response) {
                        notifier.completeTaskWithReflection(
                          taskId: task.id,
                          resonance: resonance,
                          childResponse: response,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: colors.meadowCanopy,
                            content: const Text(
                              'Amanah terselesaikan dengan refleksi adab.',
                              style: TextStyle(fontFamily: 'Plus Jakarta Sans'),
                            ),
                          ),
                        );
                      },
                    );
                  },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isCompleted ? colors.meadowCanopy : colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isCompleted ? colors.meadowCanopy : colors.tactileBorder,
                ),
              ),
              child: isCompleted
                  ? Icon(Icons.check, size: 18, color: colors.surfaceContainerLowest)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          // Task Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? colors.textSecondary : colors.textPrimary,
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                    if (task.timeLabel != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        task.timeLabel!,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 11,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 12.5,
                    color: colors.textSecondary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    if (task.tag != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.celestialSky.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          task.tag!,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: colors.celestialSky,
                          ),
                        ),
                      ),
                    if (task.qualityLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.meadowCanopy.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 12, color: colors.meadowCanopy),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                task.qualityLabel!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: colors.meadowCanopy,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (task.wikiLink != null)
                      Text(
                        'Wiki: ${task.wikiLink}',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 11,
                          color: colors.ancientBark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
