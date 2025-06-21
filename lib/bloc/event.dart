import 'package:todolist/screen/task_info.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Taskinfo task;
  AddTask(this.task);
}

class DeleteTask extends TaskEvent {
  final int id;
  DeleteTask(this.id);
}
