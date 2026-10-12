import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_prototype_v5/features/daily_task/data/models/task_model.dart';
import 'package:pkn_prototype_v5/features/daily_task/presentation/controllers/daily_task_controller.dart';

void main() {
  group('DailyTaskController & State Tests', () {
    test('Initial daily task state has 5 tasks with 4 completed (80%)', () {
      final notifier = DailyTaskNotifier();
      final state = notifier.state;

      expect(state.totalCount, 5);
      expect(state.completedCount, 4);
      expect(state.percentage, 80);
      expect(state.filter, isNull);
      expect(state.filteredTasks.length, 5);
    });

    test('Filter by category works correctly', () {
      final notifier = DailyTaskNotifier();

      notifier.setFilter(TaskCategory.relasiHati);
      expect(notifier.state.filteredTasks.length, 2);
      expect(
        notifier.state.filteredTasks.every((t) => t.category == TaskCategory.relasiHati),
        isTrue,
      );

      notifier.setFilter(TaskCategory.mujahadahDiri);
      expect(notifier.state.filteredTasks.length, 2);

      notifier.setFilter(TaskCategory.targetBelajar);
      expect(notifier.state.filteredTasks.length, 1);

      notifier.setFilter(null);
      expect(notifier.state.filteredTasks.length, 5);
    });

    test('Completing task-2 with reflection updates state to 100% (5/5)', () {
      final notifier = DailyTaskNotifier();

      notifier.completeTaskWithReflection(
        taskId: 'task-2',
        resonance: SoulResonance.muthmainnah,
        childResponse: ChildResponse.lembut,
      );

      final state = notifier.state;
      expect(state.completedCount, 5);
      expect(state.percentage, 100);

      final task2 = state.tasks.firstWhere((t) => t.id == 'task-2');
      expect(task2.isCompleted, isTrue);
      expect(task2.resonance, SoulResonance.muthmainnah);
      expect(task2.qualityLabel, contains('Muthmainnah'));
    });

    test('Adding a task from relations recommendation increases total count', () {
      final notifier = DailyTaskNotifier();

      const newTask = DailyTaskItem(
        id: 'task-scheduled-1',
        title: 'Sesi Apresiasi Verbal Sarapan untuk Ummu Zaid',
        description: 'Ucapkan apresiasi tulus saat makan pagi bersama.',
        category: TaskCategory.relasiHati,
      );

      notifier.addTask(newTask);

      expect(notifier.state.totalCount, 6);
      expect(notifier.state.completedCount, 4);
      expect(notifier.state.percentage, 67);
      expect(notifier.state.tasks.any((t) => t.id == 'task-scheduled-1'), isTrue);
    });
  });
}
