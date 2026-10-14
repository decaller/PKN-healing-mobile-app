import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class Milestone1AdabChecklist extends StatefulWidget {
  const Milestone1AdabChecklist({super.key});

  @override
  State<Milestone1AdabChecklist> createState() => _Milestone1AdabChecklistState();
}

class _Milestone1AdabChecklistState extends State<Milestone1AdabChecklist> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Bicara Lembut Tanpa Nada Tinggi',
      'desc': 'Menatap mata ananda dan menjawab panggilan dengan suara tenang.',
      'done': true,
    },
    {
      'title': 'Mendengarkan Cerita Sampai Tuntas',
      'desc': 'Menahan diri dari memotong pembicaraan anak atau buru-buru menceramahi.',
      'done': true,
    },
    {
      'title': 'Doa Penyejuk Hati Ba\'da Shalat',
      'desc': 'Melafalkan QS. Al-Furqan: 74 khusus untuk ananda di waktu mustajab.',
      'done': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final completedCount = _tasks.where((t) => t['done'] == true).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.tactileBorder),
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
                    const iconoir.CheckCircle(
                      width: 18,
                      height: 18,
                      color: Color(0xFF235347),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "Amalan Adab Hari Ini",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.meadowCanopyContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "$completedCount / ${_tasks.length} Selesai",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: colors.onMeadowCanopyContainer,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ..._tasks.map((task) {
            final isDone = task['done'] as bool;

            return GestureDetector(
              onTap: () {
                setState(() {
                  task['done'] = !isDone;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDone
                      ? colors.surfaceContainer.withValues(alpha: 0.5)
                      : colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDone
                        ? colors.meadowCanopy.withValues(alpha: 0.3)
                        : colors.tactileBorder,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: isDone
                            ? const Color(0xFF235347)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isDone
                              ? const Color(0xFF235347)
                              : colors.tactileBorder,
                          width: 1.5,
                        ),
                      ),
                      child: isDone
                          ? const Center(
                              child: Icon(Icons.check, size: 14, color: Colors.white),
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['title'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              decoration: isDone ? TextDecoration.lineThrough : null,
                              color: isDone ? colors.textMuted : colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            task['desc'] as String,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
