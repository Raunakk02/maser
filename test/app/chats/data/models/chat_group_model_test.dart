import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:maser/app/chats/data/models/chat_group_model.dart';
import 'package:maser/app/chats/data/models/chat_message_model.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tChatGroupModel = ChatGroupModel(
    id: 'test id',
    mentorId: 'test mentorId',
    messages: [
      ChatMessageModel(
        id: 'test id',
        msg: 'test msg',
        uid: 'test uid',
        timestamp: DateTime(2000),
      ),
      ChatMessageModel(
        id: 'test id',
        msg: 'test msg',
        uid: 'test uid',
        timestamp: DateTime(2000),
      ),
    ],
  );

  test(
    'should be a subclass of ChatGroup entity',
    () async {
      // assert
      expect(tChatGroupModel, isA<ChatGroup>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON data is parsed',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('chat_group.json'));

        // act
        final result = ChatGroupModel.fromJson(jsonMap);

        // assert
        expect(result, tChatGroupModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tChatGroupModel.toJson();

        // assert
        final expectedMap = {
          "id": "test id",
          "mentorId": "test mentorId",
          "messages": [
            {
              "id": "test id",
              "msg": "test msg",
              "uid": "test uid",
              "timestamp": "2000-01-01T00:00:00.000"
            },
            {
              "id": "test id",
              "msg": "test msg",
              "uid": "test uid",
              "timestamp": "2000-01-01T00:00:00.000"
            }
          ]
        };
        expect(result, expectedMap);
      },
    );
  });
}
