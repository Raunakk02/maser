import 'package:flutter/material.dart';

class ChatMessage {
  String id;
  String msg;
  String uid;
  DateTime timestamp;

  ChatMessage({
    @required this.id,
    @required this.msg,
    @required this.uid,
    @required this.timestamp,
  });

  factory ChatMessage.fromMap(Map map) {
    return ChatMessage(
      id: map['id'],
      msg: map['msg'],
      uid: map['uid'],
      timestamp: DateTime.parse((map['timestamp'] as String)),
    );
  }

  Map<String, Object> toMap() => {
        'id': this.id,
        'msg': this.msg,
        'uid': this.uid,
        'timestamp': this.timestamp.toIso8601String(),
      };
}
