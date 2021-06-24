import 'package:maser/core/models/user.dart';

abstract class AuthRemoteDatasource {
  /// Invokes authentication from GoogleSignIn package
  /// and signInWithCredentials in firebase auth.
  ///
  /// Throws a [AuthException] for all error codes.
  Future<UserModel> signInWithGoogle();

  /// Calls the logout method from firebase auth.
  ///
  /// Throws a [AuthException] for all error codes.
  Future<void> logoutUser();
}
