import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/managers/theme/app_colors.dart';
import '../viewmodels/tabs_page_model.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  final TabsPageModel model = Get.find<TabsPageModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          extendBody: true,
          body: model.pages[model.activePageIndex.value],
          bottomNavigationBar: CurvedNavigationBar(
            items: List.generate(
              4,
              (index) => Icon(
                model.iconList[index],
                color: Colors.white,
              ),
            ),
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 600),
            backgroundColor: Colors.transparent,
            color: AppColors.sea_blue,
            buttonBackgroundColor: AppColors.sea_blue,
            index: model.activePageIndex.value,
            onTap: model.setActivePageIndex,
          ),
        );
      },
    );
  }
}
