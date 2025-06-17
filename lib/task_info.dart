import 'package:flutter/material.dart';

class Taskinfo {
  final String title;
  final String note;
  final String time;
  final Color priorityColor;

  Taskinfo({
    required this.title,
    required this.note,
    required this.time,
    required this.priorityColor,
  });
}
