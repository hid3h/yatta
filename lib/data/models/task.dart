class Task {
  const Task({
    required this.id,
    required this.name,
    this.completedDates = const [],
  });

  final String id;
  final String name;
  final List<DateTime> completedDates;

  Task copyWith({
    String? id,
    String? name,
    List<DateTime>? completedDates,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  /// 今日完了しているかどうかを確認
  bool get isCompletedToday {
    final today = DateTime.now();
    return completedDates.any((completedDate) =>
        completedDate.year == today.year &&
        completedDate.month == today.month &&
        completedDate.day == today.day);
  }

  /// 今日の完了状態をトグル
  Task toggleTodayCompletion() {
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final newCompletedDates = List<DateTime>.from(completedDates);

    final existingIndex = newCompletedDates.indexWhere((completedDate) =>
        completedDate.year == normalizedToday.year &&
        completedDate.month == normalizedToday.month &&
        completedDate.day == normalizedToday.day);

    if (existingIndex >= 0) {
      // 既に完了している場合は削除
      newCompletedDates.removeAt(existingIndex);
    } else {
      // 完了していない場合は追加
      newCompletedDates.add(normalizedToday);
    }

    return copyWith(completedDates: newCompletedDates);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task &&
        other.id == id &&
        other.name == name &&
        _listEquals(other.completedDates, completedDates);
  }

  @override
  int get hashCode => Object.hash(id, name, completedDates);

  @override
  String toString() => 'Task(id: $id, name: $name, completedDates: $completedDates)';

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    if (identical(a, b)) return true;
    for (int index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }
}
