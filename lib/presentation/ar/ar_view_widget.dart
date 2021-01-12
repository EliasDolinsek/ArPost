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
        }
      },
      child: Screenshot(
        controller: screenshotController,
        child: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
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

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
      geometry: ARKitSphere(radius: 0.1),
      position: Vector3(0, 0, -0.5),
    );
    this.arkitController.add(node);
  }
}
