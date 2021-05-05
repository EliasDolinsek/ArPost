import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/comments/comment.dart';
import 'package:ar_post/domain/comments/comment_failure.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentFacade {
  Future<Either<CommentFailure, Unit>> publishComment(UniqueId postId, User user, NonEmptyText postText);
  Future<Either<CommentFailure, List<Comment>>> getCommentsOfPost(UniqueId postId);
}