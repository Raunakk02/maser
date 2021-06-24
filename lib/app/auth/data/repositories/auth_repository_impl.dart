import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:maser/app/auth/data/datasources/auth_remote_datasource.dart';
import 'package:maser/app/auth/domain/repositories/auth_repository.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/services/network/network_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.remoteDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> logoutUser() async {
    if (await networkInfo.isConnected) {
      final result = await remoteDatasource.logoutUser();
      return Right(result);
    } else {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signInwithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDatasource.signInWithGoogle();

        return Right(result);
      } on AuthException {
        return Left(AuthFailure());
      }
    } else {
      return Left(AuthFailure());
    }
  }
}
