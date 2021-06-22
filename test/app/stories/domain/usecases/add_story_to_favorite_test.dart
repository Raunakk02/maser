import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/app/stories/domain/usecases/add_story_to_favorite.dart';
import 'package:maser/core/error/failures.dart';
import 'package:mockito/mockito.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  AddStoryToFavorite useCase;
  MockStoriesRepository mockStoriesRepository;

  setUp(() {
    mockStoriesRepository = MockStoriesRepository();
    useCase = AddStoryToFavorite(mockStoriesRepository);
  });

  final tStory = Story(
    id: 'test id',
    storyTitle: 'test storyTitle',
    storyContent: 'test storyContent',
    imageUrl: 'test imageUrl',
    postedOn: DateTime(2000),
    mentorId: 'test mentorId',
    likeCount: 1,
  );

  test(
    'should return a null when the story addition to favorite is successful',
    () async {
      // arrange
      when(mockStoriesRepository.addStoryToFavorite(any)).thenAnswer((_) async => Right(null));

      // act
      final result = await useCase(Params(storyId: tStory.id));

      // assert
      verify(mockStoriesRepository.addStoryToFavorite(tStory.id));
      expect(result, Right(null));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );

  test(
    'should return a ServerFailure when the story addition to favorite is unsuccessful',
    () async {
      // arrange
      when(mockStoriesRepository.addStoryToFavorite(any))
          .thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(Params(storyId: tStory.id));

      // assert
      verify(mockStoriesRepository.addStoryToFavorite(tStory.id));
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );
}
