import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/app/theme/app_colors.dart';
import 'package:maser/core/viewmodels/tabs_page_model.dart';
import 'package:stacked/stacked.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabsPageModel>.reactive(
      viewModelBuilder: () => locator<TabsPageModel>(),
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.init(),
      builder: (_, model, child) {
        if (model.isBusy) {
          return CircularProgressIndicator();
        }
        return Scaffold(
          extendBody: true,
          body: model.pages[model.activePageIndex],
          bottomNavigationBar: CurvedNavigationBar(
            items: List.generate(
              4,
              (index) => Icon(
                model.iconList[index],
                color: Colors.white,
              ),
            ),
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            color: AppColors.sea_blue,
            buttonBackgroundColor: AppColors.sea_blue,
            onTap: model.setActivePageIndex,
          ),
        );
      },
    );
  }
}
