import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maser/app/stories/presentation/viewmodels/add_stories_viewmodel.dart';

class AddStoriesPage extends StatelessWidget {
  final model = Get.put(AddStoiesViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Stories')),
      body: SingleChildScrollView(
        child: Form(
          key: model.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.app_registration_sharp),
                    labelText: 'Story Title',
                  ),
                  onSaved: (value) {
                    model.storyTitle = value;
                  },
                  validator: model.storyTitleValidator,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.description),
                    labelText: 'Story Content',
                  ),
                  onSaved: (value) {
                    model.storyContent = value;
                  },
                  validator: model.storyContentValidator,
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                    label: model.pickedFilePath.isEmpty
                        ? Text('No file uploaded')
                        : model.isUplaoadingImage.value
                            ? Text('Uploading...')
                            : Text('Image Uploaded'),
                    onPressed: () async {
                      await model.pickFileFromDevice();
                    },
                    icon: model.pickedFilePath.isEmpty
                        ? Icon(Icons.file_copy)
                        : Icon(Icons.check),
                  ),
                ),
                Obx(
                  () => model.isUplaoadingImage.value
                      ? _buildUploadStatus(model.uploadTask)
                      : Container(),
                ),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => model.isSubmittingForm.value
                      ? CircularProgressIndicator()
                      : Obx(
                          () => OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                            ),
                            child: Text('Add story'),
                            onPressed: model.uploadedImageUrl.value.isEmpty
                                ? null
                                : () {
                                    model.submitForm();
                                  },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildUploadStatus(UploadTask uploadTask) {
  return StreamBuilder<TaskSnapshot>(
    stream: uploadTask.snapshotEvents,
    builder: (_, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(1);

        return Text('$percentage %');
      } else {
        return Container();
      }
    },
  );
}
