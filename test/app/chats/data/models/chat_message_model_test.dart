import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/chats/data/models/chat_message_model.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tChatMessageModel = ChatMessageModel(
    id: 'test id',
    msg: 'test msg',
    uid: 'test uid',
    timestamp: DateTime(2000),
  );

  test(
    'should be a subclass of ChatMessage entity',
    () async {
      // assert
      expect(tChatMessageModel, isA<ChatMessage>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON data is parsed',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('chat_message.json'));

        // act
        final result = ChatMessageModel.fromJson(jsonMap);

        // assert
        expect(result, tChatMessageModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tChatMessageModel.toJson();

        // assert
        final expectedMap = {
          "id": "test id",
          "msg": "test msg",
          "uid": "test uid",
          "timestamp": "2000-01-01T00:00:00.000"
        };
        expect(result, expectedMap);
      },
    );
  });
}
