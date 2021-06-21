import 'package:maser/app/auth/domain/repositories/auth_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/usecases/usecase.dart';

class SignInWithGoogle extends UseCase<User, NoParams> {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.signInwithGoogle();
  }
}
