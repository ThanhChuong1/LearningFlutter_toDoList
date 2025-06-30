import 'package:todolist/domain/entities/social_comment.dart';

abstract class CommentEvent {}

class FetchComments extends CommentEvent {
  final int postId;
  FetchComments(this.postId);
}
class MockAddComment extends CommentEvent {
  final SocialComment comment;
  MockAddComment(this.comment);
}
