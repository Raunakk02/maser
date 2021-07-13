import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:maser/core/managers/theme/app_colors.dart';

import '../viewmodels/auth_page_model.dart';

final Gradient appNameGradient = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: <Color>[
    AppColors.sky_blue,
    AppColors.grass,
  ],
);

class AuthPage extends StatelessWidget {
  final AuthPageModel model = Get.find<AuthPageModel>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/bg.jpg'),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Scaffold(
          backgroundColor: Colors.white54,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/app_logo.png',
                      height: Get.size.height * 0.15,
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => appNameGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: Text(
                        'MASER',
                        style: TextStyle(
                          fontSize: Get.size.height * 0.06,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    fixedSize: Size.fromHeight(60),
                    textStyle: TextStyle(fontSize: 24),
                    elevation: 5,
                    shadowColor: Colors.blue[50],
                  ),
                  onPressed: () async {
                    await model.signInWithGoogle();
                  },
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: Text('Sign In with Google'),
                ),
                Spacer(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Towards a ',
                    style: TextStyle(
                      color: AppColors.sea_blue,
                      fontSize: 18,
                    ),
                    children: [
                      TextSpan(
                        text: 'Better Future...',
                        style: TextStyle(
                          color: AppColors.grass,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
