import 'dart:ui';

class Taskinfo {
  final int id;
  final String title;
  final bool completed;
  final int userId;

  Taskinfo({
    required this.id,
    required this.title,
    required this.completed,
    required this.userId,
  });

  // Convert from JSON
  factory Taskinfo.fromJson(Map<String, dynamic> json) {
    return Taskinfo(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      completed: json['completed'] ?? false,
      userId: json['userId'] ?? 0,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'completed': completed, 'userId': userId};
  }

  // Optional: for UI color
  Color get priorityColor =>
      completed ? const Color(0xFF00FF00) : const Color(0xFFFF0000);
}
