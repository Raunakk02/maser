import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/app/chats/domain/usecases/delete_chat_group.dart';
import 'package:maser/core/error/failures.dart';
import 'package:mockito/mockito.dart';

class MockChatsRepository extends Mock implements ChatsRepository {}

void main() {
  DeleteChatGroup useCase;
  MockChatsRepository mockChatsRepository;

  setUp(() {
    mockChatsRepository = MockChatsRepository();
    useCase = DeleteChatGroup(mockChatsRepository);
  });

  final tChatGroupId = 'test_chat_group_id';

  test(
    'should return a null when the chat group is successfully deleted',
    () async {
      // arrange
      when(mockChatsRepository.deleteChatGroup(any)).thenAnswer((_) async => Right(null));

      // act
      final result = await useCase(Params(chatGroupId: tChatGroupId));

      // assert
      verify(mockChatsRepository.deleteChatGroup(any));
      expect(result, Right(null));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );

  test(
    'should return a ServerFailure when the deletion is unsuccessfull',
    () async {
      // arrange
      when(mockChatsRepository.deleteChatGroup(any))
          .thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(Params(chatGroupId: tChatGroupId));

      // assert
      verify(mockChatsRepository.deleteChatGroup(any));
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockChatsRepository);
    },
  );
}
