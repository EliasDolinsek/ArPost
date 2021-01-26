part of 'posts_bloc.dart';

@freezed
abstract class PostsState with _$PostsState {
  const factory PostsState.initial() = _Initial;

  const factory PostsState.mostRecentPostsLoaded(List<Post> posts) =
      PostsLoaded;

  const factory PostsState.userPostsLoaded(List<Post> posts) = UserPostsLoaded;

  const factory PostsState.postsLoadingFailure() = PostsLoadingFailure;

  const factory PostsState.loading() = Loading;
}
