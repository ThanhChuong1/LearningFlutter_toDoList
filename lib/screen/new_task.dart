import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/bloc.dart';
import 'package:todolist/bloc/event.dart';
// import 'package:flutter/scheduler.dart';
import 'package:todolist/screen/task_info.dart';

class SecondHome extends StatefulWidget {
  const SecondHome({super.key});

  @override
  State<SecondHome> createState() => _SecondHomeState();
}

class _SecondHomeState extends State<SecondHome> {
  final TextEditingController TaskController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final List<Color> priorityColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];
  Color selectedColor = Colors.blue;

  TimeOfDay selectedTime = TimeOfDay(hour: 7, minute: 0);
  TimeOfDay alarmTime = TimeOfDay(hour: 6, minute: 30);

  bool isAlarOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task'), centerTitle: true),
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            //Input box: WHAT DO YOU NEED TO DO?
            TextField(
              controller: TaskController,
              decoration: const InputDecoration(
                labelText: "What do you need to do?",
                labelStyle: TextStyle(fontSize: 18),
                border: UnderlineInputBorder(),
              ),
            ),

            //SUGGESTION
            const SizedBox(height: 10),
            const Text("Suggestion", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),

            Row(
              children: [
                _suggestionChip("Coding"),
                _suggestionChip("Gaming"),
                _suggestionChip("Sleep"),
              ],
            ),
            const Divider(),

            //PRIORITY COLOR SELECTOR
            const Text(
              "Priority",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: priorityColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: selectedColor == color
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),

            const Divider(),
            //NOTE
            const SizedBox(height: 24),
            const Text(
              "Note",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                hintText: "Design for home page",
                border: InputBorder.none,
              ),
            ),

            const Divider(),

            //TIME
            const Text(
              "Time",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            GestureDetector(
              onTap: _pickTime,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${formatTime(selectedTime)} ${selectedTime.period == DayPeriod.am ? "AM" : "PM"}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save"),
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _suggestionChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            TaskController.text = label;
          });
        },
        //color for suggestion
        style: ElevatedButton.styleFrom(
          backgroundColor: _getColor(label),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(label),
      ),
    );
  }

  Color _getColor(String label) {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  void _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  void _saveTask() {
    if (TaskController.text.isEmpty) return;
    final newTask = Taskinfo(
      // title: TaskController.text,
      // note: noteController.text,
      // time: selectedTime.format(context),
      // priorityColor: selectedColor,
      id: DateTime.now()
          .millisecondsSinceEpoch, // API cần id, dù không dùng, dùng tạm số lớn
      title: TaskController.text,
      completed: false,
      userId: 1,
    );

    context.read<TaskBloc>().add(AddTask(newTask));
    Navigator.pop(context);
  }
}
