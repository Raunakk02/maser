import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/app/stories/domain/usecases/create_story.dart';
import 'package:maser/core/error/failures.dart';
import 'package:mockito/mockito.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  CreateStory useCase;
  MockStoriesRepository mockStoriesRepository;

  setUp(() {
    mockStoriesRepository = MockStoriesRepository();
    useCase = CreateStory(mockStoriesRepository);
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
    'should return a valid Story Id as string when the story is successfully added',
    () async {
      // arrange
      when(mockStoriesRepository.createStory(any)).thenAnswer((_) async => Right(tStory.id));

      // act
      final result = await useCase(Params(story: tStory));

      // assert
      verify(mockStoriesRepository.createStory(any));
      expect(result, Right(tStory.id));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );

  test(
    'should return a ServerFailure when the story addition is unsuccessful',
    () async {
      // arrange
      when(mockStoriesRepository.createStory(any)).thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(Params(story: tStory));

      // assert
      verify(mockStoriesRepository.createStory(any));
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );
}
