import 'package:dartz/dartz.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';
import 'package:maser/core/models/user.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_group.dart';

abstract class ChatsRepository {
  Future<Either<Failure, List<ChatGroup>>> getChatGroups();
  Future<Either<Failure, ChatGroup>> getChatGroup(String chatGroupId);
  Future<Either<Failure, User>> getUserDetails(String userId);
  Future<Either<Failure, void>> deleteChatGroup(String chatGroupId);
  Future<Either<Failure, String>> createChatGroup(String mentorId);
  Future<Either<Failure, void>> sendChatMessage(
      String chatGroupId, ChatMessage message);
}
