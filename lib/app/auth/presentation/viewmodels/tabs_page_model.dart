import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/managers/navigation/locator.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../chats/presentation/views/chats_page.dart';
import '../../../mood_analysis/presentation/views/mood_analysis_page.dart';
import '../../../profile/presentation/views/profile_page.dart';
import '../../../stories/presentation/views/stories_page.dart';

class TabsPageModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  int activePageIndex;

  final iconList = <IconData>[
    Icons.amp_stories_rounded,
    Icons.chat_bubble_rounded,
    Icons.mood_rounded,
    Icons.person_rounded,
  ];

  final pages = <Widget>[
    const StoriesPage(),
    const ChatsPage(),
    const MoodAnalysisPage(),
    const ProfilePage(),
  ];

  Future init() async {
    this.setBusy(true);
    Future.delayed(
      Duration(seconds: 1),
    );
    activePageIndex = 0;
    this.setBusy(false);
  }

  void setActivePageIndex(int index) {
    activePageIndex = index;
    notifyListeners();
  }

  void goToSecondPage() {
    // _navigationService.navigateTo(RouteConstants.secondPage, arguments: 'REceived ARgumentsss');
  }
}
