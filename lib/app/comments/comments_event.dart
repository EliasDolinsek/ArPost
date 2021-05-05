part of 'comments_bloc.dart';

@freezed
abstract class CommentsEvent with _$CommentsEvent {
  const factory CommentsEvent.load(UniqueId postId) = Load;
}
