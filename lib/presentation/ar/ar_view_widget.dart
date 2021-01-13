import 'dart:io';

import 'package:ar_post/app/ar/ar_actions_bloc.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vector_math/vector_math_64.dart';

class ArViewWidget extends StatefulWidget {
  @override
  _ArViewWidgetState createState() => _ArViewWidgetState();
}

class _ArViewWidgetState extends State<ArViewWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  ARKitController arkitController;
  ARKitReferenceNode node;
  String anchorId;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArActionsBloc, ArActionsState>(
      listener: (context, state) {
        if (state.isCaptured && state.image.isNone()) {
          _onCaptureImage();
        } else if (!state.isPlaced) {
          arkitController.remove("main");
        }
      },
      child: Screenshot(
        controller: screenshotController,
        child: ARKitSceneView(
          onARKitViewCreated: (arkitController) {
            this.arkitController = arkitController;
            this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
          },
          planeDetection: ARPlaneDetection.horizontal,
        ),
      ),
    );
  }

  Future _onCaptureImage() async {
    final imageFile = await _captureImage();
    context.read<ArActionsBloc>().add(
          ArActionsEvent.submitImageFile(file: imageFile),
        );
  }

  Future<File> _captureImage() {
    return screenshotController.capture();
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor);
    }
  }

  void _addPlane(ARKitController arkitController, ARKitPlaneAnchor anchor) {
    anchorId = anchor.identifier;

    final node = ARKitNode(
      geometry: ARKitSphere(radius: 0.1),
      position: Vector3(0, 0, 0),
      name: "main"
    );

    arkitController.add(node, parentNodeName: anchor.nodeName);
  }

}
