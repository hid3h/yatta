import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/habit.dart';
import '../view_model/home_view_model.dart';

class HabitListItem extends ConsumerWidget {
  const HabitListItem({
    super.key,
    required this.habit,
  });

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    return ListTile(
      title: Text(habit.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            habit.count.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => homeViewModel.removeHabit(habit.id),
            tooltip: '削除',
          ),
        ],
      ),
      onTap: () => homeViewModel.incrementHabit(habit.id),
    );
  }
}
