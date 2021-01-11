import 'package:flutter/material.dart';

class ArControlsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ArButton(iconData: Icons.push_pin),
          ],
        ),
      ),
    );
  }
}

class ArButton extends StatelessWidget {
  final IconData iconData;

  const ArButton({Key key, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 94,
          height: 94,
          child: CustomPaint(painter: CirclePaint(context)),
        ),
        SizedBox(
          width: 92,
          height: 92,
          child: IconButton(
            icon: Center(
              child: Icon(
                iconData,
                size: 38,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () => print("AR BUTTON CLICKED"),
          ),
        ),
      ],
    );
  }
}

class CirclePaint extends CustomPainter {
  final BuildContext context;

  CirclePaint(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).primaryColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawOval(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
