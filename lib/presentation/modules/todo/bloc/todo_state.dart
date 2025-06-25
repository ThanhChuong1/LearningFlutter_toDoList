import 'package:todolist/domain/entities/Todo.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  TodoLoaded(this.todos);

  TodoLoaded copyWith({List<Todo>? todos}) {
    return TodoLoaded(todos ?? this.todos);
  }
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}
