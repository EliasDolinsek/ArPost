import 'package:ar_post/domain/auth/auth_failure.dart';
import 'package:ar_post/domain/auth/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registertWithEmailAndPassword({
    @required EmailAddress address,
    @required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress address,
    @required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
