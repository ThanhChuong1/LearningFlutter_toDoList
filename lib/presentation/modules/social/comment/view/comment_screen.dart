import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:todolist/data/datasoures/remote/social_api_repository.dart';
import 'package:todolist/domain/entities/cubit/user_cubit.dart';
import 'package:todolist/presentation/modules/social/comment/bloc/comment_bloc.dart';
import 'package:todolist/presentation/modules/social/comment/bloc/comment_event.dart';
import 'package:todolist/presentation/modules/social/comment/bloc/comment_state.dart';
import 'package:todolist/domain/entities/social_comment.dart';

class CommentScreen extends StatefulWidget {
  final int postId;

  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late final TextEditingController _controller;
  late CommentBloc _commentBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _commentBloc = CommentBloc(SocialApiRepository(Dio()));
    _commentBloc.add(FetchComments(widget.postId));
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentBloc.close();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final user = context.read<UserCubit>().state;

    if (user == null) {
      return;
    }

    final newComment = SocialComment(
      postId: widget.postId,
      id: DateTime.now().millisecondsSinceEpoch,
      name: user.name,
      email: user.email,
      body: text,
    );


    _commentBloc.add(MockAddComment(newComment));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _commentBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Comments')),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  if (state is CommentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CommentLoaded) {
                    final comments = state.comments;
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: comments.length,
                      itemBuilder: (context, i) =>
                          _buildCommentItem(comments[i]),
                    );
                  } else if (state is CommentError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Nhập bình luận...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _handleSend,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(SocialComment comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.body),
                const SizedBox(height: 6),
                Text(
                  comment.email,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
