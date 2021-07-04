import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maser/app/chats/data/datasources/chats_remote_datasource.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';

class ChatBoxWidget extends StatefulWidget {
  ChatBoxWidget(this._chatGroup);
  final ChatGroup _chatGroup;
  @override
  _ChatBoxWidgetState createState() => _ChatBoxWidgetState();
}

class _ChatBoxWidgetState extends State<ChatBoxWidget> {
  TextEditingController chatController = TextEditingController();
  ChatMessage _chatMessage;
  User currentUser;

  @override
  void initState() {
    super.initState();
    var auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
  }

  Future _sendMessage() async {
    FocusScope.of(context).unfocus();
    if (chatController.value.text.trim().isEmpty) {
      return;
    }
    _chatMessage = ChatMessage(
      id: DateTime.now().toIso8601String(),
      msg: chatController.value.text.trim(),
      uid: currentUser.uid,
      timestamp: DateTime.now(),
    );
    chatController.clear();
    try {
      await ChatsRemoteDatasourceImpl()
          .sendChatMessage(widget._chatGroup.mentorId, _chatMessage);
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.1,
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
              cursorHeight: 23,
              maxLines: 3,
              minLines: 1,
              controller: chatController,
              textInputAction: TextInputAction.newline,
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          FloatingActionButton(
            child: Icon(Icons.send_rounded),
            isExtended: true,
            foregroundColor: Colors.white,
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
