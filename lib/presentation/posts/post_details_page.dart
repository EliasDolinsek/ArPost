import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/comments/comments_widget.dart';
import 'package:ar_post/presentation/core/app_bar_widget.dart';
import 'package:ar_post/presentation/posts/post_details_widget.dart';
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
          const SizedBox(height: 16.0),
          Stack(
            children: [
              Material(
                elevation: 3,
                child: PostImage(imageUrl: post.imageUrl),
              ),
              _buildPostDetails(user.id),
            ],
          ),
          CommentsWidget(
            postId: post.id,
            user: user,
          )
        ],
      ),
    );
  }

  Widget _buildPostDetails(UniqueId userId) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
          ),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: PostDetailsWidget(
                post: post,
                userId: userId,
                likeEnabled: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotAuthenticated() {
    return const Expanded(child: Center(child: Text("NOT AUTHENTICATED")));
  }
}
