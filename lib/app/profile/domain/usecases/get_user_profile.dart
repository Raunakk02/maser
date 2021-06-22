import 'package:maser/app/profile/domain/repositories/profile_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/usecases/usecase.dart';

class GetUserProfile implements UseCase<User, NoParams> {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}
