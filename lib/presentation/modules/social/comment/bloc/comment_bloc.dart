import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/datasoures/remote/social_api_repository.dart';
// import 'package:todolist/domain/entities/social_comment.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final SocialApiRepository api;

  CommentBloc(this.api) : super(CommentInitial()) {
    on<FetchComments>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments = await api.getCommentsByPostId(event.postId);
        emit(CommentLoaded(comments));
      } catch (e) {
        emit(CommentError("Failed to load comments"));
      }
    });

    on<MockAddComment>((event, emit) {
      if (state is CommentLoaded) {
        final current = (state as CommentLoaded).comments;
        emit(CommentLoaded([...current, event.comment]));
      }
    });
  }
}
