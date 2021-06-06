import 'package:maser/app/locator.dart';
import 'package:maser/app/route_constants.dart';
import 'package:maser/core/services/navigation_service.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:stacked/stacked.dart';

class TabsPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  int _counter = 0;
  int get counter => _counter;

  Future init() async {
    this.setBusy(true);
    Future.delayed(
      Duration(seconds: 2),
      () {
        _counter = 0;
      },
    );
    this.setBusy(false);
  }

  void goToSecondPage() {
    // _navigationService.navigateTo(RouteConstants.secondPage, arguments: 'REceived ARgumentsss');
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}
