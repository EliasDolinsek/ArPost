import 'package:ar_post/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    UniqueId commentId,
    UniqueId postId,
    String userEmail,
    NonEmptyText comment,
    DateTime publishDate
  }) = _Comment;
}
