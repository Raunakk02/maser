import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStoiesViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  var storyTitle = '';
  var storyContent = '';
  var pickedFilePath = ''.obs;
  File pickedFile;
  Rx<bool> loading = false.obs;

  String storyTitleValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the title of the story';
    } else if (int.tryParse(value) != null) {
      return 'Only numerical values are not allowed';
    }
    return null;
  }

  String storyContentValidator(String value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the content of the story';
    }
    return null;
  }

  Future pickFileFromDevice() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedFile = File(result.files.single.path);
      //TODO: add logic for uploading the flle to cloud storage
      pickedFilePath.value = pickedFile.path;
    } else {
      Get.showSnackbar(GetBar(
        message: 'No File selected!',
        duration: Duration(seconds: 2),
      ));
    }
  }

  void submitForm() {
    if (formKey.isBlank) return;
    loading.value = true;
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('Title: $storyTitle');
      print('Content: $storyContent');
      print('File picked: ${pickedFilePath.value}');
    }
    //TODO: add logic for using createStory usecase
    loading.value = false;
  }
}
