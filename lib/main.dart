import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maser/core/managers/navigation/locator.dart';

import 'core/managers/camera_manager.dart';
import 'core/managers/navigation/route_constants.dart';
import 'core/managers/navigation/router.dart' as router;
import 'core/managers/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maser',
      theme: AppTheme.primaryTheme,
      initialRoute: RouteConstants.homePage,
      onGenerateRoute: router.generateRoute,
    );
  }
}
