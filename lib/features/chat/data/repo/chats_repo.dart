import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:translators/core/networking/api_error_handler.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/networking/api_service.dart';
import 'package:translators/core/networking/network_info.dart';
import 'package:translators/features/chat/data/data_source/local_data_source/chats_list_local_data_source.dart';
import 'package:translators/features/chat/data/data_source/local_data_source/get_single_chat_local_data_source.dart';
import 'package:translators/features/chat/data/models/chats_list_response_model.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';

class ChatsRepo {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;
  final GetSingleChatLocalDataSource _chatLocalDataSource;
  final ChatsListLocalDataSource _chatsListLocalDataSource;
  ChatsRepo(this._apiService, this._networkInfo, this._chatLocalDataSource,
      this._chatsListLocalDataSource);

  Future<Either<ApiErrorModel, List<Messages>>> getSingleChat(
      String receiverId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _apiService.getSignleChat(receiverId);
        final messageResponseModel =
            MessageResponseModel.fromJson(jsonDecode(response));
        // Cache the translators list locally
        await _chatLocalDataSource.cacheSingleChat(
            messages: messageResponseModel.chat?.messages, key: receiverId);
        return Right(messageResponseModel.chat?.messages ?? []);
      } catch (e) {
        return Left(ApiErrorHandler.handle(e));
      }
    } else {
      try {
        final localData = await _chatLocalDataSource.getSingleChat(receiverId);
        return Right(localData);
      } catch (e) {
        return Left(
          ApiErrorModel(message: e.toString()),
        );
      }
    }
  }

  Future<Either<ApiErrorModel, String>> sendMessage(
      {required String message, required String receiverId}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _apiService.sendMessage(receiverId, {"body": message});
        return Right(response);
      } catch (e) {
        return Left(ApiErrorHandler.handle(e));
      }
    } else {
      return const Left(
        ApiErrorModel(message: 'No Internet Connection'),
      );
    }
  }

  Future<Either<ApiErrorModel, List<Chats>>> getChatsList() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _apiService.getListChats();
        final chatsListResponseModel =
            ChatsListResponseModel.fromJson(jsonDecode(response));
        // Cache the translators list locally
        await _chatsListLocalDataSource.cacheChats(
            chats: chatsListResponseModel.chats);
        return Right(chatsListResponseModel.chats ?? []);
      } catch (e) {
        return Left(ApiErrorHandler.handle(e));
      }
    } else {
      try {
        final localData = await _chatsListLocalDataSource.getChatsList();
        return Right(localData);
      } catch (e) {
        return Left(
          ApiErrorModel(message: e.toString()),
        );
      }
    }
  }

  Future<Either<ApiErrorModel, String>> deleteChat(
      {required String receiverId}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _apiService.deleteChat(receiverId);
        return Right(response);
      } catch (e) {
        return Left(ApiErrorHandler.handle(e));
      }
    } else {
      return const Left(
        ApiErrorModel(message: 'No Internet Connection'),
      );
    }
  }
}
