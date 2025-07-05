import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/domain/entities/social_user.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_state.dart';
import 'package:todolist/presentation/modules/user/bloc/user_bloc.dart';
import 'package:todolist/presentation/modules/user/bloc/user_state.dart';
import 'package:todolist/presentation/modules/social/post_list/view/post_list_item.dart';

class PostListView extends StatelessWidget {
  final PostLoaded state;
  final ScrollController scrollController;

  const PostListView({
    super.key,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserBloc>().state;

    return ListView.builder(
      controller: scrollController,
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        final post = state.posts[index];
        final user = state.users.firstWhere(
          (u) => u.id == post.userId,
          orElse: () => SocialUser(id: 0, name: "Unknown", username: "", email: ""),
        );

        return PostListItem(
          post: post,
          user: user,
          currentUserState: currentUser,
        );
      },
    );
  }
}
