import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/comments/comments_widget.dart';
import 'package:ar_post/presentation/core/app_bar_widget.dart';
import 'package:ar_post/presentation/posts/post_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: AppBarWidget(
        title: 'Post Details',
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return state.maybeMap(
              authenticated: (value) => _buildContent(value.user),
              orElse: () => _buildNotAuthenticated(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(User user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PostImage(imageUrl: post.imageUrl),
          CommentsWidget(
            postId: post.id,
            user: user,
          )
        ],
      ),
    );
  }

  Widget _buildNotAuthenticated() {
    return const Expanded(child: Center(child: Text("NOT AUTHENTICATED")));
  }
}
