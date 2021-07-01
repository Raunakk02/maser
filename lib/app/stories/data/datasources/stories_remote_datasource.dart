import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maser/app/stories/data/models/story_model.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/core/error/exceptions.dart';

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

class StoriesRemoteDatasourceImpl implements StoriesRemoteDatasource {
  CollectionReference _storiesCollection =
      FirebaseFirestore.instance.collection('stories');
  @override
  Future<void> addStoryToFavorite(String storyId) {
    return null;
  }

  @override
  Future<String> createStory(Story story) async {
    final pStoryModel = StoryModel(
      id: story.id,
      storyTitle: story.storyTitle,
      storyContent: story.storyContent,
      imageUrl: story.imageUrl,
      postedOn: story.postedOn,
      mentorId: story.mentorId,
      likeCount: story.likeCount,
    );
    try {
      final ref = await _storiesCollection.add(pStoryModel.toJson());
      final rStoryModel = StoryModel(
        id: ref.id,
        storyTitle: story.storyTitle,
        storyContent: story.storyContent,
        imageUrl: story.imageUrl,
        postedOn: story.postedOn,
        mentorId: story.mentorId,
        likeCount: story.likeCount,
      );
      await _storiesCollection.doc(ref.id).update(rStoryModel.toJson());
    } catch (e) {
      throw ServerException();
    }
    return null;
  }

  @override
  Future<void> deleteStory(String storyId) {
    return null;
  }

  @override
  Future<List<Story>> getStories() {
    return null;
  }

  @override
  Future<void> likeStory(String storyId) {
    return null;
  }
}
