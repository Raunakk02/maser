import 'package:flutter/material.dart';
import 'package:maser/app/models/chat_message.dart';

class ChatGroup {
  String id;
  String mentorId;
  List<ChatMessage> messages;

  ChatGroup({
    @required this.id,
    @required this.mentorId,
    @required this.messages,
  });

  factory ChatGroup.fromMap(Map map) {
    return ChatGroup(
      id: map['id'],
      mentorId: map['mentorId'],
      messages: (map['messages'] as List<Map>).map((e) => ChatMessage.fromMap(e)).toList(),
    );
  }

  Map<String, Object> toMap() => {
        'id': this.id,
        'mentorId': this.mentorId,
        'messages': this.messages.map((e) => e.toMap()).toList(),
      };
}
