import 'package:todolist/domain/todo.dart';

// abstract class ToDoState {}

// class ToDoLoaded extends ToDoState {
//   final List<Todo> todos;
//   ToDoLoaded(this.todos);
// }
class ToDoState {
  final List<Todo> todos;
  final DateTime? startDate;
  final DateTime? endDate;

  ToDoState({required this.todos, this.startDate, this.endDate});

  ToDoState copyWith({
    List<Todo>? todos,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ToDoState(
      todos: todos ?? this.todos,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
