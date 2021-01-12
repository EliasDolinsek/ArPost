part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsEvent with _$ArActionsEvent {
  const factory ArActionsEvent.place() = _Place;

  const factory ArActionsEvent.release() = _Release;

  const factory ArActionsEvent.capture() = _Capture;

  const factory ArActionsEvent.submitImageFile({@required File file}) =
      _SubmitImage;
}
