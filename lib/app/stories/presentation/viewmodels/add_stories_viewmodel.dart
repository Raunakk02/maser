import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AddStoiesViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();
  var storyTitle = '';
  var storyContent = '';
  var pickedFilePath = ''.obs;
  var uploadedImageUrl;
  File pickedFile;
  var isSubmittingForm = false.obs;
  var isUplaoadingImage = false.obs;

  UploadTask uploadTask;

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
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      pickedFile = File(result.files.single.path);
      initUploadTask();
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
    isSubmittingForm.value = true;
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('Title: $storyTitle');
      print('Content: $storyContent');
      print('File picked: ${pickedFilePath.value}');
    }
    //TODO: add logic for using createStory usecase
    isSubmittingForm.value = false;
  }

  Future initUploadTask() async {
    isUplaoadingImage.value = true;
    uploadTask = _uploadFileToCloud(pickedFile);

    if (uploadTask == null) {
      isUplaoadingImage.value = false;

      return;
    }

    final snapshot = await uploadTask.whenComplete(() {});
    uploadedImageUrl = await snapshot.ref.getDownloadURL();
    isUplaoadingImage.value = false;
  }

  ///Special method to upload file to cloud storage on firebase
  ///and to get back the upload task.
  UploadTask _uploadFileToCloud(File _file) {
    try {
      if (_file == null) {
        return null;
      }
      final _fileName = basename(_file.path);
      final _destination = 'storyImages/$_fileName';

      final ref = FirebaseStorage.instance.ref(_destination);

      return ref.putFile(_file);
    } catch (e) {
      return null;
    }
  }
}
