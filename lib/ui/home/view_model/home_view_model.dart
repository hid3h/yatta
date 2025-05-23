import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/habit.dart';

class HomeViewModel extends StateNotifier<List<Habit>> {
  HomeViewModel() : super([]);

  void addHabit(String name) {
    if (name.trim().isEmpty) return;

    final newHabit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
    );
    state = [...state, newHabit];
  }

  void incrementHabit(String habitId) {
    state =
        state.map((habit) {
          if (habit.id == habitId) {
            return habit.copyWith(count: habit.count + 1);
          }
          return habit;
        }).toList();
  }

  void removeHabit(String habitId) {
    state = state.where((habit) => habit.id != habitId).toList();
  }

  void updateHabitName(String habitId, String newName) {
    state =
        state.map((habit) {
          if (habit.id == habitId) {
            return habit.copyWith(name: newName);
          }
          return habit;
        }).toList();
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, List<Habit>>(
  (ref) => HomeViewModel(),
);
