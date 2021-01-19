import 'dart:io';

import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:ar_post/injection.dart';
import 'package:ar_post/presentation/ar/share_image_sheet_widget.dart';
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
      child: BlocListener<ArActionsBloc, ArActionsState>(
        listener: (BuildContext context, state) {
          if (state.action == ArAction.captured && state.image.isSome()) {
            _showShareSheet(context, state.image.getOrElse(() => null));
          }
        },
        child: Stack(
          children: [ArViewWidget(), ArControlsWidget()],
        ),
      ),
    );
  }

  void _showShareSheet(BuildContext context, File imageFile) {
    final actionsBloc = context.read<ArActionsBloc>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ShareImageSheetWidget(
          imageFile: imageFile,
          actionsBloc: actionsBloc,
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
    );
  }
}
