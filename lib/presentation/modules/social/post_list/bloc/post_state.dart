import 'package:todolist/domain/entities/social_post.dart';
import 'package:todolist/domain/entities/social_user.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<SocialPost> posts;      // các bài hiện tại hiển thị
  final List<SocialPost> allPosts;   // toàn bộ bài viết từ API
  final List<SocialUser> users;

  PostLoaded({
    required this.posts,
    required this.allPosts,
    required this.users,
  });
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}
