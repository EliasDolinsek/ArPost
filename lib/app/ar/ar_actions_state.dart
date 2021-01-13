part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsState with _$ArActionsState {
  const factory ArActionsState({
    @required ArAction action,
    @required Option<File> image,
  }) = _ArActionsState;

  factory ArActionsState.initial() => ArActionsState(
        action: ArAction.idle,
        image: none(),
      );
}

enum ArAction { idle, placing, placed, capturing, captured, releasing }
