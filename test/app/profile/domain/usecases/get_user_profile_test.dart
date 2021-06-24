import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/profile/domain/repositories/profile_repository.dart';
import 'package:maser/app/profile/domain/usecases/get_user_profile.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  GetUserProfile useCase;
  MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = GetUserProfile(mockProfileRepository);
  });

  final tUser = User(
    id: 'test id',
    name: 'test name',
    email: 'test email',
    phone: '1234567890',
    imageUrl: 'test imageUrl',
  );

  test(
    'should return a valid User when there is one returned by the repository',
    () async {
      // arrange
      when(mockProfileRepository.getUserProfile()).thenAnswer((_) async => Right(tUser));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockProfileRepository.getUserProfile());
      expect(result, Right(tUser));
      verifyNoMoreInteractions(mockProfileRepository);
    },
  );

  test(
    'should return a ServerFailure when the repository returns a failure',
    () async {
      // arrange
      when(mockProfileRepository.getUserProfile()).thenAnswer((_) async => (Left(ServerFailure())));

      // act
      final result = await useCase(NoParams());

      // assert
      verify(mockProfileRepository.getUserProfile());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(mockProfileRepository);
    },
  );
}
