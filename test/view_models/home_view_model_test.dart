import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatta/ui/home/view_model/home_view_model.dart';
import 'package:yatta/data/models/task.dart';

void main() {
  group('HomeViewModel', () {
    late ProviderContainer container;
    late HomeViewModel homeViewModel;

    setUp(() {
      container = ProviderContainer();
      homeViewModel = container.read(homeViewModelProvider.notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態では空のリストが返される', () {
      final tasks = container.read(homeViewModelProvider);
      expect(tasks, isEmpty);
    });

    test('タスクを追加できる', () {
      homeViewModel.addTask('筋トレ');

      final tasks = container.read(homeViewModelProvider);
      expect(tasks.length, 1);
      expect(tasks.first.name, '筋トレ');
      expect(tasks.first.isCompletedToday, false);
    });

    test('タスクの今日の完了状態をトグルできる', () {
      homeViewModel.addTask('散歩');
      final tasks = container.read(homeViewModelProvider);
      final taskId = tasks.first.id;

      homeViewModel.toggleTaskCompletion(taskId);

      final updatedTasks = container.read(homeViewModelProvider);
      expect(updatedTasks.first.isCompletedToday, true);
    });

    test('タスク名を更新できる', () {
      homeViewModel.addTask('ランニング');
      final tasks = container.read(homeViewModelProvider);
      final taskId = tasks.first.id;

      homeViewModel.updateTaskName(taskId, 'ジョギング');

      final updatedTasks = container.read(homeViewModelProvider);
      expect(updatedTasks.first.name, 'ジョギング');
    });

    test('空の名前でタスクを追加しようとしても追加されない', () {
      homeViewModel.addTask('');
      homeViewModel.addTask('   ');

      final tasks = container.read(homeViewModelProvider);
      expect(tasks, isEmpty);
    });
  });
}
