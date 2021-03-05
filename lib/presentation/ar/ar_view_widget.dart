import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

class ArViewWidget extends StatefulWidget {
  @override
  _ArViewWidgetState createState() => _ArViewWidgetState();
}

class _ArViewWidgetState extends State<ArViewWidget> {
  final screenshotController = ScreenshotController();
  ARKitController arkitController;
  ARKitPlaneAnchor lastAnchor;
  ARKitNode node;

  double dx = 0, dy = 0, scale = 1;


  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArActionsBloc, ArActionsState>(
      listener: (context, state) async {
        if (state.action == ArAction.placing) {
          if (await _tryAddPlane()) {
            context
                .read<ArActionsBloc>()
                .add(const ArActionsEvent.notifyPlaced());
          }
        } else if (state.action == ArAction.releasing) {
          _release();
        }
      },
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          child: BlocBuilder<ArActionsBloc, ArActionsState>(
            builder: (context, state) {
              return GestureDetector(
                onHorizontalDragUpdate: state.action == ArAction.moving
                    ? onHorizontalDragUpdate
                    : null,
                onScaleUpdate:
                    state.action != ArAction.moving ? onScaleUpdate : null,
                onVerticalDragUpdate: state.action == ArAction.moving
                    ? onVerticalDragUpdate
                    : null,
                child: ARKitSceneView(
                  onARKitViewCreated: (arkitController) {
                    this.arkitController = arkitController;
                    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
                  },
                  planeDetection: ARPlaneDetection.horizontal,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    if (node != null) {
      final result = details.delta.dx / 16 + dx;
      if (result < 10 && result > -10) {
        dx = result;
        node.position = vector_math.Vector3(
          result,
          node.position.y,
          node.position.z,
        );
      }
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    if (node != null) {
      final result = -details.delta.dy / 16 + dy;
      if (result < 10 && result > -10) {
        dy = result;
        node.position = vector_math.Vector3(
          node.position.x,
          result,
          node.position.z,
        );
      }
    }
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    if (node != null) {
      final convertedScale = details.horizontalScale < 1
          ? -details.horizontalScale
          : details.horizontalScale;

      final result = convertedScale / 16 + scale;
      if (result < 5 && result > 0.1) {
        scale = result;
        node.scale = vector_math.Vector3.all(scale);
      }
    }
  }

  void _release() {
    arkitController.remove("main");
    node = null;
    context.read<ArActionsBloc>().add(const ArActionsEvent.notifyReleased());
  }

  Future _handleAddAnchor(ARKitAnchor anchor) async {
    if (anchor is ARKitPlaneAnchor) {
      lastAnchor = anchor;
      if (context.read<ArActionsBloc>().state.action == ArAction.placing &&
          node == null) {
        if (await _tryAddPlane()) {
          context
              .read<ArActionsBloc>()
              .add(const ArActionsEvent.notifyPlaced());
        }
      }
    }
  }

  Future<bool> _tryAddPlane() async {
    if (lastAnchor != null) {
      await _addPlane();
      return true;
    }

    return false;
  }

  Future _addPlane() async {
    node = ARKitReferenceNode(
      position: vector_math.Vector3.all(0),
      url: "models.scnassets/feile.dae",
      name: "main",
    );

    await arkitController.add(node, parentNodeName: lastAnchor.nodeName);
  }
}
