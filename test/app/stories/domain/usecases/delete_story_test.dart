import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/app/stories/domain/repositories/stories_repository.dart';
import 'package:maser/app/stories/domain/usecases/delete_story.dart';
import 'package:maser/core/error/failures.dart';
import 'package:mockito/mockito.dart';

class MockStoriesRepository extends Mock implements StoriesRepository {}

void main() {
  DeleteStory useCase;
  MockStoriesRepository mockStoriesRepository;

  setUp(() {
    mockStoriesRepository = MockStoriesRepository();
    useCase = DeleteStory(mockStoriesRepository);
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
    'should return a null when the story deletion is successful',
    () async {
      // arrange
      when(mockStoriesRepository.deleteStory(any)).thenAnswer((_) async => Right(null));

      // act
      final result = await useCase(Params(storyId: tStory.id));

      // assert
      verify(mockStoriesRepository.deleteStory(tStory.id));
      expect(result, Right(null));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );

  test(
    'should return a ServerFailure when the story deletion is unsuccessful',
    () async {
      // arrange
      when(mockStoriesRepository.deleteStory(any)).thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(Params(storyId: tStory.id));

      // assert
      verify(mockStoriesRepository.deleteStory(tStory.id));
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockStoriesRepository);
    },
  );
}
