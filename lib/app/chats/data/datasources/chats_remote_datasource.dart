import 'package:flutter/foundation.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';

abstract class ChatsRemoteDatasource {
  /// Calls firebase to return all the chat group documents
  /// for the current signed in user
  /// in chat_groups/userId collection.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ChatGroup>> getChatGroups();

  /// Calls firebase to delete a particular chat group document
  /// with the given chatGroupId
  /// in the chat_groups/userId collection.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> deleteChatGroup(String chatGroupId);

  /// Calls firebase to create a particular chat group document
  /// in the chat_groups/userId collection
  /// with provided mentorId.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> createChatGroup(String mentorId);

  /// Calls firebase to add a new chat message
  /// in the messages field of chat group document
  /// in the chat_groups/userId collection
  /// with provided mentorId.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> sendChatMessage(String chatGroupId, ChatMessage message);
}
