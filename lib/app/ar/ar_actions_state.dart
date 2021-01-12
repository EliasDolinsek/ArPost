part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsState with _$ArActionsState {
  const factory ArActionsState({
    @required bool isPlaced,
    @required bool isCaptured,
    @required File image,
  }) = _ArActionsState;

  factory ArActionsState.initial() => ArActionsState(
        isPlaced: false,
        isCaptured: false,
        image: null,
      );
}
