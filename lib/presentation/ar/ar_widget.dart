import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:ar_post/app/auth/auth_bloc.dart';
import 'package:ar_post/domain/core/value_objects.dart';
import 'package:ar_post/presentation/ar/share_image_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ar_controls_widget.dart';
import 'ar_view_widget.dart';

class ArWidget extends StatelessWidget {
  const ArWidget();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArActionsBloc, ArActionsState>(
      listener: (BuildContext context, state) {
        if (state.action == ArAction.captured && state.image.isSome()) {
          _showShareSheet(context, state.image.getOrElse(() => null));
        }
      },
      child: Stack(
        children: [ArViewWidget(), ArControlsWidget()],
      ),
    );
  }

  Future _showShareSheet(BuildContext context, LocalImage imageFile) async {
    final actionsBloc = context.read<ArActionsBloc>();
    final authBloc = context.read<AuthBloc>();

    final controller = showBottomSheet(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor: 0.7,
          child: ShareImageSheetWidget(
            localImage: imageFile,
            actionsBloc: actionsBloc,
            authBloc: authBloc,
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
    );

    await controller.closed;
    context.read<ArActionsBloc>().add(const ArActionsEvent.backToPlaced());
  }
}
