import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/presentation/comments/comments_widget.dart';
import 'package:ar_post/presentation/core/app_bar_widget.dart';
import 'package:ar_post/presentation/posts/post_image.dart';
import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      title: 'Post Details',
      child: Column(
        children: [
          PostImage(imageUrl: post.imageUrl),
          CommentsWidget(postId: post.id,)
        ],
      ),
    );
  }
}
