import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:todolist/data/datasoures/remote/social_api_repository.dart';
import 'package:todolist/domain/entities/social_post.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_event.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final SocialApiRepository api;

  final int _pageSize = 10;
  int _currentLimit = 10; 
  List<SocialPost> _allPosts = [];

  PostBloc({required this.api}) : super(PostInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<LoadMorePostsEvent>(_onLoadMorePosts);
  }


  Future<void> _onLoadPosts(
    LoadPostsEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      final posts = await api.getPosts();
      final users = await api.getUsers();

      _allPosts = posts;
      _currentLimit = _pageSize;

      emit(
        PostLoaded(
          posts: _allPosts.take(_currentLimit).toList(),
          allPosts: _allPosts,
          users: users,
        ),
      );
    } catch (e, stackTrace) {
      debugPrint("Error in LoadPostsEvent: $e");
      debugPrintStack(stackTrace: stackTrace);
      emit(PostError(e.toString()));
    }
  }

 
  void _onLoadMorePosts(LoadMorePostsEvent event, Emitter<PostState> emit) {
    if (state is PostLoaded) {
      final currentState = state as PostLoaded;

      if (_currentLimit >= _allPosts.length) return; // Đã load hết

      _currentLimit += _pageSize;

      emit(
        PostLoaded(
          posts: _allPosts.take(_currentLimit).toList(),
          allPosts: _allPosts,
          users: currentState.users,
        ),
      );
    }
  }
}
