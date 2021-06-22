import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/core/usecases/usecase.dart';

class CreateStory implements UseCase<String, Params> {
  final StoriesRepository repository;

  CreateStory(this.repository);

  @override
  Future<Either<Failure, String>> call(params) async {
    return await repository.createStory(params.story);
  }
}

class Params extends Equatable {
  final Story story;

  Params({@required this.story});
  @override
  List<Object> get props => [story];
}
