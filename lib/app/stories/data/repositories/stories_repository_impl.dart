import 'package:flutter/foundation.dart';
import 'package:maser/app/stories/data/datasources/stories_remote_datasource.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/services/network/network_info.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final StoriesRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  StoriesRepositoryImpl({
    @required this.remoteDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Story>>> getStories() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.getStories());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> createStory(Story story) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.createStory(story));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likeStory(String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.likeStory(storyId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addStoryToFavorite(String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.addStoryToFavorite(storyId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteStory(String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.deleteStory(storyId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFavStories() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.getFavStories());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteStoryFromFavorite(String storyId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.deleteStoryFromFavorite(storyId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
