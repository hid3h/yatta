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

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: isCompletedToday
          ? task.color.withOpacity(0.1)
          : Theme.of(context).colorScheme.surfaceVariant,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: task.color,
                shape: BoxShape.circle,
              ),
            ),
            if (isCompletedToday) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.check_circle,
                color: task.color,
              ),
            ],
          ],
        ),
        title: Text(
          task.name,
          style: TextStyle(
            color: isCompletedToday
                ? task.color
                : Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: isCompletedToday ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        onTap: () => homeViewModel.toggleTaskCompletion(task.id),
      ),
    );
  }
}
