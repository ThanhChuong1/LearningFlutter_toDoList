import 'package:todolist/data/datasoures/remote/todo/todo_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/presentation/modules/todo/bloc/todo_event.dart';
import 'package:todolist/presentation/modules/todo/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRemoteDataSource dataSource;

  TodoBloc(this.dataSource) : super(TodoInitial()) {
    on<FetchTodos>(_onFetchTodos);
    on<CheckBox>(_onCheckBox);
  }
  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await dataSource.fetchTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  void _onCheckBox(CheckBox event, Emitter<TodoState> emit) {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final todos = [...currentState.todos];

      final index = todos.indexWhere((todo) => todo.id == event.id);
      if (index != -1) {
        final updatedTodo = todos[index].copyWith(completed: event.completed);
        todos[index] = updatedTodo;
        emit(currentState.copyWith(todos: todos));
      }
    }
  }
}
