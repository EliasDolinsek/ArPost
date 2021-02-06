import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/app/post/posts_bloc.dart';
import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/presentation/core/app_bar_widget.dart';
import 'package:ar_post/presentation/core/content_widget.dart';
import 'package:ar_post/presentation/posts/user_posts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountSettingsWidget extends StatelessWidget {
  final emailFieldColor = const Color(0xFFF2F2F2);

  @override
  Widget build(BuildContext context) {
    return AppBarListWidget(
      title: "Account",
      children: [
        TitledContentWidget(
          title: "Details",
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.map(
                initial: (value) => _buildNotAuthenticated(),
                authenticated: (value) => _buildEmailField(context, value.user),
                unauthenticated: (value) => _buildNotAuthenticated(),
              );
            },
          ),
        ),
        HeaderContentCard(
          header: "Account actions",
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              ListTile(
                title: const Text("Sign Out"),
                onTap: () =>
                    context.read<AuthBloc>().add(const AuthEvent.signedOut()),
              ),
              const Divider(),
              ListTile(
                title: const Text("Your Posts"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const UserPostsWidget(),
                  ));
                },
              ),
              const SizedBox(height: 8.0)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildEmailField(BuildContext context, User user) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextField(
        controller: TextEditingController()
          ..text = user.emailAddress.getOrCrash(),
        enabled: false,
        style: GoogleFonts.openSans(fontSize: 18),
        decoration: InputDecoration(
          filled: true,
          fillColor: emailFieldColor,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: emailFieldColor),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: emailFieldColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildNotAuthenticated() => const Text("NOT AUTHENTICATED");
}
