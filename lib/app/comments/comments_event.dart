part of 'comments_bloc.dart';

@freezed
abstract class CommentsEvent with _$CommentsEvent {
  const factory CommentsEvent.load(UniqueId postId) = Load;

  const factory CommentsEvent.commentInputChanged(String input) =
      CommentInputChanged;

  const factory CommentsEvent.submit({
    @required UniqueId postId,
    @required User user,
  }) = Submit;
}
