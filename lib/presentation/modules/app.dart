import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/data_source/data_repository.dart';
import 'package:todolist/data/datasoures/remote/dio_client.dart';
import 'package:todolist/data/datasoures/remote/social_api_repository.dart';
import 'package:todolist/domain/entities/cubit/user_cubit.dart';
import 'package:todolist/presentation/modules/login/bloc/login_bloc.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_bloc.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_event.dart';
import 'package:todolist/presentation/modules/social/post_list/view/post_list_sceen.dart';
import 'package:todolist/route/route.dart';
import 'package:todolist/route/route_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (_) => LoginBloc(DataRepository()),
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       onGenerateRoute: RouteGenerator.generateRoute,
  //       initialRoute: RouteList.postList,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => LoginBloc(DataRepository())),
        BlocProvider(
          create: (_) =>
              PostBloc(api: SocialApiRepository(DioClient.create()))
                ..add(LoadPostsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteList
            .postList, // hoặc RouteList.login nếu muốn khởi đầu tại login
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
