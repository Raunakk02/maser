import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/core/usecases/usecase.dart';

class DeleteChatGroup extends UseCase<void, Params> {
  final ChatsRepository repository;

  DeleteChatGroup(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteChatGroup(params.chatGroupId);
  }
}

class Params extends Equatable {
  final String chatGroupId;

  Params({@required this.chatGroupId});

  @override
  List<Object> get props => [chatGroupId];
}
