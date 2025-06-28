import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/datasoures/remote/dio_client.dart';
import 'package:todolist/data/datasoures/remote/social_api_repository.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_bloc.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_event.dart';
import 'package:todolist/presentation/modules/social/post_list/view/post_list_sceen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PostBloc(api: SocialApiRepository(DioClient.create()))
            ..add(LoadPostsEvent()),
      child: const PostListScreen(),
    );
  }
}
