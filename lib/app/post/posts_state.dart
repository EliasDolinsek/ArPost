part of 'posts_bloc.dart';

@freezed
abstract class PostsState {
  const factory PostsState.initial() = _Initial;
  const factory PostsState.postsLoaded(List<Post> posts) = _PostsLoaded;
  const factory PostsState.postsLoadingFailure() = _PostsLoadingFailure;
  const factory PostsState.loading() = _Loading;
}

