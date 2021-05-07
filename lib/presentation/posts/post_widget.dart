import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/presentation/core/content_widget.dart';
import 'package:ar_post/presentation/posts/post_details_page.dart';
import 'package:ar_post/presentation/posts/post_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function onDelete, onLike;

  const PostWidget({
    Key key,
    this.post,
    this.onDelete,
    this.onLike,
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
      child: ContentWidget(
        child: Column(
          children: [
            PostImage(imageUrl: post.imageUrl),
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
                  if (onLike != null) _buildLikesWidget(context),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => onDelete(),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLikesWidget(BuildContext context) {
    return Row(
      children: [
        _buildLikeButton(context),
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

  Widget _buildLikeButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        _getLikeIcon(),
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () => onLike(),
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
