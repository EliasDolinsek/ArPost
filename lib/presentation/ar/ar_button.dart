import 'package:flutter/material.dart';

class ArButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;

  const ArButton({
    Key key,
    this.iconData,
    this.onPressed,
  }) : super(key: key);

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
            onPressed: onPressed,
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
