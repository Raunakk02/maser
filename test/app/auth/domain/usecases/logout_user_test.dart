import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/auth/domain/repositories/auth_repository.dart';
import 'package:maser/app/auth/domain/usecases/logout_user.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  LogoutUser useCase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LogoutUser(mockAuthRepository);
  });

  test(
    'should return a void when the logout is successfull',
    () async {
      // arrange
      when(mockAuthRepository.logoutUser()).thenAnswer((_) async => Right(null));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockAuthRepository.logoutUser());
      expect(result, Right(null));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'should return a Failure when the logout is unsuccessfull',
    () async {
      // arrange
      when(mockAuthRepository.logoutUser()).thenAnswer((_) async => (Left(AuthFailure())));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockAuthRepository.logoutUser());
      expect(result, Left(AuthFailure()));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
