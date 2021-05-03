import 'package:ar_post/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    UniqueId id,
    String userEmail,
    NonEmptyText comment,
    DateTime publishDate
  }) = _Comment;
}
