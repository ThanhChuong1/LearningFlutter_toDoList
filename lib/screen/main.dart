import 'package:flutter/material.dart';
import 'package:todolist/repository/repository.dart';
import 'package:todolist/screen/icon.dart';
import 'package:todolist/screen/new_task.dart';
import 'package:todolist/screen/task_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/bloc/bloc.dart';
import 'package:todolist/bloc/event.dart';
import 'package:todolist/bloc/state.dart';

void main() {
  final TaskRepository taskRepo = TaskRepository();

  runApp(
    BlocProvider(
      create: (_) {
        final bloc = TaskBloc(taskRepo);
        bloc.add(LoadTasks()); // load API khi app start
        return bloc;
      },
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/second': (context) => SecondHome(),
        },
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title = 'TODO LIST'});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TODO List'),
      ),

      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final taskList = state.tasks;
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];
                return ListTile(
                  title: Text(task.title),
                  // trailing: Container(
                  //   width: 5,
                  //   height: 40,
                  //   color: task.priorityColor,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<TaskBloc>().add(DeleteTask(task.id));
                        },
                      ),
                      Container(
                        width: 5,
                        height: 40,
                        color: task.priorityColor,
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text('Error loading tasks'));
          } else {
            return const Center(child: Text("No tasks yet."));
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondHome()),
          );

          if (result != null && result is Taskinfo) {
            BlocProvider.of<TaskBloc>(context).add(AddTask(result));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
