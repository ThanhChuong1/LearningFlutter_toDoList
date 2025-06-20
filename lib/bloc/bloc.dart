import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/event.dart';
import 'package:todolist/bloc/state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoState([])) {
    on<AddToDo>((event, emit) {
      print(event.todo.title);
      final updated = [...state.todos, event.todo];
      emit(ToDoState(updated));
    });

    on<DeleteToDo>((event, emit) {
      final todos = [...state.todos];
      // state.todos.removeAt(event.index); //ds bi delete
      todos.removeAt(event.index);
      emit(ToDoState(todos));
    });
  }
}
