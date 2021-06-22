import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/app/chats/domain/usecases/create_chat_group.dart';
import 'package:maser/core/error/failures.dart';
import 'package:mockito/mockito.dart';

class MockChatsRepository extends Mock implements ChatsRepository {}

void main() {
  CreateChatGroup useCase;
  MockChatsRepository mockChatsRepository;

  setUp(() {
    mockChatsRepository = MockChatsRepository();
    useCase = CreateChatGroup(mockChatsRepository);
  });

  final tMentorId = 'test_mentor_id';
  final tChatGroup = ChatGroup(
    id: 'test_chat_group_id',
    mentorId: tMentorId,
    messages: [],
  );

  test(
    'should return a string containing ChatGroup id when the chat group is successfully created',
    () async {
      // arrange
      when(mockChatsRepository.createChatGroup(any)).thenAnswer((_) async => Right(tChatGroup.id));

      // act
      final result = await useCase(Params(mentorId: tMentorId));

      // assert
      verify(mockChatsRepository.createChatGroup(any));
      expect(result, Right(tChatGroup.id));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );

  test(
    'should return a ServerFailure when the creation is unsuccessfull',
    () async {
      // arrange
      when(mockChatsRepository.createChatGroup(any))
          .thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(Params(mentorId: tMentorId));

      // assert
      verify(mockChatsRepository.createChatGroup(any));
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );
}
