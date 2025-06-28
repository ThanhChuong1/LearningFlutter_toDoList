import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/domain/entities/User.dart';

class ProfileScreen extends StatelessWidget{
  final User user;
  
  const ProfileScreen({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user.name}", style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            Text("Address: ${user.address}", style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 8),
            Text("Phone: ${user.phone}", style: const TextStyle(fontSize: 15)),
          ],
        )
      )
    );
  }

}