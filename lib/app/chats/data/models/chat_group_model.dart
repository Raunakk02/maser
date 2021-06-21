import 'package:flutter/foundation.dart';

import '../../domain/entities/chat_group.dart';
import 'chat_message_model.dart';

class ChatGroupModel extends ChatGroup {
  ChatGroupModel({
    @required String id,
    @required String mentorId,
    @required List<ChatMessageModel> messages,
  }) : super(id: id, mentorId: mentorId, messages: messages);

  factory ChatGroupModel.fromJson(Map<String, dynamic> json) {
    return ChatGroupModel(
      id: json['id'],
      mentorId: json['mentorId'],
      messages:
          (json['messages'] as List<dynamic>).map((e) => ChatMessageModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'mentorId': this.mentorId,
        'messages': (this.messages as List<ChatMessageModel>).map((e) => e.toJson()).toList(),
      };
}
