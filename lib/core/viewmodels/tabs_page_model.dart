import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../meta/views/chats/chats_page.dart';
import '../../meta/views/mood_analysis/mood_analysis_page.dart';
import '../../meta/views/profile/profile_page.dart';
import '../../meta/views/stories/stories_page.dart';
import '../managers/navigation/locator.dart';
import '../services/navigation_service.dart';

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
