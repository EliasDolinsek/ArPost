import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/domain/auth/user.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/presentation/core/arpost_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareImageSheetWidget extends StatelessWidget {
  final ArActionsBloc actionsBloc;
  final AuthBloc authBloc;
  final LocalImage localImage;

  const ShareImageSheetWidget({
    Key key,
    @required this.localImage,
    @required this.actionsBloc,
    @required this.authBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authBloc,
      child: BlocProvider.value(
        value: actionsBloc,
        child: SafeArea(child: BlocBuilder<ArActionsBloc, ArActionsState>(
          builder: (context, state) {
            if (state.action == ArAction.publishing) {
              return _buildPublishing();
            } else if (state.action == ArAction.published) {
              return _buildPublished(context);
            } else {
              return _buildShareWidgets(context);
            }
          },
        )),
      ),
    );
  }

  Widget _buildPublished(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.done, size: 60),
              const SizedBox(height: 8.0),
              Text(
                "Done",
                style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            width: double.infinity,
            child: ArPostButton(
              text: "CLOSE",
              onPressed: () {
                context
                    .read<ArActionsBloc>()
                    .add(const ArActionsEvent.notifyClose());
                Navigator.pop(context);
              },
            ),
          ),
        ),
        const SizedBox(height: 16.0)
      ],
    );
  }

  Widget _buildPublishing() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildShareWidgets(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          "Share Image",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
        const Divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Builder(
              builder: (context) {
                if (localImage.isValid) {
                  return Image.file(localImage.value.getOrElse(() => null));
                } else {
                  return const Center(child: Text("INVALID IMAGE"));
                }
              },
            ),
          ),
        ),
        if (localImage.isValid) ..._getButtons(context),
        const SizedBox(height: 16.0)
      ],
    );
  }

  List<Widget> _getButtons(BuildContext context) {
    return [
      FlatButton.icon(
        onPressed: () {
          context
              .read<ArActionsBloc>()
              .add(const ArActionsEvent.saveImageToGallery());
        },
        icon: const Icon(Icons.get_app),
        label: Text(
          "SAVE LOCALLY",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.map(
                initial: (value) => _buildDisabledShareButton(),
                authenticated: (value) =>
                    _buildEnabledShareButton(context, value.user),
                unauthenticated: (value) => _buildDisabledShareButton(),
              );
            },
          ),
        ),
      )
    ];
  }

  Widget _buildEnabledShareButton(BuildContext context, User user) {
    return ArPostButton(
      text: "SHARE",
      onPressed: () {
        context
            .read<ArActionsBloc>()
            .add(ArActionsEvent.shareImage(user: user));
      },
    );
  }

  Widget _buildDisabledShareButton() {
    return const ArPostButton(text: "SHARE");
  }
}
