import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/presentation/modules/todo/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:todolist/presentation/modules/todo/bloc/todo_event.dart';
import 'package:todolist/presentation/modules/todo/bloc/todo_state.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoBloc? get bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    bloc?.add(FetchTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIST TO DO'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final todos = state.todos;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Row(
                  children: [
                    Checkbox(
                      value: todo.completed,
                      onChanged: (value) {
                        bloc?.add(
                          CheckBox(id: todo.id, completed: value ?? false),
                        );
                      },
                    ),
                    Expanded(child: Text(todo.title)),
                  ],
                );
              },
            );
          } else if (state is TodoError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}
