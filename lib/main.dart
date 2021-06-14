import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:maser/app/locator.dart';
import 'package:maser/app/route_constants.dart';
import 'package:maser/app/router.dart' as router;
import 'package:maser/app/theme/app_theme.dart';
import 'package:maser/core/managers/camera_manager.dart';
import 'package:maser/core/services/navigation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
      initialRoute: RouteConstants.authPage, //RouteConstants.homePage,
      onGenerateRoute: router.generateRoute,
    );
  }
}
