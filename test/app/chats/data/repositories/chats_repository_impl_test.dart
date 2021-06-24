// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:maser/app/chats/data/datasources/chats_remote_datasource.dart';
// import 'package:maser/app/chats/data/models/chat_group_model.dart';
// import 'package:maser/app/chats/data/models/chat_message_model.dart';
// import 'package:maser/app/chats/data/repositories/chats_repository_impl.dart';
// import 'package:maser/app/chats/domain/entities/chat_group.dart';
// import 'package:maser/core/error/exceptions.dart';
// import 'package:maser/core/error/failures.dart';
// import 'package:maser/core/services/network/network_info.dart';
// import 'package:mockito/mockito.dart';

// class MockChatsRemoteDatasource extends Mock implements ChatsRemoteDatasource {}

// class MockNetworkInfo extends Mock implements NetworkInfo {}

// void main() {
//   ChatsRepositoryImpl chatsRepositoryImpl;
//   MockChatsRemoteDatasource remoteDatasource;
//   MockNetworkInfo networkInfo;

//   setUp(() {
//     remoteDatasource = MockChatsRemoteDatasource();
//     networkInfo = MockNetworkInfo();
//     chatsRepositoryImpl = ChatsRepositoryImpl(
//       remoteDatasource: remoteDatasource,
//       networkInfo: networkInfo,
//     );
//   });

//   void runTestsOnline(Function body) {
//     group('device is online', () {
//       setUp(() {
//         when(networkInfo.isConnected).thenAnswer((_) async => true);
//       });

//       body();
//     });
//   }

//   void runTestsOffline(Function body) {
//     group('device is offline', () {
//       setUp(() {
//         when(networkInfo.isConnected).thenAnswer((_) async => false);
//       });

//       body();
//     });
//   }

//   group('getChatGroups', () {
//     final tModelList = [
//       ChatGroupModel(
//         id: 'test id',
//         mentorId: 'test mentorId',
//         messages: [
//           ChatMessageModel(
//             id: 'test id',
//             msg: 'test msg',
//             uid: 'test uid',
//             timestamp: DateTime(2000),
//           ),
//         ],
//       ),
//       ChatGroupModel(
//         id: 'test id',
//         mentorId: 'test mentorId',
//         messages: [
//           ChatMessageModel(
//             id: 'test id',
//             msg: 'test msg',
//             uid: 'test uid',
//             timestamp: DateTime(2000),
//           ),
//         ],
//       ),
//     ];
//     final List<ChatGroup> tList = tModelList;

//     test(
//       'should check if the device is online',
//       () async {
//         // arrange
//         when(networkInfo.isConnected).thenAnswer((_) async => true);

//         // act
//         chatsRepositoryImpl.getChatGroups();

//         // assert
//         verify(networkInfo.isConnected);
//       },
//     );

//     runTestsOnline(() {
//       test(
//         'should return remote data when the call to remote data source is successful',
//         () async {
//           // arrange
//           when(remoteDatasource.getChatGroups()).thenAnswer((_) async => tList);

//           // act
//           final result = await chatsRepositoryImpl.getChatGroups();

//           // assert
//           verify(remoteDatasource.getChatGroups());
//           expect(result, equals(Right(tList)));
//         },
//       );

//       test(
//         'should return ServerFailure when the call to remote data source is unsuccessful',
//         () async {
//           // arrange
//           when(remoteDatasource.getChatGroups()).thenThrow(ServerException());

//           // act
//           final result = await chatsRepositoryImpl.getChatGroups();

//           // assert
//           verify(remoteDatasource.getChatGroups());
//           expect(result, equals(Left(ServerFailure())));
//         },
//       );
//     });

//     runTestsOffline(() {
//       test(
//         'should return ServerFailure when device is offline',
//         () async {
//           // act
//           final result = await chatsRepositoryImpl.getChatGroups();

//           // assert
//           verifyZeroInteractions(remoteDatasource);
//           expect(result, equals(Left(ServerFailure())));
//         },
//       );
//     });
//   });

//   group('deleteChatGroup', () {
//     final tChatGroupModel = ChatGroupModel(
//       id: 'test id',
//       mentorId: 'test mentorId',
//       messages: [
//         ChatMessageModel(
//           id: 'test id',
//           msg: 'test msg',
//           uid: 'test uid',
//           timestamp: DateTime(2000),
//         ),
//       ],
//     );
//     final ChatGroup tChatGroup = tChatGroupModel;

//     test(
//       'should check if the device is online',
//       () async {
//         // arrange
//         when(networkInfo.isConnected).thenAnswer((_) async => true);

//         // act
//         chatsRepositoryImpl.deleteChatGroup(tChatGroup.id);

//         // assert
//         verify(networkInfo.isConnected);
//       },
//     );

//     runTestsOnline(() {
//       test(
//         'should return null when the call to remote data source is successful',
//         () async {
//           // arrange
//           when(remoteDatasource.deleteChatGroup(any)).thenAnswer((_) async => null);

//           // act
//           final result = await chatsRepositoryImpl.deleteChatGroup(tChatGroup.id);

//           // assert
//           verify(remoteDatasource.deleteChatGroup(tChatGroup.id));
//           expect(result, equals(Right(null)));
//         },
//       );

//       test(
//         'should return ServerFailure when the call to remote data source is unsuccessful',
//         () async {
//           // arrange
//           when(remoteDatasource.deleteChatGroup(any)).thenThrow(ServerException());

//           // act
//           final result = await chatsRepositoryImpl.deleteChatGroup(tChatGroup.id);

//           // assert
//           verify(remoteDatasource.deleteChatGroup(tChatGroup.id));
//           expect(result, equals(Left(ServerFailure())));
//         },
//       );
//     });

//     runTestsOffline(() {
//       test(
//         'should return ServerFailure when device is offline',
//         () async {
//           // act
//           final result = await chatsRepositoryImpl.deleteChatGroup(tChatGroup.id);

//           // assert
//           verifyZeroInteractions(remoteDatasource);
//           expect(result, equals(Left(ServerFailure())));
//         },
//       );
//     });
//   });

//   group('createChatGroup', () {
//     final tMentorId = 'test mentorId';
//     final tChatGroupModel = ChatGroupModel(
//       id: 'test id',
//       mentorId: tMentorId,
//       messages: [
//         ChatMessageModel(
//           id: 'test id',
//           msg: 'test msg',
//           uid: 'test uid',
//           timestamp: DateTime(2000),
//         ),
//       ],
//     );
//     final ChatGroup tChatGroup = tChatGroupModel;

//     test(
//       'should check if the device is online',
//       () async {
//         // arrange
//         when(networkInfo.isConnected).thenAnswer((_) async => true);

//         // act
//         chatsRepositoryImpl.createChatGroup(tMentorId);

//         // assert
//         verify(networkInfo.isConnected);
//       },
//     );

//     runTestsOnline(() {
//       test(
//         'should return chatGroup id as string when the call to remote data source is successful',
//         () async {
//           // arrange
//           when(remoteDatasource.createChatGroup(any)).thenAnswer((_) async => tChatGroup.mentorId);

//           // act
//           final result = await chatsRepositoryImpl.createChatGroup(tMentorId);

//           // assert
//           verify(remoteDatasource.createChatGroup(tMentorId));
//           expect(result, equals(Right(tChatGroup.mentorId)));
//         },
//       );

//       test(
//         'should return ServerFailure when the call to remote data source is unsuccessful',
//         () async {
//           // arrange
//           when(remoteDatasource.createChatGroup(any)).thenThrow(ServerException());

//           // act
//           final result = await chatsRepositoryImpl.createChatGroup(tMentorId);

//           // assert
//           verify(remoteDatasource.createChatGroup(tMentorId));
//           expect(result, equals(Left(ServerFailure())));
//         },
//       );
//     });

//     runTestsOffline(() {
//       test(
//         'should return ServerFailure when device is offline',
//         () async {
//           // act
//           final result = await chatsRepositoryImpl.createChatGroup(tMentorId);

//           // assert
//           verifyZeroInteractions(remoteDatasource);
//           expect(result, equals(Left(ServerFailure())));
//         },
//       );
//     });
//   });
// }
