import 'package:maser/core/models/user.dart';

abstract class ProfileRemoteDatasource {
  /// Calls firebase to return the user profile
  /// of the currently signed in user
  ///
  /// Throws a [ServerException] for all error codes.
  Future<User> getUserProfile();
}
