import 'package:flutter/material.dart';
import 'package:todolist/screens/addtodo.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.yellow,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'To Do App',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontFamily: 'Pacifico'),
                ),
                

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addtodo()),
                    );
                  },
                  child: Text("Start"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
