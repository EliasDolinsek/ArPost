part of 'posts_bloc.dart';

@freezed
abstract class PostsEvent with _$PostsEvent {
  const factory PostsEvent.load({@required UniqueId userId}) =
      _LoadMostRecentPosts;

  const factory PostsEvent.likePost(
      {@required UniqueId userId, @required UniqueId postId}) = _LikePost;
}
