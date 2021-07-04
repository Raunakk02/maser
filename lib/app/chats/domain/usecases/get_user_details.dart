import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:maser/core/models/user.dart';
import '../repositories/chats_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetUserDetails implements UseCase<User, Params> {
  final ChatsRepository repository;

  GetUserDetails(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.getUserDetails(params.userId);
  }
}

class Params extends Equatable {
  final String userId;

  Params({@required this.userId});

  @override
  List<Object> get props => [userId];
}
