abstract class TodoEvent {}

class FetchTodos extends TodoEvent {}

class CheckBox extends TodoEvent {
  final int id;
  final bool completed;

  CheckBox({required this.id, required this.completed});
}
