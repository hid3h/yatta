import 'package:flutter/material.dart';

class Habit {
  Habit(this.name);
  final String name;
  int count = 0;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Habit> _habits = [];

  void _addHabit() {
    setState(() {
      _habits.add(Habit('Habit ${_habits.length + 1}'));
    });
  }

  void _incrementHabit(int index) {
    setState(() {
      _habits[index].count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('習慣リスト'),
      ),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return ListTile(
            title: Text(habit.name),
            trailing: Text(habit.count.toString()),
            onTap: () => _incrementHabit(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHabit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
