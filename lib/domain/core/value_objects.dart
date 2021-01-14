import 'dart:io';
import 'dart:typed_data';

import 'package:ar_post/domain/core/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

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

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(right(Uuid().v1()));
  }

  factory UniqueId.fromUniqueString(String value) {
    assert(value != null);
    return UniqueId._(right(value));
  }

  const UniqueId._(this.value);
}

class CachedImage extends ValueObject<Uint8List> {
  @override
  final Either<ValueFailure<Uint8List>, Uint8List> value;

  factory CachedImage(Uint8List image) {
    assert(image != null);
    return CachedImage._(right(image));
  }

  const CachedImage._(this.value);
}
