import 'package:ar_post/app/like_post/like_post_bloc.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/core/content_widget.dart';
import 'package:ar_post/presentation/posts/post_details_page.dart';
import 'package:ar_post/presentation/posts/post_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  final UniqueId userId;
  final Post post;
  final Function onDelete;
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
          builder: (context) =>
              PostDetailsPage(
                post: post,
              ),
        ));
      },
      child: BlocProvider(
        create: (context) =>
        getIt<LikePostBloc>()
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
          _buildPostDetails(context),
        ],
      ),
    );
  }

  Widget _buildPostDetails(BuildContext context) {
    return Padding(
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
          if (likeEnabled) BlocBuilder<LikePostBloc, LikePostState>(
            builder: (context, state) {
              return _buildLikesWidget(context, state);
            },
          ),
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
    );
  }

  Widget _buildLikesWidget(BuildContext context, LikePostState state) {
    return Row(
      children: [
        _buildLikeButton(context, state),
        const SizedBox(width: 8.0),
        Text(
          state.likes.getOrElse(() => 0).toString(),
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context, LikePostState state) {
    return IconButton(
      icon: Icon(
        _getLikeIcon(context, state),
        color: Theme
            .of(context)
            .primaryColor,
      ),
      onPressed: () =>
          context
              .read<LikePostBloc>()
              .add(LikePostEvent.likeToggled(postId: post.id, userId: userId)),
    );
  }

  IconData _getLikeIcon(BuildContext context, LikePostState state) {
    if (state.isLiked.getOrElse(() => false)) {
      return Icons.thumb_up;
    } else {
      return Icons.thumb_up_alt_outlined;
    }
  }
}
