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
}
