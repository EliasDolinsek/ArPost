import 'package:ar_post/app/like_post/like_post_bloc.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/core/content_widget.dart';
import 'package:ar_post/presentation/posts/post_details_page.dart';
import 'package:ar_post/presentation/posts/post_details_widget.dart';
import 'package:ar_post/presentation/posts/post_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostWidget extends StatelessWidget {
  final UniqueId userId;
  final Post post;
  final VoidCallback onDelete;
  final bool likeEnabled;

  const PostWidget({
    Key key,
    this.userId,
    this.post,
    this.onDelete,
    this.likeEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostDetailsPage(
            post: post,
          ),
        ));
      },
      child: BlocProvider(
        create: (context) => getIt<LikePostBloc>()
          ..add(LikePostEvent.loadLiked(postId: post.id, userId: userId)),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ContentWidget(
      child: Column(
        children: [
          PostImage(imageUrl: post.imageUrl),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: PostDetailsWidget(
              post: post,
              userId: userId,
              likeEnabled: likeEnabled,
              onDelete: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
