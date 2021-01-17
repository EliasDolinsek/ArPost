import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/app/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:ar_post/presentation/core/arpost_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UnauthenticatedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "JOIN THE SOCIAL FEED",
                style: GoogleFonts.openSans(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Text(
                "Share posts and explore the community after you signed in.",
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              _buildSingInActions(context),
              const SizedBox(height: 200)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingInActions(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(() => null, (a) {
          context.read<AuthBloc>().add(const AuthEvent.authCheckRequested());
        });
      },
      builder: (context, state) {
        if (state.isSubmitting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (state.showErrorMessages &&
              state.authFailureOrSuccessOption.isSome()) {
            return Text(
              "AN ERROR OCCURRED - TRY AGAIN LATER",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600, color: Colors.red, fontSize: 14),
              textAlign: TextAlign.center,
            );
          }
          return _buildSignInButton(context);
        }
      },
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ArPostButton(
        text: "SIGN IN WITH GOOGLE",
        onPressed: () {
          context
              .read<SignInFormBloc>()
              .add(const SignInFormEvent.signInWithGoogle());
        },
      ),
    );
  }
}
