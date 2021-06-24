import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import '../viewmodels/auth_page_model.dart';

class AuthPage extends StatelessWidget {
  final AuthPageModel model = Get.find<AuthPageModel>();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onSignup: model.signUpUser,
      onLogin: model.loginUser,
      onRecoverPassword: model.recoverUserPassword,
      onSubmitAnimationCompleted: model.navigateToHomePage,
      title: 'MASER',
      footer: '© 2021 Raunak k.  All rights reserved',
    );
  }
}
