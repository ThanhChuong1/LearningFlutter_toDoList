import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todolist/domain/todo.dart';

class addtodo extends StatefulWidget {
  const addtodo({super.key});

  @override
  State<addtodo> createState() => _addtodoState();
}

class _addtodoState extends State<addtodo> {
  final TextEditingController _controller = TextEditingController();
  DateTime? startDate = DateTime(2025);
  DateTime? endDate = DateTime(2030);
  final List<Todo> _listToDo = [];

  Future<void> selectedDate({required bool isStart}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    setState(() {
      if (pickedDate != null) {
        setState(() {
          if (isStart) {
            startDate = pickedDate;
          } else {
            endDate = pickedDate;
          }
        });
      }
    });
  }

  void addTodo(Todo todo) {
    String text = _controller.text;
    setState(() {
      _listToDo.add(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("TO DO LIST"),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  // dùng để tùy chỉnh ô input
                  border: OutlineInputBorder(), // dùng để vẽ viền cho ô input
                  hintText: 'Enter Title',
                  // labelText: 'ádasdsad',
                ),
              ),
              Text(
                startDate != null
                    ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                    : 'No date selected',
              ),
              OutlinedButton(
                onPressed: () {
                  selectedDate(isStart: true);
                },
                child: const Text('Select Start Date'),
              ),
              Text(
                endDate != null
                    ? '${endDate!.day}/${endDate!.month}/${endDate!.year}'
                    : 'No date selected',
              ),
              OutlinedButton(
                onPressed: () {
                  selectedDate(isStart: false);
                },
                child: const Text('Select End Date'),
              ),

              ElevatedButton(
                onPressed: () {
                  // String input = _controller.text;
                  addTodo(
                    Todo(
                      title: _controller.text,
                      startDate: startDate!,
                      endDate: endDate!,
                      isDone: false,
                    ),
                  );
                },
                child: Text('Add New To Do'),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: _listToDo.length,
                  itemBuilder: (context, index) {
                    final todo = _listToDo[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.isDone ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            todo.isDone = value ?? false;
                          });
                        },
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                          color: todo.isDone ? Colors.grey : Colors.black,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _listToDo.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
