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

  final double _scaleSmoothing = 0.7;

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
                state.action == ArAction.moving ? onScaleUpdate : null,
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
      final resultX =
          (1 + details.delta.distance) * (node.position.x + 0.00001);
      if (resultX > -10 && resultX < 10) {
        node.position = vector_math.Vector3(
          resultX,
          node.position.y,
          node.position.z,
        );
      }
    }
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    if (node != null) {
      var resultScale = details.scale * node.scale.x;
      if (resultScale < 1 && resultScale * _scaleSmoothing < 1) {
        resultScale *= 0.7;
      } else if (resultScale >= 1 && resultScale >= 1) {
        resultScale *= 0.7;
      }

      if (resultScale > 0.1 && resultScale < 6) {
        node.scale = vector_math.Vector3.all(resultScale);
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
      if (context
          .read<ArActionsBloc>()
          .state
          .action == ArAction.placing &&
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
      url: "models.scnassets/hello_world.dae",
      name: "main",
    );

    await arkitController.add(node, parentNodeName: lastAnchor.nodeName);
  }
}
