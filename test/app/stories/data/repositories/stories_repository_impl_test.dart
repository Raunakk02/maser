import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/stories/data/datasources/stories_remote_datasource.dart';
import 'package:maser/app/stories/data/models/story_model.dart';
import 'package:maser/app/stories/data/repositories/stories_repository_impl.dart';
import 'package:maser/app/stories/domain/entities/story.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/services/network/network_info.dart';
import 'package:mockito/mockito.dart';

class MockStoriesRemoteDatasource extends Mock implements StoriesRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  StoriesRepositoryImpl storiesRepositoryImpl;
  MockStoriesRemoteDatasource remoteDatasource;
  MockNetworkInfo networkInfo;

  setUp(() {
    remoteDatasource = MockStoriesRemoteDatasource();
    networkInfo = MockNetworkInfo();
    storiesRepositoryImpl = StoriesRepositoryImpl(
      remoteDatasource: remoteDatasource,
      networkInfo: networkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  /// get stories test

  group('getStories', () {
    final tStoryModelList = [
      StoryModel(
        id: 'test id',
        storyTitle: 'test storyTitle',
        storyContent: 'test storyContent',
        imageUrl: 'test imageUrl',
        postedOn: DateTime(2000),
        mentorId: 'test mentorId',
        likeCount: 1,
      ),
      StoryModel(
        id: 'test id',
        storyTitle: 'test storyTitle',
        storyContent: 'test storyContent',
        imageUrl: 'test imageUrl',
        postedOn: DateTime(2000),
        mentorId: 'test mentorId',
        likeCount: 1,
      )
    ];
    final List<Story> tStoryList = tStoryModelList;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // act
        storiesRepositoryImpl.getStories();

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return a valid story list when the call to remote data source is successful',
        () async {
          // arrange
          when(remoteDatasource.getStories()).thenAnswer((_) async => tStoryList);

          // act
          final result = await storiesRepositoryImpl.getStories();

          // assert
          verify(remoteDatasource.getStories());
          expect(result, equals(Right(tStoryList)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(remoteDatasource.getStories()).thenThrow(ServerException());

          // act
          final result = await storiesRepositoryImpl.getStories();

          // assert
          verify(remoteDatasource.getStories());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ServerFailure when device is offline',
        () async {
          // act
          final result = await storiesRepositoryImpl.getStories();

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });

  /// create story test

  group('createStory', () {
    final tStoryModel = StoryModel(
      id: 'test id',
      storyTitle: 'test storyTitle',
      storyContent: 'test storyContent',
      imageUrl: 'test imageUrl',
      postedOn: DateTime(2000),
      mentorId: 'test mentorId',
      likeCount: 1,
    );
    final Story tStory = tStoryModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // act
        storiesRepositoryImpl.createStory(tStory);

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return a valid string representing document Id when the call to remote data source is successful',
        () async {
          // arrange
          when(remoteDatasource.createStory(any)).thenAnswer((_) async => tStory.id);

          // act
          final result = await storiesRepositoryImpl.createStory(tStory);

          // assert
          verify(remoteDatasource.createStory(tStory));
          expect(result, equals(Right(tStory.id)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(remoteDatasource.createStory(any)).thenThrow(ServerException());

          // act
          final result = await storiesRepositoryImpl.createStory(tStory);

          // assert
          verify(remoteDatasource.createStory(tStory));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ServerFailure when device is offline',
        () async {
          // act
          final result = await storiesRepositoryImpl.createStory(tStory);

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });

  /// like story test

  group('likeStory', () {
    final tStoryModel = StoryModel(
      id: 'test id',
      storyTitle: 'test storyTitle',
      storyContent: 'test storyContent',
      imageUrl: 'test imageUrl',
      postedOn: DateTime(2000),
      mentorId: 'test mentorId',
      likeCount: 1,
    );
    final Story tStory = tStoryModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // act
        storiesRepositoryImpl.likeStory(tStory.id);

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return a null when the call to remote data source is successful',
        () async {
          // arrange
          when(remoteDatasource.likeStory(any)).thenAnswer((_) async => null);

          // act
          final result = await storiesRepositoryImpl.likeStory(tStory.id);

          // assert
          verify(remoteDatasource.likeStory(tStory.id));
          expect(result, equals(Right(null)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(remoteDatasource.likeStory(any)).thenThrow(ServerException());

          // act
          final result = await storiesRepositoryImpl.likeStory(tStory.id);

          // assert
          verify(remoteDatasource.likeStory(tStory.id));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ServerFailure when device is offline',
        () async {
          // act
          final result = await storiesRepositoryImpl.likeStory(tStory.id);

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });

  /// add story to favorite test

  group('addStoryToFavorite', () {
    final tStoryModel = StoryModel(
      id: 'test id',
      storyTitle: 'test storyTitle',
      storyContent: 'test storyContent',
      imageUrl: 'test imageUrl',
      postedOn: DateTime(2000),
      mentorId: 'test mentorId',
      likeCount: 1,
    );
    final Story tStory = tStoryModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // act
        storiesRepositoryImpl.addStoryToFavorite(tStory.id);

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return a null when the call to remote data source is successful',
        () async {
          // arrange
          when(remoteDatasource.addStoryToFavorite(any)).thenAnswer((_) async => null);

          // act
          final result = await storiesRepositoryImpl.addStoryToFavorite(tStory.id);

          // assert
          verify(remoteDatasource.addStoryToFavorite(tStory.id));
          expect(result, equals(Right(null)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(remoteDatasource.addStoryToFavorite(any)).thenThrow(ServerException());

          // act
          final result = await storiesRepositoryImpl.addStoryToFavorite(tStory.id);

          // assert
          verify(remoteDatasource.addStoryToFavorite(tStory.id));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ServerFailure when device is offline',
        () async {
          // act
          final result = await storiesRepositoryImpl.addStoryToFavorite(tStory.id);

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });

  /// delete story test

  group('deleteStory', () {
    final tStoryModel = StoryModel(
      id: 'test id',
      storyTitle: 'test storyTitle',
      storyContent: 'test storyContent',
      imageUrl: 'test imageUrl',
      postedOn: DateTime(2000),
      mentorId: 'test mentorId',
      likeCount: 1,
    );
    final Story tStory = tStoryModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // act
        storiesRepositoryImpl.deleteStory(tStory.id);

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return a null when the call to remote data source is successful',
        () async {
          // arrange
          when(remoteDatasource.deleteStory(any)).thenAnswer((_) async => null);

          // act
          final result = await storiesRepositoryImpl.deleteStory(tStory.id);

          // assert
          verify(remoteDatasource.deleteStory(tStory.id));
          expect(result, equals(Right(null)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(remoteDatasource.deleteStory(any)).thenThrow(ServerException());

          // act
          final result = await storiesRepositoryImpl.deleteStory(tStory.id);

          // assert
          verify(remoteDatasource.deleteStory(tStory.id));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ServerFailure when device is offline',
        () async {
          // act
          final result = await storiesRepositoryImpl.deleteStory(tStory.id);

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
