import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/task_model.dart';

class DailyTaskState {
  final List<DailyTaskItem> tasks;
  final TaskCategory? filter;

  const DailyTaskState({
    required this.tasks,
    this.filter,
  });

  int get totalCount => tasks.length;
  int get completedCount => tasks.where((t) => t.isCompleted).length;
  double get completionRatio => totalCount == 0 ? 0.0 : completedCount / totalCount;
  int get percentage => (completionRatio * 100).round();

  List<DailyTaskItem> get filteredTasks {
    if (filter == null) return tasks;
    return tasks.where((t) => t.category == filter).toList();
  }

  DailyTaskState copyWith({
    List<DailyTaskItem>? tasks,
    TaskCategory? Function()? filter,
  }) {
    return DailyTaskState(
      tasks: tasks ?? this.tasks,
      filter: filter != null ? filter() : this.filter,
    );
  }
}

class DailyTaskNotifier extends StateNotifier<DailyTaskState> {
  DailyTaskNotifier() : super(_initialState);

  static final DailyTaskState _initialState = DailyTaskState(
    tasks: [
      const DailyTaskItem(
        id: 'task-1',
        title: 'Dialog Pundak Senja bersama Zaid (8 Thn)',
        description: 'Tatap matanya sejajar 15 menit sebelum adzan Maghrib, validasi kelelahannya bermain, hindari bentakan.',
        category: TaskCategory.relasiHati,
        isCompleted: true,
        resonance: SoulResonance.muthmainnah,
        childResponse: ChildResponse.lembut,
        qualityLabel: 'Kualitas: 4.8/5 (Muthmainnah)',
        wikiLink: 'Adab Shalat Anak',
        tag: 'Sky Horizon',
        timeLabel: 'Senja',
      ),
      const DailyTaskItem(
        id: 'task-2',
        title: 'Ruang Dengar Tanpa Menyela untuk Ummu Zaid (Pasangan)',
        description: 'Sediakan 10 menit obrolan teh hangat tanpa memegang gawai, dengarkan keluh kesah harian tanpa langsung memberi solusi teknis.',
        category: TaskCategory.relasiHati,
        isCompleted: false,
        tag: 'Relasi Pasangan',
        timeLabel: 'Malam',
      ),
      const DailyTaskItem(
        id: 'task-3',
        title: 'Latihan Resonansi Suara Rendah (3 Mnt)',
        description: 'Tarik nafas diafragma 4 detik, hembuskan perlahan sambil mengulang kalimat istighfar untuk menstabilkan amigdala sebelum memasuki rumah.',
        category: TaskCategory.mujahadahDiri,
        isCompleted: true,
        resonance: SoulResonance.muthmainnah,
        qualityLabel: 'Kualitas: 5.0/5 (Muthmainnah)',
        wikiLink: 'Manajemen Emosi Nabawiyah',
        tag: 'Tazkiyah Diri',
        timeLabel: 'Sore',
      ),
      const DailyTaskItem(
        id: 'task-4',
        title: 'Refleksi Wudhu Sebelum Menegur Anak',
        description: 'Saat rasa jengkel muncul, basuh wajah dan kedua tangan terlebih dahulu agar dorongan amarah padam berganti sakinah.',
        category: TaskCategory.mujahadahDiri,
        isCompleted: true,
        resonance: SoulResonance.lawwamah,
        qualityLabel: 'Kualitas: 4.0/5 (Lawwamah)',
        tag: 'Sunnah Adab',
        timeLabel: 'Siang',
      ),
      const DailyTaskItem(
        id: 'task-5',
        title: 'Menelaah 3 Kaidah Syar\'i Tamyiz di Wiki PKN',
        description: 'Pelajari taksonomi rukun perintah shalat usia 7 tahun dan larangan mutlak pemukulan fisik sebelum usia 10 tahun.',
        category: TaskCategory.targetBelajar,
        isCompleted: true,
        resonance: SoulResonance.muthmainnah,
        qualityLabel: 'Kualitas: 4.5/5 (Muthmainnah)',
        wikiLink: 'Perintah Shalat Pentahapan Usia',
        tag: 'Ilmu Manhaj',
        timeLabel: 'Pagi',
      ),
    ],
  );

  void setFilter(TaskCategory? filter) {
    state = state.copyWith(filter: () => filter);
  }

  void completeTaskWithReflection({
    required String taskId,
    required SoulResonance resonance,
    required ChildResponse childResponse,
  }) {
    String label;
    switch (resonance) {
      case SoulResonance.muthmainnah:
        label = 'Kualitas: 4.9/5 (Muthmainnah)';
        break;
      case SoulResonance.lawwamah:
        label = 'Kualitas: 4.2/5 (Lawwamah)';
        break;
      case SoulResonance.ammarah:
        label = 'Kualitas: 3.2/5 (Ammarah)';
        break;
    }

    final updated = state.tasks.map((task) {
      if (task.id == taskId) {
        return task.copyWith(
          isCompleted: true,
          resonance: resonance,
          childResponse: childResponse,
          qualityLabel: label,
        );
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updated);
  }

  void addTask(DailyTaskItem newTask) {
    state = state.copyWith(tasks: [...state.tasks, newTask]);
  }
}

final dailyTaskProvider = StateNotifierProvider<DailyTaskNotifier, DailyTaskState>((ref) {
  return DailyTaskNotifier();
});
