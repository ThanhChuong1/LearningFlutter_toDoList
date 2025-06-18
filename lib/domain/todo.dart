import 'dart:ffi';

class Todo {
  Todo({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.isDone,
  });
  String title; //null-able
  DateTime startDate;
  DateTime endDate;
  bool isDone;
}
