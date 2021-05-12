import 'package:ar_post/app/like_post/like_post_bloc.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/core/content_widget.dart';
import 'package:ar_post/presentation/posts/post_details_page.dart';
import 'package:ar_post/presentation/posts/post_details_widget.dart';
import 'package:ar_post/presentation/posts/post_image.dart';
import 'package:flutter/material.dart';

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
    final likePostBloc = getIt<LikePostBloc>();
    return GestureDetector(
      onTap: () => onPostTapped(context, likePostBloc),
      child: _buildContent(context, likePostBloc),
    );
  }

  Future onPostTapped(BuildContext context, LikePostBloc likePostBloc) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PostDetailsPage(
        post: post,
      ),
    ));

    likePostBloc.add(LikePostEvent.loadLiked(postId: post.id, userId: userId));
  }

  Widget _buildContent(BuildContext context, LikePostBloc likePostBloc) {
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
              likePostBloc: likePostBloc,
            ),
          ),
        ],
      ),
    );
  }
}
