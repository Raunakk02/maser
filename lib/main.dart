import 'package:flutter/material.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/app/route_constants.dart';
import 'package:maser/app/router.dart' as router;
import 'package:maser/app/theme/app_theme.dart';
import 'package:maser/core/services/navigation_service.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      title: 'Flutter Demo',
      theme: AppTheme.primaryTheme,
      initialRoute: RouteConstants.homePage,
      onGenerateRoute: router.generateRoute,
    );
  }
}
