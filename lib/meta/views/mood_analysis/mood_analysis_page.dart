import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/core/viewmodels/mood_analysis/mood_analysis_page_model.dart';
import 'package:maser/meta/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

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
            body: CameraPreview(model.controller),
          );
        });
  }
}
