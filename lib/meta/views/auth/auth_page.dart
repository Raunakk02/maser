import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/core/viewmodels/auth/auth_page_model.dart';
import 'package:stacked/stacked.dart';

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
