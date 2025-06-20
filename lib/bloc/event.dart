import 'package:todolist/domain/todo.dart';

abstract class ToDoEvent {}

class AddToDo extends ToDoEvent {
  final Todo todo;
  AddToDo(this.todo);
}

class CheckBox extends ToDoEvent {
  final int index;
  CheckBox(this.index);
}

class DeleteToDo extends ToDoEvent {
  final int index;
  DeleteToDo(this.index);
}


