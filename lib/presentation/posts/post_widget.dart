import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/presentation/core/content_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentWidget(
      child: Column(
        children: [
          Container(
            height: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post.imageUrl), fit: BoxFit.fitWidth)),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.userEmail,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                _buildLikesWidget(context),
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
        Icon(
          _getLikeIcon(),
          color: Theme.of(context).primaryColor,
        ),
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

  IconData _getLikeIcon() {
    if (post.liked) {
      return Icons.thumb_up;
    } else {
      return Icons.thumb_up_alt_outlined;
    }
  }
}
