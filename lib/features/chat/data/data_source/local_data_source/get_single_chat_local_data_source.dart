// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:convert';

import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';

class GetSingleChatLocalDataSource {
  Future<void> cacheSingleChat(
      {List<Messages>? messages, required String key}) async {
    if (messages != null) {
      await getIt<SharedPrefHelper>().setData(
        key,
        json.encode(messages.map((message) => message.toJson()).toList()),
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }

  Future<List<Messages>> getSingleChat(String key) {
    final String? jsonString = getIt<SharedPrefHelper>().getString(
      key,
    )!;

    if (jsonString != null) {
      return Future.value(
        (json.decode(jsonString) as List)
            .map((messageJson) =>
                Messages.fromJson(messageJson as Map<String, dynamic>))
            .toList(),
      );
    } else {
      throw Exception('No Internet Connection');
    }
  }
}
