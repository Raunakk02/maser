import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maser/app/profile/presentation/viewmodels/profile_page_model.dart';

import '../../../../core/managers/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  final model = Get.find<ProfilePageModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.ruby,
                child: model.user.imageUrl == null
                    ? Icon(Icons.person)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(model.user.imageUrl),
                      ),
              ),
              Text('Name: ${model.user.name}'),
              Text('Email: ${model.user.email}'),
              if (model.user.phone != null) Text('Phone: ${model.user.phone}'),
              OutlinedButton(
                onPressed: () async {
                  await model.logoutUser();
                },
                child: Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
