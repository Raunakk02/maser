import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:maser/app/profile/data/datasources/profile_remote_datasource.dart';
import 'package:maser/app/profile/domain/repositories/profile_repository.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/services/network/network_info.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    @required this.remoteDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.getUserProfile());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
