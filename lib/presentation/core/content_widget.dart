import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentWidget extends StatelessWidget {
  final Widget child;

  const ContentWidget({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: child,
      ),
    );
  }
}

class TitledContentWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const TitledContentWidget({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 32.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.openSans(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16.0),
            child,
          ],
        ),
      ),
    );
  }
}

class HeaderContentCard extends StatelessWidget {
  final String header;
  final Widget child;

  const HeaderContentCard({
    Key key,
    @required this.header,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            header,
            textAlign: TextAlign.start,
            style:
                GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        const SizedBox(height: 16.0),
        ContentWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
            ),
            child: child,
          ),
        )
      ],
    );
  }
}
