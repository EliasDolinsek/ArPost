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
  ARKitPlaneAnchor lastAnchor;

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArActionsBloc, ArActionsState>(
      listener: (context, state) {
        if (state.action == ArAction.placing) {
          _addPlane();
        } else if (state.action == ArAction.capturing) {
          _captureImage(context);
        } else if (state.action == ArAction.releasing) {
          _release();
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

  void _release() {
    arkitController.remove("main");
    context.read<ArActionsBloc>().add(const ArActionsEvent.notifyReleased());
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      lastAnchor = anchor;
    }
  }

  Future _captureImage(BuildContext context) async {
    final image = await screenshotController.capture();
    context
        .read<ArActionsBloc>()
        .add(ArActionsEvent.notifyCaptured(file: image));
  }

  Future _addPlane() async {
    while(lastAnchor == null){
      // Wait
    }

    anchorId = lastAnchor.identifier;

    final node = ARKitNode(
      geometry: ARKitSphere(radius: 0.1),
      position: Vector3.all(0),
      name: "main",
    );


    await arkitController.add(node, parentNodeName: lastAnchor.nodeName);
    context.read<ArActionsBloc>().add(const ArActionsEvent.notifyPlaced());
  }
}
