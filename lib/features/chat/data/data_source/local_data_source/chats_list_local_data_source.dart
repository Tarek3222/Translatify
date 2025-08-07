// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:convert';

import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/chat/data/models/chats_list_response_model.dart';

class ChatsListLocalDataSource {
  Future<void> cacheChats({List<Chats>? chats}) async {
    if (chats != null) {
      await getIt<SharedPrefHelper>().setData(
        SharedPrefKeys.kChatsListForUser,
        json.encode(chats.map((chat) => chat.toJson()).toList()),
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }

  Future<List<Chats>> getChatsList() {
    final String? jsonString = getIt<SharedPrefHelper>().getString(
      SharedPrefKeys.kChatsListForUser,
    )!;

    if (jsonString != null) {
      return Future.value(
        (json.decode(jsonString) as List)
            .map((chatJson) => Chats.fromJson(chatJson as Map<String, dynamic>))
            .toList(),
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
