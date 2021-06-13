import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maser/core/managers/camera_manager.dart';
import 'package:stacked/stacked.dart';

class MoodAnalysisPageModel extends BaseViewModel with WidgetsBindingObserver {
  XFile image;
  FToast fToast = FToast();
  CameraController controller;

  // Counting pointers (number of user fingers on screen)
  int pointers = 0;
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 1.0;
  double currentScale = 1.0;
  double baseScale = 1.0;

  //Initialize camera controller
  Future initCamController() async {
    this.setBusy(true);
    WidgetsBinding.instance.addObserver(this);
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      throw error(e);
    }
    this.setBusy(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (!this.disposed) {
        notifyListeners();
      }
      if (cameraController.value.hasError) {
        print('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController.getMaxZoomLevel().then((value) => maxAvailableZoom = value),
        cameraController.getMinZoomLevel().then((value) => minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    if (!this.disposed) {
      notifyListeners();
    }
  }

  /// Returns a suitable camera icon for [direction].
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        throw ArgumentError('Unknown lens direction');
    }
  }

  //TODO: implement tensorflow logic

  //Func to call to take pictures and save them in file
  void onTakePictureButtonPressed() {
    takePicture().then((XFile file) {
      if (!this.disposed) {
        image = file;
        notifyListeners();
        if (file != null)
          Fluttertoast.showToast(
            msg: 'Picture saved to ${file.path}',
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
          );
      }
    });
  }

  //Take picture from camera
  Future<XFile> takePicture() async {
    if (controller == null || !controller.value.isInitialized) {
      Fluttertoast.showToast(
        msg: 'Error: select a camera first.',
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
      );
      return null;
    }

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      throw error(e);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
