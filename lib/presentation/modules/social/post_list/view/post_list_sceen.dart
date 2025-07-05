import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_bloc.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_event.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_state.dart';
import 'post_list_view.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<PostBloc>().add(LoadMorePostsEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Posts")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return PostListView(
              state: state,
              scrollController: _scrollController,
            );
          } else if (state is PostError) {
            return Center(child: Text("error: ${state.message}"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
