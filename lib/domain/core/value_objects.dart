import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  bool get isValid => value.isRight();

  @override
  String toString() => "Value($value)";

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject && o.value == this.value;
  }

  @override
  int get hashCode => value.hashCode;
}
