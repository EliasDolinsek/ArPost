import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/app/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/account/unauthenticated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountWidget extends StatelessWidget {

  const AccountWidget();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInFormBloc>(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.map(
            initial: (value){
              return Text("INITIAL");
            },
            authenticated: (value) {
              return Text("Authenticated");
            },
            unauthenticated: (value) {
              return UnauthenticatedWidget();
            },
          );
        },
      ),
    );
  }
}
