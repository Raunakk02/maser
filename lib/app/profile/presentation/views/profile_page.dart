import 'package:flutter/material.dart';

import '../../../../core/managers/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

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
                child: Icon(Icons.person),
              ),
              Text('Name: Sarah Connor'),
              Text('Email: sconnor@genesis.com'),
              Text('Phone: +91-7463829182'),
              Text('Mentor Badge'),
              OutlinedButton(
                onPressed: () {},
                child: Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
