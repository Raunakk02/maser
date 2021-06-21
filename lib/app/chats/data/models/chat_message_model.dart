import 'package:flutter/foundation.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  ChatMessageModel({
    @required String id,
    @required String msg,
    @required String uid,
    @required DateTime timestamp,
  }) : super(
          id: id,
          msg: msg,
          uid: uid,
          timestamp: timestamp,
        );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      msg: json['msg'],
      uid: json['uid'],
      timestamp: DateTime.parse((json['timestamp'] as String)),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'msg': this.msg,
        'uid': this.uid,
        'timestamp': this.timestamp.toIso8601String(),
      };
}
