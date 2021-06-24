import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/app/chats/domain/usecases/get_chat_groups.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';

class MockChatsRepository extends Mock implements ChatsRepository {}

void main() {
  GetChatGroups useCase;
  MockChatsRepository mockChatsRepository;

  setUp(() {
    mockChatsRepository = MockChatsRepository();
    useCase = GetChatGroups(mockChatsRepository);
  });

  final tList = [
    ChatGroup(id: 'test id', mentorId: 'test mentorId', messages: []),
    ChatGroup(id: 'test id', mentorId: 'test mentorId', messages: []),
  ];

  test(
    'should return a List<ChatGroups> when the fetching is successfull',
    () async {
      // arrange
      when(mockChatsRepository.getChatGroups()).thenAnswer((_) async => Right(tList));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockChatsRepository.getChatGroups());
      expect(result, Right(tList));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );

  test(
    'should return a ServerFailure when the fetching is unsuccessfull',
    () async {
      // arrange
      when(mockChatsRepository.getChatGroups()).thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockChatsRepository.getChatGroups());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );
}
