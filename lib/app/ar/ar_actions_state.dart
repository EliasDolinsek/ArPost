part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsState with _$ArActionsState {
  const factory ArActionsState({
    @required ArAction action,
    @required ArObject selectedObject,
    @required Option<LocalImage> image,
  }) = _ArActionsState;

  factory ArActionsState.initial() => ArActionsState(
        action: ArAction.idle,
        selectedObject: ArObject.helloWorldText,
        image: none(),
      );
}

enum ArAction {
  idle,
  placing,
  placed,
  moving,
  capturing,
  captured,
  publishing,
  published,
  releasing
}

enum ArObject {
  helloWorldText,
  file,
}
