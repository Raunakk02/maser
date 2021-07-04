import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maser/app/chats/data/datasources/chats_remote_datasource.dart';
import 'package:maser/app/chats/data/models/chat_message_model.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';
import 'package:maser/app/chats/presentation/widgets/chat_bubble.dart';

final _controller = ScrollController();

class ChatsListView extends StatelessWidget {
  ChatsListView(this._chatGroup);
  final ChatGroup _chatGroup;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            ChatsRemoteDatasourceImpl().individualChatGroupStream(_chatGroup),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final docSnapshot = snapshot.data.data();
          List<ChatMessage> _chats = [];
          _chats = (docSnapshot["messages"] as List)
              .map<ChatMessage>((msg) => ChatMessageModel.fromJson(msg))
              .toList();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_controller.hasClients) {
              _controller.jumpTo(_controller.position.maxScrollExtent);
            } else {}
          });
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: _chats.length,
            physics: BouncingScrollPhysics(),
            controller: _controller,
            itemBuilder: (_, index) {
              return ChatBubble(
                isSender: _checkIsSender(_chats[index].uid),
                showNip: index < 1
                    ? true
                    : _checkShowNip(
                        _chats[index - 1].uid,
                        _chats[index].uid,
                      ),
                message: _chats[index],
              );
            },
          );
        });
  }
}

bool _checkIsSender(String uid) {
  return uid == FirebaseAuth.instance.currentUser.uid ? true : false;
}

bool _checkShowNip(String uid1, String uid2) {
  return uid1 == uid2 ? false : true;
}
