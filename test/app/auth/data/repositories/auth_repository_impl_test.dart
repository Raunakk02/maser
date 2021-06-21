import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/auth/data/datasources/auth_remote_datasource.dart';
import 'package:maser/app/auth/data/repositories/auth_repository_impl.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/services/network/network_info.dart';
import 'package:mockito/mockito.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AuthRepositoryImpl authRepositoryImpl;
  MockAuthRemoteDatasource remoteDatasource;
  MockNetworkInfo networkInfo;

  setUp(() {
    remoteDatasource = MockAuthRemoteDatasource();
    networkInfo = MockNetworkInfo();
    authRepositoryImpl = AuthRepositoryImpl(
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

  group('signInwithGoogle', () {
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
        authRepositoryImpl.signInwithGoogle();

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(remoteDatasource.signInWithGoogle()).thenAnswer((_) async => tUser);

          // act
          final result = await authRepositoryImpl.signInwithGoogle();

          // assert
          verify(remoteDatasource.signInWithGoogle());
          expect(result, equals(Right(tUser)));
        },
      );

      test(
        'should return AuthFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(remoteDatasource.signInWithGoogle()).thenThrow(AuthException());

          // act
          final result = await authRepositoryImpl.signInwithGoogle();

          // assert
          verify(remoteDatasource.signInWithGoogle());
          expect(result, equals(Left(AuthFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return AuthFailure when device is offline',
        () async {
          // act
          final result = await authRepositoryImpl.signInwithGoogle();

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(AuthFailure())));
        },
      );
    });
  });

  group('logoutUser', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);

        // act
        authRepositoryImpl.logoutUser();

        // assert
        verify(networkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should logout user when the device is online',
        () async {
          // arrange
          when(remoteDatasource.logoutUser()).thenAnswer((_) async => null);

          // act
          final result = await authRepositoryImpl.logoutUser();

          // assert
          verify(remoteDatasource.logoutUser());
          expect(result, Right(null));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return AuthFailure when device is offline',
        () async {
          // act
          final result = await authRepositoryImpl.logoutUser();

          // assert
          verifyZeroInteractions(remoteDatasource);
          expect(result, equals(Left(AuthFailure())));
        },
      );
    });
  });
}
