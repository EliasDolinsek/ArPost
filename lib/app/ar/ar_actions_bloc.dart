import 'dart:async';
import 'dart:io';

import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/post/i_post_facade.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:native_screenshot/native_screenshot.dart';

part 'ar_actions_event.dart';

part 'ar_actions_state.dart';

part 'ar_actions_bloc.freezed.dart';

@injectable
class ArActionsBloc extends Bloc<ArActionsEvent, ArActionsState> {
  final IPostFacade postFacade;

  ArActionsBloc(this.postFacade) : super(ArActionsState.initial());

  @override
  Stream<ArActionsState> mapEventToState(
    ArActionsEvent event,
  ) async* {
    yield* event.map(
      place: (_Place value) async* {
        yield state.copyWith(action: ArAction.placing);
      },
      release: (_Release value) async* {
        yield state.copyWith(action: ArAction.releasing);
      },
      capture: (_Capture value) async* {
        yield state.copyWith(action: ArAction.capturing);
        Future.delayed(const Duration(milliseconds: 200), _captureImage);
      },
      notifyPlaced: (_NotifyPlaced value) async* {
        yield state.copyWith(action: ArAction.placed);
      },
      notifyReleased: (_NotifyRelesed value) async* {
        yield state.copyWith(action: ArAction.idle);
      },
      notifyCaptured: (_NotifyCaptured value) async* {
        yield state.copyWith(
          action: ArAction.captured,
          image: some(value.file),
        );
      },
      saveImageToGallery: (_ImageSaveToGallery value) async* {
        yield state.copyWith(action: ArAction.publishing);
        await postFacade.savePostLocally(state.image.getOrElse(() => null));
        yield state.copyWith(action: ArAction.published, image: none());
      },
      notifyClose: (_NotifyClose value) async* {
        yield state.copyWith(action: ArAction.placed, image: none());
      },
      shareImage: (_ShareImage value) async* {
        yield state.copyWith(action: ArAction.publishing);
        await postFacade.publishPost(
            value.user, state.image.getOrElse(() => null));
        yield state.copyWith(action: ArAction.published, image: none());
      },
    );
  }

  Future _captureImage() async {
    final path = await NativeScreenshot.takeScreenshot();
    final image = LocalImage(File(path));
    add(ArActionsEvent.notifyCaptured(file: image));
  }
}
