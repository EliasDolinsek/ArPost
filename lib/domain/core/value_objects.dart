import 'package:ar_post/domain/core/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  T getOrCrash() {
    return value.fold((failure) => throw UnexpectedValueError(failure), id);
  }

  bool get isValid => value.isRight();

  @override
  String toString() => "Value($value)";

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
