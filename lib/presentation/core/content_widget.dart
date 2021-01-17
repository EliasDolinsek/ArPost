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
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 16.0),
            child,
          ],
        ),
      ),
    );
  }
}
