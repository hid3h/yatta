import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view_model/home_view_model.dart';
import 'widgets/task_list_item.dart';

void _showAddTaskDialog(BuildContext context, HomeViewModel homeViewModel) {
  final textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('新しいやることを追加'),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'やることの名前を入力してください',
            labelText: 'やること名',
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              homeViewModel.addTask(value);
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
              final taskName = textController.text;
              if (taskName.trim().isNotEmpty) {
                homeViewModel.addTask(taskName);
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
    final tasks = ref.watch(homeViewModelProvider);
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      body: tasks.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'やることを追加してみましょう！',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskListItem(task: task);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, homeViewModel),
        tooltip: 'やることを追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}
