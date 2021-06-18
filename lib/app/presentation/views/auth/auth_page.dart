import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/managers/navigation/locator.dart';
import '../../viewmodels/auth/auth_page_model.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthPageModel>.reactive(
        viewModelBuilder: () => locator<AuthPageModel>(),
        builder: (_, model, child) {
          return FlutterLogin(
            onSignup: model.signUpUser,
            onLogin: model.loginUser,
            onRecoverPassword: model.recoverUserPassword,
            onSubmitAnimationCompleted: model.navigateToHomePage,
            title: 'MASER',
            footer: '© 2021 Raunak k.  All rights reserved',
          );
        });
  }
}
