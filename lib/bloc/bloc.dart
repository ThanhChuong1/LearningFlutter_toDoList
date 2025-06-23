import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/event.dart';
import 'package:todolist/bloc/state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(ToDoState(todos: [])) {
    void onAddToDo(AddToDo event, Emitter<ToDoState> emit) {
      print(event.todo.startDate);
      print(event.todo.endDate);
      final updated = [...state.todos, event.todo];
      emit(state.copyWith(todos: updated));
    }

    void onDeleteToDo(DeleteToDo event, Emitter<ToDoState> emit) {
      final todos = [...state.todos];
      todos.removeAt(event.index);
      emit(state.copyWith(todos: todos));
    }

    void onSelectDate(SelectDate event, Emitter<ToDoState> emit) {
      print(event.selectDate);
      if (event.isStart) {
        emit(state.copyWith(startDate: event.selectDate));
      } else {
        emit(state.copyWith(endDate: event.selectDate));
      }
    }

    on<AddToDo>(onAddToDo);
    on<SelectDate>(onSelectDate);
    on<DeleteToDo>(onDeleteToDo);
  }
}
