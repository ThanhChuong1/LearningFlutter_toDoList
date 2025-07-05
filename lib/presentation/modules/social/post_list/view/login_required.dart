import 'package:flutter/material.dart';
import 'package:todolist/route/route_list.dart';

void showLoginRequiredDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Thông báo"),
      content: const Text("Bạn chưa đăng nhập."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Back"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RouteList.login);
          },
          child: const Text("Login"),
        ),
      ],
    ),
  );
}
