import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/bloc.dart';
import 'package:todolist/bloc/event.dart';
import 'package:todolist/bloc/state.dart';
import 'package:todolist/screens/addtodo.dart';

class ListToDo extends StatefulWidget {
  const ListToDo({super.key});

  @override
  State<ListToDo> createState() => _ListToDoState();
}

class _ListToDoState extends State<ListToDo> {
  void delete(int index) {
    bloc?.add(DeleteToDo(index));
  }

  ToDoBloc? get bloc => BlocProvider.of(context);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "LIST TO DO",
            style: TextStyle(fontSize: 20, fontFamily: 'Pacifico'),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellow,
        ),
        body: BlocConsumer<ToDoBloc, ToDoState>(
          listener: _blocListener,
          builder: (context, state) {
            final List todos = state.todos;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
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
                            delete(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addtodo()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _blocListener(BuildContext context, ToDoState state) {}
}
