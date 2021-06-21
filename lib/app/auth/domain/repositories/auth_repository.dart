import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInwithGoogle();
  Future<Either<Failure, void>> logoutUser();
}
