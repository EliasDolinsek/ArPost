part of 'comments_bloc.dart';

@freezed
abstract class CommentsState with _$CommentsState {
  const factory CommentsState({
    @required NonEmptyText commentInput,
    @required bool isLoading,
    @required Option<List<Comment>> commentsOption,
  }) = _CommentsState;

  factory CommentsState.initial() => CommentsState(
        commentInput: NonEmptyText(""),
        isLoading: false,
        commentsOption: none(),
      );
}
