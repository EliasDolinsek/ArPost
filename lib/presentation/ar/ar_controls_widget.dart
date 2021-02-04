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
              return _buildPlacedOrCaptured(context);
            } else if (state.action == ArAction.moving) {
              return _buildMoving(context);
            } else if (state.action == ArAction.capturing) {
              return Container();
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

  Widget _buildPlacedOrCaptured(BuildContext context) {
    return Stack(
      children: [
        _buildMove(context, false),
        _buildCapture(context),
        _buildReleaseButton(context)
      ],
    );
  }

  Widget _buildMoving(BuildContext context) {
    return Stack(
      children: [
        _buildMove(context, true),
        _buildTurnLeft(context),
        _buildTurnRight(context)
      ],
    );
  }

  Widget _buildCapture(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ArButton(
        iconData: Icons.fiber_manual_record,
        onPressed: () =>
            context.read<ArActionsBloc>().add(const ArActionsEvent.capture()),
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
          onPressed: () =>
              context.read<ArActionsBloc>().add(const ArActionsEvent.release()),
        ),
      ),
    );
  }

  Widget _buildTurnLeft(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 29.0),
        child: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Theme.of(context).primaryColor,
          ),
          iconSize: 36,
          onPressed: () => context
            .read<ArActionsBloc>()
            .add(const ArActionsEvent.turn(direction: TurnDirection.left)),
        ),
      ),
    );
  }

  Widget _buildTurnRight(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 29.0, right: 55),
        child: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Theme.of(context).primaryColor,
          ),
          iconSize: 36,
          onPressed: () => context
              .read<ArActionsBloc>()
              .add(const ArActionsEvent.turn(direction: TurnDirection.right)),
        ),
      ),
    );
  }

  Widget _buildMove(BuildContext context, bool movingActive) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 29.0,
          left: 55.0,
        ),
        child: movingActive
            ? _buildActiveMoveButton(context)
            : _buildMoveButton(context, false),
      ),
    );
  }

  Widget _buildActiveMoveButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMoveButton(context, true),
        const SizedBox(height: 4),
        _buildActiveMoveCircle(context)
      ],
    );
  }

  Widget _buildMoveButton(BuildContext context, bool active) {
    return IconButton(
      icon: Icon(
        Icons.open_with,
        size: 36,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {
        if (active) {
          context
              .read<ArActionsBloc>()
              .add(const ArActionsEvent.backToPlaced());
        } else {
          context.read<ArActionsBloc>().add(const ArActionsEvent.move());
        }
      },
    );
  }

  Widget _buildActiveMoveCircle(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
