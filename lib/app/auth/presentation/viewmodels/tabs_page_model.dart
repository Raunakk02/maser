import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../chats/presentation/views/chat_groups_page.dart';
import '../../../mood_analysis/presentation/views/mood_analysis_page.dart';
import '../../../profile/presentation/views/profile_page.dart';
import '../../../stories/presentation/views/stories_page.dart';

class TabsPageModel extends GetxController {
  var activePageIndex = 0.obs;

  final iconList = <IconData>[
    Icons.amp_stories_rounded,
    Icons.chat_bubble_rounded,
    Icons.mood_rounded,
    Icons.person_rounded,
  ];

  final pages = <Widget>[
    StoriesPage(),
    ChatGroupsPage(),
    MoodAnalysisPage(),
    ProfilePage(),
  ];

  void setActivePageIndex(int index) {
    activePageIndex.value = index;
  }

  void goToSecondPage() {
    // _navigationService.navigateTo(RouteConstants.secondPage, arguments: 'REceived ARgumentsss');
  }
}
