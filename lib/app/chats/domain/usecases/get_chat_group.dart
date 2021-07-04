import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../entities/chat_group.dart';
import '../repositories/chats_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetChatGroup implements UseCase<ChatGroup, Params> {
  final ChatsRepository repository;

  GetChatGroup(this.repository);

  @override
  Future<Either<Failure, ChatGroup>> call(Params params) async {
    return await repository.getChatGroup(params.chatGroupId);
  }
}

class Params extends Equatable {
  final String chatGroupId;

  Params({@required this.chatGroupId});

  @override
  List<Object> get props => [chatGroupId];
}
