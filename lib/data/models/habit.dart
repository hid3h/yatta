class Habit {
  const Habit({
    required this.id,
    required this.name,
    this.count = 0,
  });

  final String id;
  final String name;
  final int count;

  Habit copyWith({
    String? id,
    String? name,
    int? count,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Habit &&
        other.id == id &&
        other.name == name &&
        other.count == count;
  }

  @override
  int get hashCode => Object.hash(id, name, count);

  @override
  String toString() => 'Habit(id: $id, name: $name, count: $count)';
}
