import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ar_button.dart';

class ArControlsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: BlocBuilder<ArActionsBloc, ArActionsState>(
          builder: (context, state) {
            if (state.action == ArAction.idle) {
              return _buildIdle(context);
            } else if (state.action == ArAction.placing) {
              return _buildLoading();
            } else if (state.action == ArAction.placed) {
              return _buildPlaced(context);
            } else if (state.action == ArAction.capturing) {
              return _buildLoading();
            } else {
              return _buildLoading();
            }
          },
        ),
      ),
    );
  }

  Widget _buildIdle(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ArButton(
        iconData: Icons.push_pin,
        onPressed: () {
          context.read<ArActionsBloc>().add(const ArActionsEvent.place());
        },
      ),
    );
  }

  Widget _buildPlaced(BuildContext context) {
    return Stack(
      children: [_buildCapture(context), _buildReleaseButton(context)],
    );
  }

  Widget _buildCapture(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ArButton(
        iconData: Icons.fiber_manual_record,
        onPressed: () {
          context.read<ArActionsBloc>().add(const ArActionsEvent.capture());
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 35.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildReleaseButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 29.0,
          right: 55.0,
        ),
        child: IconButton(
          icon: Icon(
            Icons.close,
            size: 36,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            context.read<ArActionsBloc>().add(const ArActionsEvent.release());
          },
        ),
      ),
    );
  }
}
