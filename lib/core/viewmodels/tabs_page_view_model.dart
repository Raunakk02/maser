import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class TabsPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  TabController tabController;
  AnimationController animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  Future init(TickerProvider tickerProvider) async {
    this.setBusy(true);
    tabController = TabController(length: 4, vsync: tickerProvider, initialIndex: 0);

    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: tickerProvider,
    );
    curve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => animationController.forward(),
    );
    this.setBusy(false);
  }

  void updateTabIndex(int index) {
    tabController.index = index;
  }

  @override
  void dispose() {
    tabController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void goToSecondPage() {
    // _navigationService.navigateTo(RouteConstants.secondPage, arguments: 'REceived ARgumentsss');
  }
}
