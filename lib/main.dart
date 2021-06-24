import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maser/core/managers/navigation/locator.dart';

import 'core/managers/camera_manager.dart';
import 'core/managers/navigation/route_constants.dart';
import 'core/managers/navigation/router.dart' as router;
import 'core/managers/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // navigatorKey: locator<NavigationService>().navigatorKey,
      title: 'Flutter Demo',
      theme: AppTheme.primaryTheme,
      initialRoute: RouteConstants.authPage, //RouteConstants.homePage,
      onGenerateRoute: router.generateRoute,
    );
  }
}
