import 'package:flutter/material.dart';

class CustomAddIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAddIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add, color: const Color.fromARGB(255, 3, 55, 244)),
      onPressed: onPressed,
    );
  }
}
