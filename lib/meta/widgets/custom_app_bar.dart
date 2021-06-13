import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  @override
  final Size preferredSize;
  final String title;
  final Widget menu;
  CustomAppBar({
    Key key,
    @required this.title,
    this.menu,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      actions: menu == null ? [] : [menu],
    );
  }
}
