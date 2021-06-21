import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/auth/domain/repositories/auth_repository.dart';
import 'package:maser/app/auth/domain/usecases/sign_in_with_google.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  SignInWithGoogle useCase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignInWithGoogle(mockAuthRepository);
  });

  final tUser = User(
    id: 'test id',
    name: 'test name',
    email: 'test email',
    phone: '1234567890',
    imageUrl: 'test imageUrl',
  );

  test(
    'should return a valid User when the sign in with google is successfull',
    () async {
      // arrange
      when(mockAuthRepository.signInwithGoogle()).thenAnswer((_) async => Right(tUser));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockAuthRepository.signInwithGoogle());
      expect(result, Right(tUser));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test(
    'should return a Failure when the sign in with google is unsuccessfull',
    () async {
      // arrange
      when(mockAuthRepository.signInwithGoogle()).thenAnswer((_) async => Left(AuthFailure()));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockAuthRepository.signInwithGoogle());
      expect(result, Left(AuthFailure()));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
