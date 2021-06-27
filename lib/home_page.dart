import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maser/app/auth/presentation/views/auth_page.dart';
import 'package:maser/app/auth/presentation/views/tabs_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (_, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapShot.hasData) {
              return TabsPage();
            } else if (snapShot.hasError) {
              return Center(
                child: Text('Something went wrong!'),
              );
            } else {
              return AuthPage();
            }
          }),
    );
  }
}
