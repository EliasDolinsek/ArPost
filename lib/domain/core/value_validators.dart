import 'package:dartz/dartz.dart';

import 'failures.dart';

Either<ValueFailure<String>, String> validateEmailAddress(String value) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if (RegExp(emailRegex).hasMatch(value)) {
    return right(value);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: value));
  }
}

Either<ValueFailure<String>, String> validatePassword(String value) {
  if (value.length < 6) {
    return Left(ShortPassword(password: value));
  } else {
    return Right(value);
  }
}

Either<ValueFailure<String>, String> validateNonEmptyText(String text) {
  if(text == null || text.trim().isEmpty){
    return left(ValueFailure.emptyText(text: text));
  } else {
    return right(text);
  }
}