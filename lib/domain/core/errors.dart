import 'package:ar_post/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure failure;

  UnexpectedValueError(this.failure);

  @override
  String toString() => Error.safeToString(
      "Encountered a ValueFailure at an unrecoverable point.\n$failure");
}
