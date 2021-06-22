import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/core/usecases/usecase.dart';

class CreateChatGroup extends UseCase<String, Params> {
  final ChatsRepository repository;

  CreateChatGroup(this.repository);

  @override
  Future<Either<Failure, String>> call(params) async {
    return await repository.createChatGroup(params.mentorId);
  }
}

class Params extends Equatable {
  final String mentorId;

  Params({@required this.mentorId});

  @override
  List<Object> get props => [mentorId];
}
