import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/stories/data/models/story_model.dart';
import 'package:maser/app/stories/domain/entities/story.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tStoryModel = StoryModel(
    id: 'test id',
    storyTitle: 'test storyTitle',
    storyContent: 'test storyContent',
    imageUrl: 'test imageUrl',
    postedOn: DateTime(2000),
    mentorId: 'test mentorId',
    likeCount: 1,
  );

  test(
    'should be a subclass of Story entity',
    () async {
      // assert
      expect(tStoryModel, isA<Story>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON data is parsed',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('story.json'));

        // act
        final result = StoryModel.fromJson(jsonMap);

        // assert
        expect(result, tStoryModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tStoryModel.toJson();

        // assert
        final expectedMap = {
          "id": "test id",
          "storyTitle": "test storyTitle",
          "storyContent": "test storyContent",
          "imageUrl": "test imageUrl",
          "postedOn": "2000-01-01T00:00:00.000",
          "mentorId": "test mentorId",
          "likeCount": 1
        };
        expect(result, expectedMap);
      },
    );
  });
}
