import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/app/post/posts_bloc.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/presentation/core/content_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final bool deletable;

  const PostWidget({Key key, this.post, this.deletable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentWidget(
      child: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post.imageUrl),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  post.userEmail,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Expanded(child: Container()),
                _buildLikesWidget(context),
                if (deletable)
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => context
                        .read<PostsBloc>()
                        .add(PostsEvent.deletePost(postId: post.id)),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLikesWidget(BuildContext context) {
    return Row(
      children: [
        _buildLikeButton(),
        const SizedBox(width: 8.0),
        Text(
          post.likes.toString(),
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildLikeButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          authenticated: (value) {
            return IconButton(
              icon: Icon(
                _getLikeIcon(),
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                context.read<PostsBloc>().add(PostsEvent.likePost(
                    userId: value.user.id, postId: post.id));
              },
            );
          },
          unauthenticated: (_) => Container(),
        );
      },
    );
  }

  IconData _getLikeIcon() {
    if (post.liked) {
      return Icons.thumb_up;
    } else {
      return Icons.thumb_up_alt_outlined;
    }
  }
}
