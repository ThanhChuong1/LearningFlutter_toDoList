import 'package:flutter/material.dart';
import 'package:todolist/domain/todo.dart';

class addtodo extends StatefulWidget {
  const addtodo({super.key});

  @override
  State<addtodo> createState() => _addtodoState();
}

class _addtodoState extends State<addtodo> {
  final TextEditingController _controller = TextEditingController();
  final List<Todo> _listToDo = [];

  void addTodo() {
    String text = _controller.text;
    setState(() {
      _listToDo.add(Todo(dateTime: DateTime(2025), title: text));
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
                  hintText: 'Enter To Do',
                  // labelText: 'ádasdsad',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // String input = _controller.text;
                  addTodo();
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
                        value: todo['done'],
                        onChanged: (bool? value) {
                          setState(() {
                            _listToDo[index]['done'] = value!;
                          });
                        },
                      ),
                      title: Text(
                        todo['title'],
                        style: TextStyle(
                          decoration: todo['done']
                              ? TextDecoration.lineThrough
                              : null,
                          color: todo['done'] ? Colors.grey : Colors.black,
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
