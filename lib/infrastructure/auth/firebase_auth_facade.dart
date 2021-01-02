import 'package:ar_post/domain/auth/auth_failure.dart';
import 'package:ar_post/domain/auth/i_auth_facade.dart';
import 'package:dartz/dartz.dart';
import 'package:ar_post/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registertWithEmailAndPassword(
      {@required EmailAddress address, @required password}) async {
    final emailStr = address.getOrCrash();
    final passwordStr = address.getOrCrash();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == "email-already-in-use") {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required EmailAddress address, @required Password password}) async {
    final emailStr = address.getOrCrash();
    final passwordStr = address.getOrCrash();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == "wrong-password") {
        return left(const AuthFailure.emailAlreadyInUse());
      } else if (e.code == "wrong-password" || e.code == "user-not-found") {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    final user = await _googleSignIn.signIn();
    if (user == null) {
      return left(const AuthFailure.cancelledByUser());
    }

    final authentication = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );

    return _firebaseAuth
        .signInWithCredential(credential)
        .then((_) => right(unit))
        .catchError(
          (_) => left(const AuthFailure.serverError()),
        );
  }
}
