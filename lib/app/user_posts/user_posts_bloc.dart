import 'dart:async';

import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/i_post_facade.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'user_posts_event.dart';
part 'user_posts_state.dart';
part 'user_posts_bloc.freezed.dart';

@injectable
class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  final IPostFacade postFacade;

  UserPostsBloc(this.postFacade) : super(const UserPostsState.initial());
  @override
  Stream<UserPostsState> mapEventToState(
    UserPostsEvent event,
  ) async* {
    yield* event.map(
      load: (_Load value) async* {
        yield const UserPostsState.loading();
        final posts = await postFacade.fetchUserPosts(value.userId);
        yield* posts.fold((_) async* {
          yield const UserPostsState.failure();
        }, (r) async* {
          yield UserPostsState.loaded(r);
        });
      },
      deletePost: (_Delete event) async* {
        await postFacade.deletePost(event.postId);
        yield* state.map(
          failure: (FailureUserPostsState value) => null,
          initial: (InitialUserPostsState value) => null,
          loaded: (LoadedUserPostsState value) async* {
            yield UserPostsState.loaded(removePost(value.posts, event.postId));
          },
          loading: (LoadingUserPostsState value) => null,
        );
      },
    );
  }

  List<Post> removePost(List<Post> posts, UniqueId postId) {
    return List<Post>.from(posts)..removeWhere((p) => p.id == postId);
  }
}
