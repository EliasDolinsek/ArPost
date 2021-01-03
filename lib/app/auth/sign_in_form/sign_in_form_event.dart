part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String email) = EmailChanged;
  const factory SignInFormEvent.passwordChanged(String password) =
      PasswordChanged;
  const factory SignInFormEvent.registerWithEmailAndPassword(
      String email, String password) = RegisterWithEmailAndPassword;
  const factory SignInFormEvent.signInWithEmailAndPassword(
      String email, String password) = SignInWithEmailAndPassword;
  const factory SignInFormEvent.signInWithGoogle() = SignInWithGoogle;
}
