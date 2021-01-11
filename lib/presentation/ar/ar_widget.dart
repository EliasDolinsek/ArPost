import 'package:flutter/material.dart';

import 'ar_controls_widget.dart';
import 'ar_view_widget.dart';

class ArWidget extends StatelessWidget {
  const ArWidget();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ArViewWidget(),
        ArControlsWidget()
      ],
    );
  }
}



