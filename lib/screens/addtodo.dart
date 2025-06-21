import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/bloc.dart';
import 'package:todolist/bloc/event.dart';
import 'package:todolist/bloc/state.dart';
import 'package:todolist/domain/todo.dart';

class addtodo extends StatefulWidget {
  const addtodo({super.key});

  @override
  State<addtodo> createState() => _addtodoState();
}

class _addtodoState extends State<addtodo> {
  final TextEditingController _controller = TextEditingController();
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();

  Future<void> selectDate({required bool isStart}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      bloc?.add(SelectDate(isStart, pickedDate));
    }

    // setState(() {
    //   if (pickedDate != null) {
    //     setState(() {
    //       if (isStart) {
    //         startDate = pickedDate;
    //       } else {
    //         endDate = pickedDate;
    //       }
    //     });
    //   }
    // });
  }

  void addTodo(Todo todo) {
    bloc?.add(AddToDo(todo));
  }

  ToDoBloc? get bloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "ADD NEW TODO",
            style: TextStyle(fontSize: 20, fontFamily: 'Pacifico'),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        body: BlocConsumer<ToDoBloc, ToDoState>(
          listener: _blocListener,
          builder: (context, state) {
            final List todos = state.todos;
            return Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Title',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          selectDate(isStart: true);
                        },
                        child: Text(
                          state.startDate != null
                              ? '${state.startDate!.day}/${state.startDate!.month}/${state.startDate!.year}'
                              : 'Start Date',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                      OutlinedButton(
                        onPressed: () {
                          selectDate(isStart: false);
                        },
                        child: Text(
                          state.endDate != null
                              ? '${state.endDate!.day}/${state.endDate!.month}/${state.endDate!.year}'
                              : 'End Date',
                        ),
                      ),
                    ],
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
                      Navigator.pop(context);
                    },
                    child: Text('Add New To Do'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void _blocListener(BuildContext context, ToDoState state) {}
