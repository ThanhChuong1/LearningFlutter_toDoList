import 'package:todolist/domain/entities/social_comment.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<SocialComment> comments;
  CommentLoaded(this.comments);
}

class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
}
