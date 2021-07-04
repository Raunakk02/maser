import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maser/app/chats/data/models/chat_group_model.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/presentation/viewmodels/chat_groups_page_viewmodel.dart';
import 'package:maser/core/managers/theme/app_colors.dart';
import 'package:maser/core/models/user.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ChatGroupsPage extends StatelessWidget {
  final model = Get.put(ChatGroupsPageViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chats'),
      body: StreamBuilder(
          stream: model.chatGroupsStream(),
          builder: (_, streamSnap) {
            if (!streamSnap.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = streamSnap.data;
            final docs = data.docs;
            List<ChatGroup> chatGroups = docs.map<ChatGroup>((doc) {
              print(doc["messages"]);
              return ChatGroupModel.fromJson({
                "id": doc["id"],
                "mentorId": doc["mentorId"],
                "messages": doc["messages"],
              });
            }).toList();
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(
                thickness: 1,
                height: 0,
              ),
              itemCount: chatGroups.length,
              itemBuilder: (_, index) {
                return _buildChatNameCard(chatGroups[index]);
              },
            );
          }),
    );
  }

  _buildChatNameCard(ChatGroup chatGroup) {
    return FutureBuilder<User>(
      future: model.fetchMentorDetails(chatGroup.mentorId),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }
        final User mentorDetails = snapshot.data;
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.pastel_grey,
              child: mentorDetails.imageUrl.isEmpty
                  ? Container()
                  : Image.network(
                      mentorDetails.imageUrl,
                    ),
            ),
          ),
          title: Text('${mentorDetails.name}'),
          onTap: () {
            model.navigateToChatMessagingPage(chatGroup);
          },
        );
      },
    );
  }
}
