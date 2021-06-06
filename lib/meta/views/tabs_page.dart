import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/core/viewmodels/tabs_page_view_model.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabsPageViewModel>.reactive(
      viewModelBuilder: () => locator<TabsPageViewModel>(),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(),
          extendBody: true,
          body: MotionTabBarView(
            children: [],
          ),
          bottomNavigationBar: MotionTabBar(
            labels: [
              "Stories",
              "Chats",
              "Analyze Mood",
              "Profile",
            ],
            initialSelectedTab: "Stories",
            tabIconColor: Colors.green,
            tabSelectedColor: Colors.red,
            onTabItemSelected: (int value) {
              print(value);
              //  setState(() {
              //     _tabController.index = value;
              //  });
            },
            icons: [
              Icons.amp_stories_rounded,
              Icons.chat_bubble_rounded,
              Icons.mood_rounded,
              Icons.person_rounded,
            ],
            textStyle: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}
