import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:maser/app/chats/presentation/viewmodels/chat_messaging_page_viewmodel.dart';
import 'package:maser/app/chats/presentation/widgets/chat_box_widget.dart';
import 'package:maser/app/chats/presentation/widgets/chat_list_view.dart';
import 'package:maser/core/managers/theme/app_colors.dart';

class ChatMessagingPage extends StatelessWidget {
  final model = Get.find<ChatMessagingPageViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CircleAvatar(
                    backgroundColor: AppColors.slate_grey,
                    child: model.mentorDetails.value.imageUrl.isEmpty
                        ? Container()
                        : Image.network(model.mentorDetails.value.imageUrl),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(model.mentorDetails.value.name),
              ],
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: ChatsListView(model.chatGroup),
            ),
          ),
          ChatBoxWidget(model.chatGroup),
        ],
      ),
    );
  }
}
