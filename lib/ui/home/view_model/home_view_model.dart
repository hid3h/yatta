import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/task.dart';

class HomeViewModel extends StateNotifier<List<Task>> {
  HomeViewModel() : super([]);

  // やることの色リスト
  static const List<Color> _taskColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  void addTask(String name) {
    if (name.trim().isEmpty) return;

    // やることの数に基づいて色を循環的に割り当て
    final colorIndex = state.length % _taskColors.length;
    final taskColor = _taskColors[colorIndex];

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      color: taskColor,
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

  void toggleTaskCompletionOnDate(String taskId, DateTime date) {
    state = state.map((task) {
      if (task.id == taskId) {
        return task.toggleCompletionOnDate(date);
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

  // 指定した日に実行されたやったことを取得
  List<Task> getTasksForDate(DateTime date) {
    return state.where((task) => task.isCompletedOnDate(date)).toList();
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, List<Task>>(
  (ref) => HomeViewModel(),
);
