import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maser/app/route_constants.dart';
import 'package:maser/meta/views/tabs_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstants.homePage:
      return MaterialPageRoute(builder: (_) => HomePage());
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
