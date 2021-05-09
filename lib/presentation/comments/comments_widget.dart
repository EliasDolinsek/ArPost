import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/comments/comment.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/app/comments/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:separated_column/separated_column.dart';

class CommentsWidget extends StatelessWidget {
  final User user;
  final UniqueId postId;

  const CommentsWidget({
    Key key,
    @required this.postId,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CommentsBloc>()..add(CommentsEvent.load(postId)),
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          if (state.isLoading) return _buildLoading();
          return state.commentsOption.fold(
            () => _buildNoCommentsAvailable(),
            (comments) => _buildCommentsAvailable(context, state, comments),
          );
        },
      ),
    );
  }

  Widget _buildCommentTextField(
    BuildContext context,
    User user,
    CommentsState state,
  ) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => state.commentInput.value.fold(
        (l) => l.maybeMap(
          emptyText: (_) => "Field must not be empty.",
          orElse: () => "Invalid input.",
        ),
        (r) => null,
      ),
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: "Comment"),
      onChanged: (value) => context
          .read<CommentsBloc>()
          .add(CommentsEvent.commentInputChanged(value)),
      onFieldSubmitted: state.commentInput.isValid
          ? (value) => context
              .read<CommentsBloc>()
              .add(CommentsEvent.submit(postId: postId, user: user))
          : null,
    );
  }

  Widget _buildNoCommentsAvailable() {
    return const Padding(
      padding: EdgeInsets.only(top: 64.0),
      child: Center(child: Text("NO COMMENTS AVAILABLE")),
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.only(top: 64.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildCommentsAvailable(
    BuildContext context,
    CommentsState state,
    List<Comment> a,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildCommentTextField(context, user, state),
          const SizedBox(height: 24.0),
          SafeArea(
            child: SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12.0);
              },
              crossAxisAlignment: CrossAxisAlignment.start,
              children: a.map((e) => _commentAsWidget(e)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentAsWidget(Comment comment) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            comment.userEmail,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Text(
            comment.comment.getOrCrash(),
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
