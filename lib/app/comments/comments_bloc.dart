import 'dart:async';

import 'package:ar_post/domain/comments/comment.dart';
import 'package:ar_post/domain/comments/i_comment_facade.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'comments_event.dart';

part 'comments_state.dart';

part 'comments_bloc.freezed.dart';

@injectable
class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final ICommentFacade _commentFacade;

  CommentsBloc(this._commentFacade) : super(CommentsState.initial());

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    yield* event.map(
      load: (value) async* {
        yield state.copyWith(isLoading: true);
        final result = await _commentFacade.getCommentsOfPost(value.postId);
        yield result.fold((l) => state.copyWith(isLoading: false), (r) {
          return state.copyWith(isLoading: false, commentsOption: some(r));
        });
      },
    );
  }
}
