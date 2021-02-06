part of 'user_posts_bloc.dart';

@freezed
abstract class UserPostsState with _$UserPostsState {
  const factory UserPostsState.initial() = InitialUserPostsState;
  const factory UserPostsState.loaded(List<Post> posts) = LoadedUserPostsState;
  const factory UserPostsState.loading() = LoadingUserPostsState;
  const factory UserPostsState.failure() = FailureUserPostsState;
}
