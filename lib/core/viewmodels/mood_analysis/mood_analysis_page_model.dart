import 'dart:io';

import 'package:camera/camera.dart';
import 'package:maser/core/managers/camera_manager.dart';
import 'package:stacked/stacked.dart';

class MoodAnalysisPageModel extends BaseViewModel {
  File image;
  CameraController controller;

  Future initCamController() async {
    this.setBusy(true);
    controller = CameraController(cameras[0], ResolutionPreset.max);
    try {
      await controller.initialize();
    } on CameraException {
      throw error(CameraException);
    }
    this.setBusy(false);
  }

  Future geImageFromCamera() async {}

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
