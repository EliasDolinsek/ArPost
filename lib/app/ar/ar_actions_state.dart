part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsState with _$ArActionsState {
  const factory ArActionsState({
    @required ArAction action,
    @required Option<LocalImage> image,
    @required Option<TurnDirection> direction,
  }) = _ArActionsState;

  factory ArActionsState.initial() =>
      ArActionsState(action: ArAction.idle, image: none(), direction: none());
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
