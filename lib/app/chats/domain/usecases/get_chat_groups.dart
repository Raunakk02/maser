import 'package:dartz/dartz.dart';
import '../entities/chat_group.dart';
import '../repositories/chats_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetChatGroups implements UseCase<Stream<List<ChatGroup>>, NoParams> {
  final ChatsRepository repository;

  GetChatGroups(this.repository);

  @override
  Future<Either<Failure, Stream<List<ChatGroup>>>> call(NoParams params) async {
    return await repository.getChatGroups();
  }
}
