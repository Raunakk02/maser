import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chats'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildChatNameCard(),
            _buildChatNameCard(),
            _buildChatNameCard(),
            _buildChatNameCard(),
            _buildChatNameCard(),
            _buildChatNameCard(),
          ],
        ),
      ),
    );
  }

  _buildChatNameCard() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
          leading: CircleAvatar(
            radius: 30,
          ),
          title: Text('Mentor Name'),
          onTap: () {},
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
