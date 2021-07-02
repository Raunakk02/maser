import 'package:dartz/dartz.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/usecases/usecase.dart';

class GetFavStories extends UseCase<List<String>, NoParams> {
  final StoriesRepository repository;

  GetFavStories(this.repository);
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getFavStories();
  }
}
