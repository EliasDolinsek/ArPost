import 'dart:io';

import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:ar_post/presentation/core/arpost_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareImageSheetWidget extends StatelessWidget {
  final ArActionsBloc actionsBloc;
  final File imageFile;

  const ShareImageSheetWidget({
    Key key,
    @required this.imageFile,
    @required this.actionsBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
              child: Image.file(imageFile),
            ),
          ),
          FlatButton.icon(
            onPressed: () {
              actionsBloc.add(const ArActionsEvent.saveImageToGallery());
              actionsBloc.add(const ArActionsEvent.release());
              Navigator.pop(context);
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
              child: ArPostButton(
                text: "SHARE",
                onPressed: () => print("SHARE"),
              ),
            ),
          ),
          const SizedBox(height: 16.0)
        ],
      ),
    );
  }
}
