import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:maser/app/chats/data/models/chat_group_model.dart';
import 'package:maser/app/chats/data/models/chat_message_model.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/models/user.dart';

abstract class ChatsRemoteDatasource {
  /// Calls firebase to return all the chat group documents
  /// for the current signed in user
  /// in chat_groups/userId collection.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Stream<List<ChatGroup>>> getChatGroups();

  /// Calls firebase to delete a particular chat group document
  /// with the given chatGroupId
  /// in the chat_groups/userId collection.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> deleteChatGroup(String chatGroupId);

  /// Calls firebase to create a particular chat group document
  /// in the chat_groups/userId/ collection
  /// with provided mentorId as doc id.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> createChatGroup(String mentorId);

  /// Calls firebase to fetch a particular chat group document
  /// in the chat_groups/userId/ collection
  /// with provided mentorId as doc id.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ChatGroup> getChatGroup(String mentorId);

  /// calls firebaseasdf

  Future<User> getUserDetails(String userId);

  /// Calls firebase to add a new chat message
  /// in the messages field of chat group document
  /// in the chat_groups/userId collection
  /// with provided mentorId.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> sendChatMessage(String mentorId, ChatMessage message);
}

class ChatsRemoteDatasourceImpl implements ChatsRemoteDatasource {
  final userId = firebaseAuth.FirebaseAuth.instance.currentUser.uid;

  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection("users");

  CollectionReference _chatGroupsCollection =
      FirebaseFirestore.instance.collection("chat_groups");

  CollectionReference _getUserChatsCollection(String _userId) {
    return _chatGroupsCollection.doc(_userId).collection("user_chats");
  }

  @override
  Future<String> createChatGroup(String mentorId) async {
    final newUserChatGroup = ChatGroupModel(
      id: mentorId,
      mentorId: mentorId,
      messages: <ChatMessageModel>[],
    );
    final newMentorChatGroup = ChatGroupModel(
      id: userId,
      mentorId: userId,
      messages: <ChatMessageModel>[],
    );
    try {
      //set chat group for the person who clicked on chat icon on story
      final _userChatsCollection = _getUserChatsCollection(userId);
      final doc = _userChatsCollection.doc(mentorId);
      final docSnapshot = await doc.get();
      if (docSnapshot.exists) {
        return mentorId;
      }
      await doc.set(newUserChatGroup.toJson());

      //set chat group for the mentor in his user_chats collection
      final _mentorChatsCollection = _getUserChatsCollection(mentorId);
      final mentorChatDoc = _mentorChatsCollection.doc(userId);
      final mentorDocSnapshot = await mentorChatDoc.get();
      if (mentorDocSnapshot.exists) {
        return mentorId;
      }
      await mentorChatDoc.set(newMentorChatGroup.toJson());
    } catch (e) {
      throw ServerException();
    }
    return newUserChatGroup.id;
  }

  @override
  Future<void> deleteChatGroup(String chatGroupId) {
    return null;
  }

  @override
  Future<Stream<List<ChatGroup>>> getChatGroups() async {
    Stream<List<ChatGroup>> _chatGroupsStream;
    // List<ChatGroup> _chatGroups;
    // try {
    //   final querySnapshot = _getUserChatsCollection(userId).snapshots();
    //   querySnapshot.listen((event) {
    //     event.docs.forEach((doc) {
    //       final chatGroup = ChatGroupModel.fromJson(doc as Map);
    //       _chatGroups.add(chatGroup);
    //     });});
    //   _chatGroupsStream = Stream.value(_chatGroups);
    // } catch (e) {
    //   throw ServerException();
    // }
    return _chatGroupsStream;
  }

  @override
  Future<void> sendChatMessage(String mentorId, ChatMessage message) {
    return null;
  }

  @override
  Future<ChatGroup> getChatGroup(String mentorId) async {
    ChatGroup chatGroup;
    try {
      final _userChatsCollection = _getUserChatsCollection(userId);
      final docSnapshot = await _userChatsCollection.doc(mentorId).get();
      if (docSnapshot.exists) {
        final Map<String, dynamic> data = docSnapshot.data();
        chatGroup = ChatGroupModel.fromJson(data);
      }
    } catch (e) {
      throw ServerException();
    }
    return chatGroup;
  }

  @override
  Future<User> getUserDetails(String userId) async {
    User _user;
    try {
      final docSnapshot = await _usersCollection.doc(userId).get();
      if (docSnapshot.exists) {
        final Map<String, dynamic> data = docSnapshot.data();
        _user = UserModel.fromJson(data);
      }
    } catch (e) {
      throw ServerException();
    }
    return _user;
  }

  Stream<QuerySnapshot<Object>> chatGroupsStream() {
    return _getUserChatsCollection(userId).snapshots();
  }
}
