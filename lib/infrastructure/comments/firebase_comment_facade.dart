import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/comments/comment.dart';
import 'package:ar_post/domain/comments/comment_failure.dart';
import 'package:ar_post/domain/comments/i_comment_facade.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICommentFacade)
class FirebaseCommentFacade implements ICommentFacade {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseCommentFacade(this._firebaseFirestore);

  @override
  Future<Either<CommentFailure, Unit>> publishComment(
      UniqueId postId, User user, NonEmptyText postText) async {
    _firebaseFirestore.collection("comments").doc(UniqueId().getOrCrash()).set({
      "userId": user.id.getOrCrash(),
      "userEmail": user.emailAddress.getOrCrash(),
      "postId": postId.getOrCrash(),
      "text": postText.getOrCrash(),
      "publishDate": DateTime.now(),
    });

    return right(unit);
  }

  @override
  Future<Either<CommentFailure, List<Comment>>> getCommentsOfPost(
    UniqueId postId,
  ) async {
    final snapshot = await _firebaseFirestore
        .collection("comments")
        .where("postId", isEqualTo: postId.getOrCrash())
        .orderBy("publishDate", descending: true)
        .get();

    final result = snapshot.docs.map((e) {
      return _commentFromData(e.id, e.data());
    }).toList();

    return right(result);
  }

  Comment _commentFromData(String commentId, Map<String, dynamic> data) {
    return Comment(
      userEmail: data["userEmail"] as String,
      comment: NonEmptyText(data["text"] as String),
      commentId: UniqueId.fromUniqueString(commentId),
      postId: UniqueId.fromUniqueString("postId"),
      publishDate: data["publishDate"].toDate() as DateTime,
    );
  }
}
