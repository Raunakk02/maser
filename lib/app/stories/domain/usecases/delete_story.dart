import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/core/usecases/usecase.dart';

class DeleteStory implements UseCase<void, Params> {
  final StoriesRepository repository;

  DeleteStory(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.deleteStory(params.storyId);
  }
}

class Params extends Equatable {
  final String storyId;

  Params({@required this.storyId});
  @override
  List<Object> get props => [storyId];
}
