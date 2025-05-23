import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/task.dart';
import '../view_model/home_view_model.dart';

class TaskListItem extends ConsumerWidget {
  const TaskListItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    final isCompletedToday = task.isCompletedToday;

    return ListTile(
      title: Text(
        task.name,
        style: TextStyle(
          decoration: isCompletedToday ? TextDecoration.lineThrough : null,
          color: isCompletedToday
              ? Colors.grey
              : Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      leading: Icon(
        isCompletedToday ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompletedToday
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
      onTap: () => homeViewModel.toggleTaskCompletion(task.id),
    );
  }
}
