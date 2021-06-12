import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/app/theme/app_colors.dart';
import 'package:maser/core/viewmodels/tabs_page_view_model.dart';
import 'package:stacked/stacked.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  final _tabsPageViewModel = locator<TabsPageViewModel>();
  final iconList = <IconData>[
    Icons.amp_stories_rounded,
    Icons.chat_bubble_rounded,
    Icons.mood_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabsPageViewModel>.reactive(
      viewModelBuilder: () => locator<TabsPageViewModel>(),
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.init(this),
      builder: (_, model, child) {
        if (model.isBusy) {
          return CircularProgressIndicator();
        }
        return Scaffold(
          extendBody: true,
          body: TabBarView(
            controller: model.tabController,
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
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: model.tabController.index,
            activeColor: AppColors.grass,
            // backgroundColor: Colors.transparent,
            // elevation: 0,
            gapLocation: GapLocation.center,
            onTap: (int value) {
              // print(value);
              model.updateTabIndex(value);
            },
          ),
        );
      },
    );
  }
}
