part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsEvent with _$ArActionsEvent {
  const factory ArActionsEvent.place() = Place;
  const factory ArActionsEvent.release() = Release;
  const factory ArActionsEvent.capture() = Capture;
}
