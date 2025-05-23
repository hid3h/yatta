import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view_model/home_view_model.dart';
import 'widgets/habit_list_item.dart';

void _showAddHabitDialog(BuildContext context, HomeViewModel homeViewModel) {
  final textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('新しい習慣を追加'),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '習慣の名前を入力してください',
            labelText: '習慣名',
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              homeViewModel.addHabit(value);
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              final habitName = textController.text;
              if (habitName.trim().isNotEmpty) {
                homeViewModel.addHabit(habitName);
                Navigator.of(context).pop();
              }
            },
            child: const Text('追加'),
          ),
        ],
      );
    },
  );
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(homeViewModelProvider);
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('習慣リスト'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:
          habits.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.track_changes, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      '習慣を追加してみましょう！',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return HabitListItem(habit: habit);
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHabitDialog(context, homeViewModel),
        tooltip: '習慣を追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}
