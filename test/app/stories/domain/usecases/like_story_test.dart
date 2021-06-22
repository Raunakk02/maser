import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/app/stories/domain/usecases/like_story.dart';
import 'package:maser/core/error/failures.dart';
import 'package:mockito/mockito.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  LikeStory useCase;
  MockStoriesRepository mockStoriesRepository;

  setUp(() {
    mockStoriesRepository = MockStoriesRepository();
    useCase = LikeStory(mockStoriesRepository);
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
    'should return a null when the story like is successful',
    () async {
      // arrange
      when(mockStoriesRepository.likeStory(any)).thenAnswer((_) async => Right(null));

      // act
      final result = await useCase(Params(storyId: tStory.id));

      // assert
      verify(mockStoriesRepository.likeStory(tStory.id));
      expect(result, Right(null));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );

  test(
    'should return a ServerFailure when the story addition is unsuccessful',
    () async {
      // arrange
      when(mockStoriesRepository.likeStory(any)).thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(Params(storyId: tStory.id));

      // assert
      verify(mockStoriesRepository.likeStory(tStory.id));
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );
}
