import 'package:flutter/material.dart';
import 'package:todolist/icon.dart';
import 'package:todolist/new_task.dart';
import 'package:todolist/task_info.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => MyHomePage(),
        '/second': (context) => SecondHome(),
      },
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
  List<Taskinfo> taskList = [];

  //Mức độ quan trọng để sắp xếp
  final Map<Color, int> priorityOrder = {
    Colors.red: 0,
    Colors.orange: 1,
    Colors.yellow: 2,
    Colors.green: 3,
    Colors.blue: 4,
  };

  void _sortTaskList() {
    taskList.sort((a, b) {
      final timeA = _parseTime(a.time);
      final timeB = _parseTime(b.time);

      if (timeA.hour != timeB.hour) {
        return timeA.hour.compareTo(timeB.hour);
      } else if (timeA.minute != timeB.minute) {
        return timeA.minute.compareTo(timeB.minute);
      } else {
        return priorityOrder[a.priorityColor]!.compareTo(
          priorityOrder[b.priorityColor]!,
        );
      }
    });
  }

  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(":");
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  void _addNewTask(Taskinfo newTask) {
    setState(() {
      taskList.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TODO List'),
      ),

      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text('${task.time}  ${task.note}'),
            trailing: Container(
              width: 5,
              height: 40,
              color: task.priorityColor,
            ),
            leading: Icon(Icons.circle, color: task.priorityColor, size: 10),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondHome()),
          );

          if (result != null && result is Taskinfo) {
            _addNewTask(result);
            _sortTaskList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
