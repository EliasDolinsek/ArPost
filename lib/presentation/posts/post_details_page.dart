import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/presentation/core/app_bar_widget.dart';
import 'package:ar_post/presentation/posts/post_image.dart';
import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarListWidget(
      title: 'Post Details',
      children: [_buildImageStack()],
    );
  }

  Widget _buildImageStack() {
    return Stack(
      children: [
        PostImage(imageUrl: post.imageUrl),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildPostPublisherDetails(),
          ),
        )
      ],
    );
  }

  Widget _buildPostPublisherDetails(){
    return Row(
      children: [
        Text(post.userEmail)
      ],
    );
  }
}
