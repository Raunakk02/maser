import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maser/app/auth/data/datasources/auth_remote_datasource.dart';
import 'package:maser/app/auth/data/repositories/auth_repository_impl.dart';
import 'package:maser/app/auth/domain/usecases/logout_user.dart';
import 'package:maser/app/auth/domain/usecases/sign_in_with_google.dart';
import 'package:maser/core/services/network/network_info.dart';
import 'package:maser/core/usecases/usecase.dart';

import '../../../../core/managers/navigation/route_constants.dart';

class AuthPageModel extends GetxController {
  final _signInWithGoogleUseCase = SignInWithGoogle(
    AuthRepositoryImpl(
      remoteDatasource: AuthRemoteDatasourceImpl(signInClient: GoogleSignIn()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  final _logoutUser = LogoutUser(
    AuthRepositoryImpl(
      remoteDatasource: AuthRemoteDatasourceImpl(signInClient: GoogleSignIn()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  Future signInWithGoogle() async {
    await _signInWithGoogleUseCase(NoParams());
  }

  Future logoutUser() async {
    await _logoutUser(NoParams());
  }

  void navigateToHomePage() {
    Get.toNamed(RouteConstants.tabsPage);
  }
}
