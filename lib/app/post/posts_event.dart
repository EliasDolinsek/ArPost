part of 'posts_bloc.dart';

@freezed
abstract class PostsEvent with _$PostsEvent {
  const factory PostsEvent.loadMostRecentPosts({@required UniqueId userId}) =
      _LoadMostRecentPosts;

  const factory PostsEvent.loadUserPosts({@required UniqueId userId}) =
      _LoadUserPost;
}
