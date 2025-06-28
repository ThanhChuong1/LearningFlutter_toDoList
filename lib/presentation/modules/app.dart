import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/data_source/data_repository.dart';
import 'package:todolist/presentation/modules/login/bloc/login_bloc.dart';
import 'package:todolist/route/route.dart'; 
import 'package:todolist/route/route_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(DataRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: RouteList.login,
      ),
    );
  }
}
