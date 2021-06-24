import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/managers/camera_manager.dart';
import '../../../../core/managers/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../viewmodels/mood_analysis_page_model.dart';

class MoodAnalysisPage extends StatelessWidget {
  final model = Get.find<MoodAnalysisPageModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!model.isCamControllerInitialized.value) {
        return Center(
          child: Text('Getting Camera Preview...'),
        );
      }
      return Scaffold(
        appBar: CustomAppBar(title: 'Mood Analysis'),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: GetBuilder(
                id: 'camera_preview_widget',
                init: model,
                builder: (_model) => _cameraPreviewWidget(_model),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GetBuilder(
                        id: 'camera_toggle_row_widget',
                        init: model,
                        builder: (_model) => _cameraTogglesRowWidget(_model),
                      ),
                      GetBuilder(
                        id: 'thumbnail_widget',
                        init: model,
                        builder: (_model) => _thumbnailWidget(_model),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
        floatingActionButton: _captureCameraButton(model),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget _cameraPreviewWidget(MoodAnalysisPageModel model) {
    if (model.controller == null || !model.controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => model.pointers++,
        onPointerUp: (_) => model.pointers--,
        child: CameraPreview(
          model.controller,
        ),
      );
    }
  }

  Widget _thumbnailWidget(MoodAnalysisPageModel model) {
    return model.image == null
        ? Container(
            width: 64.0,
            height: 64.0,
          )
        : Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: AppColors.sea_blue,
              width: 2,
            )),
            child: Image.file(
              File(model.image.path),
              fit: BoxFit.cover,
            ),
            width: 64.0,
            height: 64.0,
          );
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureCameraButton(MoodAnalysisPageModel model) {
    final CameraController cameraController = model.controller;

    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: cameraController != null &&
                cameraController.value.isInitialized &&
                !cameraController.value.isRecordingVideo
            ? model.onTakePictureButtonPressed
            : null,
      ),
    );
  }

  Widget _cameraTogglesRowWidget(MoodAnalysisPageModel model) {
    final List<Widget> toggles = <Widget>[];

    final onChanged = (CameraDescription description) {
      if (description == null) {
        return;
      }

      model.onNewCameraSelected(description);
    };

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 30.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(
                model.getCameraLensIcon(cameraDescription.lensDirection),
                color: Colors.white,
              ),
              activeColor: AppColors.grass,
              groupValue: model.controller.description,
              value: cameraDescription,
              onChanged: model.controller != null && model.controller.value.isRecordingVideo
                  ? null
                  : onChanged,
            ),
          ),
        );
      }
    }

    return Column(
      children: toggles,
      mainAxisSize: MainAxisSize.min,
    );
  }
}
