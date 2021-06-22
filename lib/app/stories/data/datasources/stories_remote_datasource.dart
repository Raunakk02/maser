import 'package:maser/app/stories/domain/entities/story.dart';

abstract class StoriesRemoteDatasource {
  /// Calls firebase to fetch all stories
  /// from the stories collection
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<Story>> getStories();

  /// Calls firebase to add new story
  /// in stories collection
  ///
  /// Throws a [ServerException] for all error codes.
  Future<String> createStory(Story story);

  /// Calls firebase to increase story likes by 1
  /// in storiesId document of stories collection
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> likeStory(String storyId);

  /// Calls firebase to add storyId to
  /// user_id document in favorite_stories collection
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> addStoryToFavorite(String storyId);

  /// Calls firebase to delete story having given storyId
  /// in stories collection and
  /// also delete the storyId from
  /// user_id document in favorite_stories collection
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> deleteStory(String storyId);
}
