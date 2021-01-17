import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArPostButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;

  const ArPostButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Theme.of(context).primaryColor,
      splashColor: Theme.of(context).primaryColorLight,
      onPressed: onPressed,
      textStyle: GoogleFonts.openSans(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(text.toUpperCase()),
      ),
    );
  }
}
