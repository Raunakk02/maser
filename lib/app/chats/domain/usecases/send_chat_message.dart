import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/core/usecases/usecase.dart';

class SendChatMessage implements UseCase<void, Params> {
  final ChatsRepository repository;

  SendChatMessage(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.sendChatMessage(params.chatGroupId, params.message);
  }
}

class Params extends Equatable {
  final String chatGroupId;
  final ChatMessage message;

  Params({
    @required this.chatGroupId,
    @required this.message,
  });

  @override
  List<Object> get props => [chatGroupId, message];
}
