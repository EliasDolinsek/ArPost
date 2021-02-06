part of 'user_posts_bloc.dart';

@freezed
abstract class UserPostsEvent with _$UserPostsEvent {
  const factory UserPostsEvent.load({@required UniqueId userId}) = _Load;

  const factory UserPostsEvent.deletePost({@required UniqueId postId}) =
      _Delete;
}
