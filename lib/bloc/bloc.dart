import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/event.dart';
import 'package:todolist/bloc/state.dart';
import 'package:todolist/repository/repository.dart';
import 'package:todolist/screen/task_info.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  // final List<Taskinfo> _taskList = [];

  // final Map<Color, int> _priorityOrder = {
  //   Colors.red: 0,
  //   Colors.orange: 1,
  //   Colors.yellow: 2,
  //   Colors.green: 3,
  //   Colors.blue: 4,
  // };

  TaskBloc(this.repository) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await repository.fetchTasks();
        print("Fetched ${tasks.length} tasks");
        emit(TaskLoaded(tasks));
      } catch (e, stacktrace) {
        emit(TaskError("Error loading tasks: $e"));
      }
    });

    on<AddTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentTasks = (state as TaskLoaded).tasks;
        final newTasks = List<Taskinfo>.from(currentTasks)..add(event.task);

        try {
          print("Sending task: ${event.task.toJson()}");
          await repository.addTask(event.task); // Gửi dữ liệu đến API
          emit(TaskLoaded(newTasks)); // Cập nhật state
        } catch (e) {
          emit(TaskError("Failed to add task: $e"));
        }
      }
    });

    on<DeleteTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentTasks = (state as TaskLoaded).tasks;

        final updatedTasks = currentTasks
            .where((task) => task.id != event.id)
            .toList();

        try {
          await repository.deleteTask(event.id);
          emit(TaskLoaded(updatedTasks));
        } catch (e) {
          emit(TaskError("Failed to delete task: $e"));
        }
      }
    });

    //   _taskList.add(event.task);
    //   _taskList.sort((a, b) {
    //     final timeA = _parseTime(a.time);
    //     final timeB = _parseTime(b.time);
    //     if (timeA.hour != timeB.hour) {
    //       return timeA.hour.compareTo(timeB.hour);
    //     } else if (timeA.minute != timeB.minute) {
    //       return timeA.minute.compareTo(timeB.minute);
    //     } else {
    //       return _priorityOrder[a.priorityColor]!.compareTo(
    //         _priorityOrder[b.priorityColor]!,
    //       );
    //     }
    //   });
    //   emit(TaskLoaded(List.from(_taskList)));
    // });
  }

  // TimeOfDay _parseTime(String timeStr) {
  //   final parts = timeStr.split(":");
  //   final hour = int.tryParse(parts[0]) ?? 0;
  //   final minute = int.tryParse(parts[1]) ?? 0;
  //   return TimeOfDay(hour: hour, minute: minute);
  // }
}
