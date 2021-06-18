import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/managers/camera_manager.dart';
import '../../../core/managers/navigation/locator.dart';
import '../../../core/managers/theme/app_colors.dart';
import '../../../core/viewmodels/mood_analysis/mood_analysis_page_model.dart';
import '../../widgets/custom_app_bar.dart';

class MoodAnalysisPage extends StatelessWidget {
  const MoodAnalysisPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoodAnalysisPageModel>.reactive(
        viewModelBuilder: () => locator<MoodAnalysisPageModel>(),
        onModelReady: (model) => model.initCamController(),
        builder: (_, model, child) {
          if (!model.controller.value.isInitialized) {
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
                  child: _cameraPreviewWidget(model),
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
                          _cameraTogglesRowWidget(model),
                          _thumbnailWidget(model),
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
