import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yatta/data/models/habit.dart';
import 'package:yatta/ui/home/view_model/home_view_model.dart';

void main() {
  group('HomeViewModel', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は空のリスト', () {
      final habits = container.read(homeViewModelProvider);
      expect(habits, isEmpty);
    });

    test('習慣を追加できる', () {
      final notifier = container.read(homeViewModelProvider.notifier);

      notifier.addHabit();

      final habits = container.read(homeViewModelProvider);
      expect(habits.length, 1);
      expect(habits.first.name, 'Habit 1');
      expect(habits.first.count, 0);
    });

    test('習慣のカウントを増やせる', () {
      final notifier = container.read(homeViewModelProvider.notifier);

      notifier.addHabit();
      final habits = container.read(homeViewModelProvider);
      final habitId = habits.first.id;

      notifier.incrementHabit(habitId);

      final updatedHabits = container.read(homeViewModelProvider);
      expect(updatedHabits.first.count, 1);
    });

    test('習慣を削除できる', () {
      final notifier = container.read(homeViewModelProvider.notifier);

      notifier.addHabit();
      final habits = container.read(homeViewModelProvider);
      final habitId = habits.first.id;

      notifier.removeHabit(habitId);

      final updatedHabits = container.read(homeViewModelProvider);
      expect(updatedHabits, isEmpty);
    });

    test('習慣名を更新できる', () {
      final notifier = container.read(homeViewModelProvider.notifier);

      notifier.addHabit();
      final habits = container.read(homeViewModelProvider);
      final habitId = habits.first.id;

      notifier.updateHabitName(habitId, '新しい習慣名');

      final updatedHabits = container.read(homeViewModelProvider);
      expect(updatedHabits.first.name, '新しい習慣名');
    });
  });
}
