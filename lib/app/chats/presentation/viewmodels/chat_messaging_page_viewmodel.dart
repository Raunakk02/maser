import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';
import 'package:maser/app/chats/data/datasources/chats_remote_datasource.dart';
import 'package:maser/app/chats/data/repositories/chats_repository_impl.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/usecases/get_user_details.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/services/network/network_info.dart';

class ChatMessagingPageViewmodel extends GetxController {
  final ChatGroup chatGroup;
  var mentorDetails = User(
    id: '',
    name: '',
    email: '',
    phone: '',
    imageUrl: '',
  ).obs;

  ChatMessagingPageViewmodel(this.chatGroup);

  @override
  void onInit() {
    fetchMentorDetails(chatGroup.mentorId);
    super.onInit();
  }

  final _getMentorDetails = GetUserDetails(
    ChatsRepositoryImpl(
      remoteDatasource: ChatsRemoteDatasourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    ),
  );

  Future<void> fetchMentorDetails(String mentorId) async {
    final result = await _getMentorDetails(Params(userId: mentorId));

    if (result.isLeft()) {
      Get.showSnackbar(
        GetBar(
          message: 'Something went wrong',
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      final mentor = result.getOrElse(null);
      mentorDetails.value = mentor;
    }
  }
}
