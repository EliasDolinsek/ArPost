import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({@required String failedValue}) =
      InvalidEmail<T>;
  const factory ValueFailure.shortPassword({@required String password}) =
      ShortPassword<T>;
  const factory ValueFailure.shortUsername({@required String username}) =
      ShortUsername<T>;
  const factory ValueFailure.longUsername({@required String username}) =
      LongUsername<T>;
}
