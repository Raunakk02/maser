import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import '../../../../core/managers/navigation/route_constants.dart';

class AuthPageModel extends GetxController {
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
    Get.toNamed(RouteConstants.homePage);
  }
}
