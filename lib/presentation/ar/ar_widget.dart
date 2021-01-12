import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:ar_post/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ar_controls_widget.dart';
import 'ar_view_widget.dart';

class ArWidget extends StatelessWidget {
  const ArWidget();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ArActionsBloc>(),
      child: Stack(
        children: [
          ArViewWidget(),
          ArControlsWidget()
        ],
      ),
    );
  }
}



