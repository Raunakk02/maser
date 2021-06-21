import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'chat_message.dart';

class ChatGroup extends Equatable {
  final String id;
  final String mentorId;
  final List<ChatMessage> messages;

  ChatGroup({
    @required this.id,
    @required this.mentorId,
    @required this.messages,
  });

  @override
  List<Object> get props => [id, mentorId, messages];

  // factory ChatGroup.fromMap(Map map) {
  //   return ChatGroup(
  //     id: map['id'],
  //     mentorId: map['mentorId'],
  //     messages: (map['messages'] as List<Map>).map((e) => ChatMessage.fromMap(e)).toList(),
  //   );
  // }

  // Map<String, Object> toMap() => {
  //       'id': this.id,
  //       'mentorId': this.mentorId,
  //       'messages': this.messages.map((e) => e.toMap()).toList(),
  //     };
}
