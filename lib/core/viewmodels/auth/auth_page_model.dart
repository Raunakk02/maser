import 'package:maser/app/locator.dart';
import 'package:maser/app/route_constants.dart';
import 'package:maser/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class AuthPageModel extends BaseViewModel {
  Future signUpUser() async {}
  Future loginUser() async {}
  Future recoverUserPassword() async {}

  void navigateToHomePage() {
    locator<NavigationService>().navigateTo(RouteConstants.homePage);
  }
}
