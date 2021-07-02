import 'package:dartz/dartz.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/core/error/failures.dart';

abstract class StoriesRepository {
  Future<Either<Failure, List<Story>>> getStories();
  Future<Either<Failure, String>> createStory(Story story);
  Future<Either<Failure, void>> deleteStory(String storyId);
  Future<Either<Failure, void>> likeStory(String storyId);
  Future<Either<Failure, void>> undoLikeStory(String storyId);
  Future<Either<Failure, List<String>>> getLikedStories();
  Future<Either<Failure, void>> addStoryToFavorite(String storyId);
  Future<Either<Failure, void>> deleteStoryFromFavorite(String storyId);
  Future<Either<Failure, List<String>>> getFavStories();
}
