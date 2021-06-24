import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:maser/core/models/user.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tUserModel = UserModel(
    id: 'test id',
    name: 'test name',
    email: 'test email',
    phone: '1234567890',
    imageUrl: 'test url',
  );

  test(
    'should be a subclass of User entity',
    () async {
      // assert
      expect(tUserModel, isA<User>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON data is parsed',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));

        // act
        final result = UserModel.fromJson(jsonMap);

        // assert
        expect(result, tUserModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tUserModel.toJson();

        // assert
        final expectedMap = {
          "id": "test id",
          "name": "test name",
          "email": "test email",
          "phone": "1234567890",
          "imageUrl": "test url"
        };
        expect(result, expectedMap);
      },
    );
  });
}
