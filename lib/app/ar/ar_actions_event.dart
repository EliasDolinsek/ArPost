part of 'ar_actions_bloc.dart';

@freezed
abstract class ArActionsEvent with _$ArActionsEvent {
  const factory ArActionsEvent.place() = _Place;

  const factory ArActionsEvent.notifyPlaced() = _NotifyPlaced;

  const factory ArActionsEvent.capture() = _Capture;

  const factory ArActionsEvent.notifyCaptured({@required LocalImage file}) =
      _NotifyCaptured;

  const factory ArActionsEvent.release() = _Release;

  const factory ArActionsEvent.notifyReleased() = _NotifyRelesed;

  const factory ArActionsEvent.saveImageToGallery() = _ImageSaveToGallery;

  const factory ArActionsEvent.shareImage({@required UniqueId userId}) =
      _ShareImage;

  const factory ArActionsEvent.notifyPublishedAcknowledged() =
      _NotifyPublishedAcknowledged;
}
