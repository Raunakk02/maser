import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/app/stories/domain/usecases/get_stories.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  GetStories useCase;
  MockStoriesRepository mockStoriesRepository;

  setUp(() {
    mockStoriesRepository = MockStoriesRepository();
    useCase = GetStories(mockStoriesRepository);
  });

  final tStoryList = [
    Story(
      id: 'test id',
      storyTitle: 'test storyTitle',
      storyContent: 'test storyContent',
      imageUrl: 'test imageUrl',
      postedOn: DateTime(2000),
      mentorId: 'test mentorId',
      likeCount: 1,
    ),
    Story(
      id: 'test id',
      storyTitle: 'test storyTitle',
      storyContent: 'test storyContent',
      imageUrl: 'test imageUrl',
      postedOn: DateTime(2000),
      mentorId: 'test mentorId',
      likeCount: 1,
    )
  ];

  test(
    'should return a List<Story> when getStories in repository executes successfully',
    () async {
      // arrange
      when(mockStoriesRepository.getStories()).thenAnswer((_) async => Right(tStoryList));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockStoriesRepository.getStories());
      expect(result, Right(tStoryList));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );

  test(
    'should return a ServerFailure when getStories in repository executes unsuccessfully',
    () async {
      // arrange
      when(mockStoriesRepository.getStories()).thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockStoriesRepository.getStories());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );
}
