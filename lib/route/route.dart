import 'package:flutter/material.dart';
import 'package:todolist/domain/entities/User.dart';
import 'package:todolist/presentation/modules/login/views/login_page.dart';
import 'package:todolist/presentation/modules/profile/views/profile_screen.dart';
import 'package:todolist/presentation/modules/social/post_list/view/post_list_sceen.dart';
import 'package:todolist/presentation/modules/todo/views/todo_homepage.dart';
import 'package:todolist/route/route_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteList.todo:
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => TodoScreen(user: user));
      case RouteList.profile:
        final user = settings.arguments as User;
        return MaterialPageRoute(builder: (_) => ProfileScreen(user: user));
      case RouteList.postList:
        return MaterialPageRoute(builder: (_) => const PostListScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
