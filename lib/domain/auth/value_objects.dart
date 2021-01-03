import 'package:ar_post/domain/core/failures.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/domain/core/value_validators.dart';
import 'package:dartz/dartz.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}

class URL extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory URL(String url) {
    assert(url != null);
    return URL._(right(url));
  }
  const URL._(this.value);
}
