class Todo {
  Todo({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.isDone,
  });
  String title;
  DateTime startDate;
  DateTime endDate;
  bool isDone;

  Todo copyWith({
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.startDate,
      isDone: isDone ?? this.isDone,
    );
  }
}
