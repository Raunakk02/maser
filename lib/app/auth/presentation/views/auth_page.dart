import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../viewmodels/auth_page_model.dart';

class AuthPage extends StatelessWidget {
  final AuthPageModel model = Get.find<AuthPageModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticate'),
      ),
      body: Center(
        child: TextButton.icon(
          onPressed: () async {
            await model.signInWithGoogle();
          },
          icon: Icon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          label: Text('Sign In With Google'),
        ),
      ),
    );
  }
}
