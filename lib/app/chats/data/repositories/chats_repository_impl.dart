import 'package:flutter/cupertino.dart';
import 'package:maser/app/chats/data/datasources/chats_remote_datasource.dart';
import 'package:maser/app/chats/domain/entities/chat_group.dart';
import 'package:dartz/dartz.dart';
import 'package:maser/app/chats/domain/entities/chat_message.dart';
import 'package:maser/app/chats/domain/repositories/chats_repository.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/error/failures.dart';
import 'package:maser/core/models/user.dart';
import 'package:maser/core/services/network/network_info.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  ChatsRepositoryImpl({
    @required this.remoteDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ChatGroup>>> getChatGroups() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.getChatGroups());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatGroup(String chatGroupId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.deleteChatGroup(chatGroupId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> createChatGroup(String mentorId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.createChatGroup(mentorId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendChatMessage(
      String chatGroupId, ChatMessage message) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.sendChatMessage(
          chatGroupId,
          message,
        ));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ChatGroup>> getChatGroup(String chatGroupId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.getChatGroup(chatGroupId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserDetails(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDatasource.getUserDetails(userId));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
