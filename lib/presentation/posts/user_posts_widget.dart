import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/app/user_posts/user_posts_bloc.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/core/app_bar_widget.dart';
import 'package:ar_post/presentation/posts/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPostsWidget extends StatelessWidget {
  const UserPostsWidget();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocProvider(
        create: (context) => getIt<UserPostsBloc>(),
        child: AppBarWidget(
          title: "Your Posts",
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.map(
                initial: (value) => Container(),
                authenticated: (value) => _buildUserPosts(value.user.id),
                unauthenticated: (value) => _buildLoading(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUserPosts(UniqueId userId) {
    return BlocBuilder<UserPostsBloc, UserPostsState>(
      builder: (context, state) {
        return state.map(
          failure: (_) => _buildError(),
          initial: (_) => _buildLoadingAndRequestPosts(context, userId),
          loaded: (LoadedUserPostsState value) =>
              _buildUserPostsLoaded(value.posts),
          loading: (_) => _buildLoading(),
        );
      },
    );
  }

  Widget _buildUserPostsLoaded(List<Post> posts) {
    return SpacedListWidget(
      children: posts.map((e) => PostWidget(post: e, deletable: true)).toList(),
    );
  }

  Widget _buildLoadingAndRequestPosts(BuildContext context, UniqueId userId) {
    final postsBloc = BlocProvider.of<UserPostsBloc>(context);
    postsBloc.add(UserPostsEvent.load(userId: userId));
    return _buildLoading();
  }

  Widget _buildError() {
    return const Center(child: Text("AN ERROR OCCURRED"));
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
