import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:get/get.dart';
import 'package:maser/app/auth/presentation/viewmodels/auth_page_model.dart';
import 'package:maser/core/models/user.dart';

class ProfilePageModel extends GetxController {
  final authPageModel = Get.find<AuthPageModel>();
  final firebaseUser = firebaseAuth.FirebaseAuth.instance.currentUser;

  User user;

  Future logoutUser() async {
    await authPageModel.logoutUser();
  }

  @override
  void onInit() {
    user = User(
      id: firebaseUser.uid,
      name: firebaseUser.displayName,
      email: firebaseUser.email,
      phone: firebaseUser.phoneNumber,
      imageUrl: firebaseUser.photoURL,
    );
    super.onInit();
  }
}
