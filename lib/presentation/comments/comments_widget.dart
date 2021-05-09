import 'package:ar_post/domain/comments/comment.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/app/comments/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsWidget extends StatelessWidget {
  final UniqueId postId;

  const CommentsWidget({Key key, @required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<CommentsBloc>()
        ..add(CommentsEvent.load(postId)),
      child: Column(
        children: [
          _buildCommentTextField(),
          _buildCommentsList(),
        ],
      ),
    );
  }

  Widget _buildCommentsList() {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state.isLoading) return _buildLoading();
        return state.commentsOption.fold(
              () => _buildNoCommentsAvailable(),
              (a) => _buildCommentsAvailable(a),
        );
      },
    );
  }

  Widget _buildCommentTextField() {
  }

  Widget _buildNoCommentsAvailable() {
    return const Expanded(child: Center(child: Text("NO COMMENTS AVAILABLE")));
  }

  Widget _buildLoading() {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildCommentsAvailable(List<Comment> a) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: a.map((e) => _commentAsWidget(e)).toList(),
    );
  }

  Widget _commentAsWidget(Comment comment) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [Text(comment.userEmail), Text(comment.comment.getOrCrash())],
    );
  }
}
