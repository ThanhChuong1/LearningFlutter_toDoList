import 'package:flutter/material.dart';
import 'package:todolist/domain/entities/social_post.dart';
import 'package:todolist/domain/entities/social_user.dart';
import 'package:todolist/presentation/modules/social/post_list/view/login_required.dart';
import 'package:todolist/presentation/modules/user/bloc/user_state.dart';
import 'package:todolist/presentation/modules/social/comment/view/comment_screen.dart';

class PostListItem extends StatelessWidget {
  final SocialPost post;
  final SocialUser user;
  final UserState currentUserState;

  const PostListItem({
    super.key,
    required this.post,
    required this.user,
    required this.currentUserState,
  });

  void _onCommentPressed(BuildContext context) {
    if (currentUserState is! UserLoaded) {
      showLoginRequiredDialog(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CommentScreen(postId: post.id)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = "https://i.pravatar.cc/150?u=${user.id}";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
                  const SizedBox(width: 10),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(post.body),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => _onCommentPressed(context),
                  icon: const Icon(Icons.comment),
                  label: const Text("Comment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
