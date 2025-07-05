// lib/presentation/modules/login/view/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/data_source/data_repository.dart';
import 'package:todolist/presentation/modules/login/bloc/login_bloc.dart';
import 'login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(DataRepository()),
      child: const LoginScreen(), // 👈 đặt đúng trong BlocProvider
    );
  }
}
