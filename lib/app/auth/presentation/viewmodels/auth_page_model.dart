import 'package:flutter_login/flutter_login.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/managers/navigation/locator.dart';
import '../../../../core/managers/navigation/route_constants.dart';
import '../../../../core/services/navigation_service.dart';

class AuthPageModel extends BaseViewModel {
  Future<String> signUpUser(LoginData loginData) async {
    return '';
  }

  Future<String> loginUser(LoginData loginData) async {
    return '';
  }

  Future<String> recoverUserPassword(String email) async {
    return '';
  }

  void navigateToHomePage() {
    locator<NavigationService>().navigateTo(RouteConstants.homePage);
  }
}
