import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maser/app/auth/presentation/views/auth_page.dart';
import 'package:maser/app/auth/presentation/views/tabs_page.dart';

import 'route_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstants.homePage:
      return MaterialPageRoute(builder: (_) => TabsPage());
    case RouteConstants.authPage:
      return MaterialPageRoute(builder: (_) => AuthPage());
    // case RouteConstants.secondPage:
    //   var arguments = settings.arguments as String;
    //   return MaterialPageRoute(builder: (_) => SecondPage(arg: arguments));
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No path defined for ${settings.name}'),
          ),
        ),
      );
  }
}
