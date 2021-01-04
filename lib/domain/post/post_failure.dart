import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_failure.freezed.dart';

@freezed
abstract class PostFailure with _$PostFailure {
  const factory PostFailure.networkFailure() = NetworkFailure;
  const factory PostFailure.serverError() = ServerError;
}
