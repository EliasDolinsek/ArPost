import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/app/post/posts_bloc.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/presentation/posts/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => _buildNotAuthenticated(),
            authenticated: (value) => _buildFeed(context, value.user.id),
            unauthenticated: (_) => _buildNotAuthenticated(),
          );
        },
      ),
    );
  }

  Widget _buildFeed(BuildContext context, UniqueId userId) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => _buildLoadingAndRequestPosts(context, userId),
          mostRecentPostsLoaded: (value) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostsBloc>().add(PostsEvent.load(userId: userId));
              },
              child: ListView.separated(
                itemCount: value.posts.length,
                itemBuilder: (context, index) {
                  final post = value.posts[index];
                  return PostWidget(
                    post: post,
                    onLike: () {
                      context.read<PostsBloc>().add(
                            PostsEvent.likePost(
                              postId: post.id,
                              userId: userId,
                            ),
                          );
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 32.0),
              ),
            );
          },
          postsLoadingFailure: (_) => _buildFailure(),
          loading: (_) => _buildLoading(),
          userPostsLoaded: (UserPostsLoaded value) =>
              _buildLoadingAndRequestPosts(context, userId),
        );
      },
    );
  }

  Widget _buildLoadingAndRequestPosts(BuildContext context, UniqueId userId) {
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(PostsEvent.load(userId: userId));
    return _buildLoading();
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildNotAuthenticated() {
    return const Center(child: Text("SIGN IN TO USE FEED"));
  }

  Widget _buildFailure() {
    return const Center(child: Text("AN ERROR OCCURRED"));
  }
}
