import 'dart:async';

import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/i_post_facade.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'like_post_event.dart';

part 'like_post_state.dart';

part 'like_post_bloc.freezed.dart';

@singleton
class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  final IPostFacade _postFacade;

  LikePostBloc(this._postFacade) : super(LikePostState.initial());

  @override
  Stream<LikePostState> mapEventToState(
    LikePostEvent event,
  ) async* {
    yield* event.map(
      loadLiked: (value) async* {
        final post = await _postFacade.getPost(value.postId, value.userId);
        yield post.fold(
          (l) => state.copyWith(isLiked: none(), likes: none()),
          (r) => state.copyWith(
            postId: some(value.postId),
            isLiked: optionOf(r.liked),
            likes: optionOf(r.likes),
          ),
        );
      },
      likeToggled: (value) async* {
        final result = await _postFacade.likePost(value.postId, value.userId);
        yield result.fold(
          (l) => state.copyWith(isLiked: none(), likes: none()),
          (r) => state.copyWith(
            isLiked: optionOf(r.liked),
            likes: optionOf(r.likes),
          ),
        );
      },
    );
  }
}
