import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maser/app/profile/presentation/viewmodels/profile_page_model.dart';

import '../../../../core/managers/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  final model = Get.find<ProfilePageModel>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: ProflieContainerClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.grass, AppColors.sky_blue],
                    ),
                  ),
                  width: double.infinity,
                  height: mediaQuery.padding.top * 3,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: mediaQuery.padding.top * 2.2,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.ruby,
                      child: model.user.imageUrl == null
                          ? Icon(Icons.person)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network(model.user.imageUrl),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _buildRichText('Name:', model.user.name),
                    _buildRichText('Email:', model.user.email),
                    if (model.user.phone != null)
                      _buildRichText('Phone:', model.user.phone),
                    SizedBox(
                      height: 40,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                      onPressed: () async {
                        await model.logoutUser();
                      },
                      child: Text('Sign Out'),
                    ),
                    SizedBox(
                      height: mediaQuery.size.height * 0.53,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  RichText _buildRichText(String text1, String text2) {
    return RichText(
      text: TextSpan(
        text: '$text1\t\t\t\t',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.sky_blue,
        ),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class ProflieContainerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
