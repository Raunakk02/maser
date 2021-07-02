import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  /// Calls firebase to get storyIds from
  /// user_id document in favorite_stories collection
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<String>> getFavStories();

  /// Calls firebase to remove storyId from
  /// user_id document in favorite_stories collection
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> deleteStoryFromFavorite(String storyId);

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
  CollectionReference _favStoriesCollection =
      FirebaseFirestore.instance.collection('favorite_stories');

  @override
  Future<void> addStoryToFavorite(String storyId) async {
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final doc = await _favStoriesCollection.doc(userId).get();
      if (!doc.exists) {
        await _favStoriesCollection.doc(userId).set({
          "storyIds": FieldValue.arrayUnion([storyId]),
        });
      } else {
        await _favStoriesCollection.doc(userId).update({
          "storyIds": FieldValue.arrayUnion([storyId]),
        });
      }
    } catch (e) {
      throw ServerException();
    }
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
  Future<List<Story>> getStories() async {
    List<Story> _stories = [];
    try {
      final querySnapshot = await _storiesCollection.get();
      querySnapshot.docs.forEach((doc) {
        final story = Story(
          id: doc["id"] as String,
          storyTitle: doc["storyTitle"] as String,
          storyContent: doc["storyContent"] as String,
          imageUrl: doc["imageUrl"] as String,
          postedOn: DateTime.parse(doc["postedOn"] as String),
          mentorId: doc["mentorId"] as String,
          likeCount: doc["likeCount"] as int,
        );
        _stories.add(story);
      });
    } catch (e) {
      throw ServerException();
    }
    return _stories;
  }

  @override
  Future<void> likeStory(String storyId) {
    return null;
  }

  @override
  Future<List<String>> getFavStories() async {
    List<String> _favStories = [];
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final docSnapshot = await _favStoriesCollection.doc(userId).get();
      final Map<String, dynamic> data = docSnapshot.data();

      final fetchedStoryList = data["storyIds"] as List;
      fetchedStoryList.forEach((element) {
        _favStories.add(element.toString());
      });
    } catch (e) {
      throw ServerException();
    }
    return _favStories;
  }

  @override
  Future<void> deleteStoryFromFavorite(String storyId) async {
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final doc = await _favStoriesCollection.doc(userId).get();
      if (doc.exists) {
        await _favStoriesCollection.doc(userId).update({
          "storyIds": FieldValue.arrayRemove([storyId]),
        });
      }
    } catch (e) {
      throw ServerException();
    }
    return null;
  }
}
