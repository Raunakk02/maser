import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/core/viewmodels/tabs_page_view_model.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';
import 'package:stacked/stacked.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TabsPage> with SingleTickerProviderStateMixin {
  MotionTabController _motionTabController;

  @override
  void initState() {
    _motionTabController = MotionTabController(
      vsync: this,
      initialIndex: 1,
      length: 4,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabsPageViewModel>.reactive(
      viewModelBuilder: () => locator<TabsPageViewModel>(),
      builder: (_, model, child) {
        return Scaffold(
          extendBody: true,
          body: MotionTabBarView(
            controller: _motionTabController,
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text('Stories'),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Text('chats'),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Text('AM'),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Text('Profile'),
                ),
              ),
            ],
          ),
          bottomNavigationBar: MotionTabBar(
            labels: [
              "Stories",
              "Chats",
              "Analyze Mood",
              "Profile",
            ],
            icons: [
              Icons.amp_stories_rounded,
              Icons.chat_bubble_rounded,
              Icons.mood_rounded,
              Icons.person_rounded,
            ],
            textStyle: TextStyle(color: Colors.red),
            initialSelectedTab: "Stories",
            tabIconColor: Colors.green,
            tabSelectedColor: Colors.red,
            onTabItemSelected: (int value) {
              // print(value);
              setState(() {
                _motionTabController.index = value;
              });
            },
          ),
        );
      },
    );
  }
}
