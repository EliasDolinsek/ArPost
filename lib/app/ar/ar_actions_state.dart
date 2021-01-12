part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsState with _$ArActionsState {
  const factory ArActionsState({
    @required bool isPlaced,
    @required bool isCaptured,
  }) = _ArActionsState;

  factory ArActionsState.initial() => const ArActionsState(
        isPlaced: false,
        isCaptured: false,
      );
}
