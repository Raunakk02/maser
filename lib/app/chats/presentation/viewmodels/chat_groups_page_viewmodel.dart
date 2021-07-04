import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:maser/app/chats/data/datasources/chats_remote_datasource.dart';
import 'package:maser/app/chats/data/repositories/chats_repository_impl.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/usecases/get_chat_groups.dart';
import 'package:maser/app/chats/domain/usecases/get_user_details.dart';
import 'package:maser/app/chats/presentation/viewmodels/chat_messaging_page_viewmodel.dart';
import 'package:maser/core/managers/navigation/route_constants.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/services/network/network_info.dart';

class ChatGroupsPageViewmodel extends GetxController {
  final _getMentorDetails = GetUserDetails(
    ChatsRepositoryImpl(
      remoteDatasource: ChatsRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  Stream<QuerySnapshot<Object>> chatGroupsStream() =>
      ChatsRemoteDatasourceImpl().chatGroupsStream();

  Future<User> fetchMentorDetails(String mentorId) async {
    final result = await _getMentorDetails(Params(userId: mentorId));
    if (result.isLeft()) {
      Get.showSnackbar(GetBar(
        message: 'Something went wrong',
        duration: Duration(seconds: 2),
      ));
    }
    return result.getOrElse(null);
  }

  void navigateToChatMessagingPage(ChatGroup chatGroup) {
    Get.put(ChatMessagingPageViewmodel(chatGroup));
    Get.toNamed(RouteConstants.chatMessagingPage).then((value) {
      Get.delete<ChatMessagingPageViewmodel>();
    });
  }
}
