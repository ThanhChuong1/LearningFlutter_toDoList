import 'package:flutter/material.dart';
import 'package:todolist/presentation/modules/login/views/login_screen.dart';
import 'package:todolist/route/route_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      // 👉 Thêm các case khác nếu có nhiều màn hình
      // case RouteList.todo:
      //   return MaterialPageRoute(builder: (_) => const TodoScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
