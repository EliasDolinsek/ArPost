import 'dart:async';

import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/i_post_facade.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

part 'posts_bloc.freezed.dart';

@Singleton()
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final IPostFacade postFacade;

  PostsBloc(this.postFacade) : super(const PostsState.initial());

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    yield* event.map(
      loadMostRecentPosts: (value) async* {
        yield const PostsState.loading();
        final posts = await postFacade.fetchMostRecentPosts(value.userId);
        yield* posts.fold((l) async* {
          yield const PostsState.postsLoadingFailure();
        }, (r) async* {
          yield PostsState.mostRecentPostsLoaded(r);
        });
      },
      loadUserPosts: (_LoadUserPost value) async* {
        yield const PostsState.loading();
        final posts = await postFacade.fetchUserPosts(value.userId);
        yield* posts.fold((l) async* {
          yield const PostsState.postsLoadingFailure();
        }, (r) async* {
          yield PostsState.userPostsLoaded(r);
        });
      },
      likePost: (_LikePost value) async* {
        final likedPost = await postFacade.likePost(value.postId, value.userId);
        yield* state.map(
          initial: (_) => null,
          mostRecentPostsLoaded: (value) async* {
            yield PostsState.mostRecentPostsLoaded(
                updatePost(value.posts, likedPost.getOrElse(() => null)));
          },
          userPostsLoaded: (value) async* {
            yield PostsState.userPostsLoaded(
                updatePost(value.posts, likedPost.getOrElse(() => null)));
          },
          postsLoadingFailure: (_) => null,
          loading: (_) => null,
        );
      },
    );
  }

  List<Post> updatePost(List<Post> posts, Post update) {
    final updatedPosts = List<Post>.from(posts);
    final index = updatedPosts.indexWhere((element) => element.id == update.id);

    updatedPosts.removeAt(index);
    updatedPosts.insert(index, update);

    return updatedPosts;
  }
}
