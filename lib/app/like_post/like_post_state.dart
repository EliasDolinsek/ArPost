part of 'like_post_bloc.dart';

@freezed
abstract class LikePostState with _$LikePostState {
  const factory LikePostState({
    @required Option<UniqueId> postId,
    @required Option<bool> isLiked,
    @required Option<int> likes,
  }) = _LikePostState;

  factory LikePostState.initial() => LikePostState(
        postId: none(),
        isLiked: none(),
        likes: none(),
      );
}
