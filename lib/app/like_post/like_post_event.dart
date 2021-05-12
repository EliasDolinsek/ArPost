part of 'like_post_bloc.dart';

@freezed
abstract class LikePostEvent with _$LikePostEvent {
  const factory LikePostEvent.loadLiked({
    @required UniqueId postId,
    @required UniqueId userId,
  }) = LoadLiked;

  const factory LikePostEvent.likeToggled({
    @required UniqueId postId,
    @required UniqueId userId,
  }) = LikeToggled;
}
