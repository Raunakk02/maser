import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChatMessage extends Equatable {
  final String id;
  final String msg;
  final String uid;
  final DateTime timestamp;

  ChatMessage({
    @required this.id,
    @required this.msg,
    @required this.uid,
    @required this.timestamp,
  });

  @override
  List<Object> get props => [id, msg, uid, timestamp];

  // factory ChatMessage.fromMap(Map map) {
  //   return ChatMessage(
  //     id: map['id'],
  //     msg: map['msg'],
  //     uid: map['uid'],
  //     timestamp: DateTime.parse((map['timestamp'] as String)),
  //   );
  // }

  // Map<String, Object> toMap() => {
  //       'id': this.id,
  //       'msg': this.msg,
  //       'uid': this.uid,
  //       'timestamp': this.timestamp.toIso8601String(),
  //     };
}
