import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/app/chats/domain/usecases/send_chat_message.dart';
import 'package:maser/core/error/failures.dart';
import 'package:mockito/mockito.dart';

class MockChatsRepository extends Mock implements ChatsRepository {}

void main() {
  SendChatMessage useCase;
  MockChatsRepository mockChatsRepository;

  setUp(() {
    mockChatsRepository = MockChatsRepository();
    useCase = SendChatMessage(mockChatsRepository);
  });

  final tMentorId = 'test_mentor_id';
  final tChatGroup = ChatGroup(
    id: 'test_chat_group_id',
    mentorId: tMentorId,
    messages: [],
  );
  final tChatMessage = ChatMessage(
    id: 'test id',
    msg: 'test msg',
    uid: 'test uid',
    timestamp: DateTime(2000),
  );

  test(
    'should return null when the chat message is successfully sent',
    () async {
      // arrange
      when(mockChatsRepository.sendChatMessage(any, any))
          .thenAnswer((_) async => Right(tChatGroup.id));

      // act
      final result = await useCase(Params(chatGroupId: tChatGroup.id, message: tChatMessage));

      // assert
      verify(mockChatsRepository.sendChatMessage(tChatGroup.id, tChatMessage));
      expect(result, Right(tChatGroup.id));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );

  test(
    'should return a ServerFailure when the creation is unsuccessfull',
    () async {
      // arrange
      when(mockChatsRepository.sendChatMessage(any, any))
          .thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(Params(chatGroupId: tChatGroup.id, message: tChatMessage));

      // assert
      verify(mockChatsRepository.sendChatMessage(tChatGroup.id, tChatMessage));
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );
}
