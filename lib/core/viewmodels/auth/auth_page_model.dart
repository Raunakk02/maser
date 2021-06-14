import 'package:flutter_login/flutter_login.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/app/route_constants.dart';
import 'package:maser/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

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
