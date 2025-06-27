import 'package:flutter/material.dart';
import 'package:todolist/domain/entities/User.dart';
import 'package:todolist/route/route_list.dart';

class TodoScreen extends StatelessWidget{
  final User user;
  const TodoScreen({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {


   return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login', 
                (route) => false,
              );
            }, 
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, RouteList.profile, arguments: user);
            },
          ),

        ],
      ),
      body: Column(
        children: [
          // TODO: Todo List
          // TODO: Add todo
        ],
      ),
    );
  }
}