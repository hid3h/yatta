import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/task.dart';

class HomeViewModel extends StateNotifier<List<Task>> {
  HomeViewModel() : super([]);

  void addTask(String name) {
    if (name.trim().isEmpty) return;

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
    );
    state = [...state, newTask];
  }

  void toggleTaskCompletion(String taskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        return task.toggleTodayCompletion();
      }
      return task;
    }).toList();
  }

  void updateTaskName(String taskId, String newName) {
    state = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(name: newName);
      }
      return task;
    }).toList();
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, List<Task>>(
  (ref) => HomeViewModel(),
);
