import 'dart:async';

import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/i_post_facade.dart';
import 'package:ar_post/domain/post/post.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

part 'posts_bloc.freezed.dart';

@injectable
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
           yield PostsState.postsLoaded(r);
         });
      },
    );
  }
}
