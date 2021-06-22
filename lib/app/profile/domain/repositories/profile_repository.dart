import 'package:dartz/dartz.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/models/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getUserProfile();
}
