// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../core/managers/navigation/locator.dart';
// import '../../../core/services/navigation_service.dart';
// import '../views/chats/chats_page.dart';
// import '../views/mood_analysis/mood_analysis_page.dart';
// import '../views/profile/profile_page.dart';
// import '../views/stories/stories_page.dart';

// class TabsPageModel extends GetxController {
//   var activePageIndex = 0.obs;

//   final iconList = <IconData>[
//     Icons.amp_stories_rounded,
//     Icons.chat_bubble_rounded,
//     Icons.mood_rounded,
//     Icons.person_rounded,
//   ];

//   final pages = <Widget>[
//     const StoriesPage(),
//     const ChatsPage(),
//     MoodAnalysisPage(),
//     const ProfilePage(),
//   ];

//   void setActivePageIndex(int index) {
//     activePageIndex.value = index;
//   }

//   void goToSecondPage() {
//     // _navigationService.navigateTo(RouteConstants.secondPage, arguments: 'REceived ARgumentsss');
//   }
// }
