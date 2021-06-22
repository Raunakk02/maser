import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/profile/data/datasources/profile_remote_datasource.dart';
import 'package:maser/app/profile/data/repositories/profile_repository_impl.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/services/network/network_info.dart';
import 'package:mockito/mockito.dart';

class MockProfileRemoteDatasource extends Mock implements ProfileRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ProfileRepositoryImpl profileRepositoryImpl;
  MockProfileRemoteDatasource remoteDatasource;
  MockNetworkInfo networkInfo;

  setUp(() {
    remoteDatasource = MockProfileRemoteDatasource();
    networkInfo = MockNetworkInfo();
    profileRepositoryImpl = ProfileRepositoryImpl(
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

  group('getUserProfile', () {
    final tUserModel = UserModel(
      id: 'test id',
      name: 'test name',
      email: 'test email',
      phone: '1234567890',
      imageUrl: 'test imageUrl',
    );
    final User tUser = tUserModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // act
        profileRepositoryImpl.getUserProfile();

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return a valid User when the call to remote data source is successful',
        () async {
          // arrange
          when(remoteDatasource.getUserProfile()).thenAnswer((_) async => tUser);

          // act
          final result = await profileRepositoryImpl.getUserProfile();

          // assert
          verify(remoteDatasource.getUserProfile());
          expect(result, equals(Right(tUser)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(remoteDatasource.getUserProfile()).thenThrow(ServerException());

          // act
          final result = await profileRepositoryImpl.getUserProfile();

          // assert
          verify(remoteDatasource.getUserProfile());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return ServerFailure when device is offline',
        () async {
          // act
          final result = await profileRepositoryImpl.getUserProfile();

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
