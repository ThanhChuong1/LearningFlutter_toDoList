import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/domain/entities/cubit/user_cubit.dart';
import 'package:todolist/domain/entities/social_user.dart';
import 'package:todolist/presentation/modules/social/comment/view/comment_screen.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_bloc.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_event.dart';
import 'package:todolist/presentation/modules/social/post_list/bloc/post_state.dart';
import 'package:todolist/route/route_list.dart';

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

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Thông báo"),
        content: const Text("Bạn chưa đăng nhập."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Back"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RouteList.login);
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text("List Posts")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                final user = state.users.firstWhere(
                  (u) => u.id == post.userId,
                  orElse: () => SocialUser(
                    id: 0,
                    name: "Unknown",
                    username: "",
                    email: "",
                  ),
                );

                final avatarUrl = "https://i.pravatar.cc/150?u=${user.id}";

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar + Name
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(avatarUrl),
                              ),
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

                          // Title
                          Text(
                            post.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Body
                          Text(post.body),
                          const SizedBox(height: 12),

                          // Button
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                if (currentUser == null) {
                                  _showLoginDialog(context);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CommentScreen(postId: post.id),
                                    ),
                                  );
                                }
                              },

                              icon: const Icon(Icons.comment),
                              label: const Text("Comment"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
