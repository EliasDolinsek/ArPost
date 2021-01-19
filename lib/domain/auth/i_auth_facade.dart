import 'package:ar_post/domain/auth/auth_failure.dart';
import 'package:ar_post/domain/auth/user.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<Option<User>> getSignedInUser();

  Future<void> signOut();
}
