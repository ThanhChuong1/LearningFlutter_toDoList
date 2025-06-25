import 'package:todolist/domain/entities/Todo.dart';

abstract class TodoRemoteDataSource {
  Future<List<Todo>> fetchTodos();
}
