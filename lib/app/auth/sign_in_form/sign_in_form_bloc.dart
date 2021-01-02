import 'dart:async';

import 'package:ar_post/domain/auth/i_auth_facade.dart';
import 'package:ar_post/domain/auth/auth_failure.dart';
import 'package:ar_post/domain/auth/value_objects.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    yield* event.map(emailChanged: (e) async* {
      yield state.copyWith(
        emailAddress: EmailAddress(e.email),
        authFailureOrSuccessOption: none(),
      );
    }, passwordChanged: (e) async* {
      yield state.copyWith(
        password: Password(e.password),
        authFailureOrSuccessOption: none(),
      );
    }, registerWithEmailAndPassword: (e) async* {
      yield* _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.registertWithEmailAndPassword);
    }, signInWithEmailAndPassword: (e) async* {
      yield* _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.signInWithEmailAndPassword);
    }, signInWithGoogle: (e) async* {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      final result = await _authFacade.signInWithGoogle();

      yield state.copyWith(
        isSubmitting: false,
        authFailureOrSuccessOption: some(result),
      );
    });
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
      Future<Either<AuthFailure, Unit>> Function({
    @required EmailAddress address,
    @required Password password,
  })
          authFacadeAction) async* {
    final isEmailValid = state.emailAddress.isValid;
    final isPasswordValid = state.password.isValid;

    Either<AuthFailure, Unit> failureOrSuccess;

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await authFacadeAction(
        address: state.emailAddress,
        password: state.password,
      );
    }

    yield state.copyWith(
      showErrorMessages: false,
      isSubmitting: true,
      authFailureOrSuccessOption: optionOf(failureOrSuccess),
    );
  }
}
