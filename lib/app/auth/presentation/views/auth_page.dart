import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:maser/core/widgets/custom_app_bar.dart';

import '../viewmodels/auth_page_model.dart';

class AuthPage extends StatelessWidget {
  final AuthPageModel model = Get.find<AuthPageModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Authenticate',
      ),
      body: Center(
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            fixedSize: Size.fromHeight(60),
            textStyle: TextStyle(fontSize: 24),
          ),
          onPressed: () async {
            await model.signInWithGoogle();
          },
          icon: Icon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          label: Text('Sign In with Google'),
        ),
      ),
    );
  }
}
