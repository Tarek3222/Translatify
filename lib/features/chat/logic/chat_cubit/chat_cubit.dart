import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';
import 'package:translators/features/chat/data/repo/chats_repo.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatsRepo _chatsRepo;
  ChatCubit(this._chatsRepo) : super(ChatInitial());
  List<Messages> messages = [];
  TextEditingController messageController = TextEditingController();

  Future<void> getSingleChat(
      {bool isFromSendMessage = false, required String receiverId}) async {
    if (isFromSendMessage) {
      emit(ChatLoadingAfterSendMessage(
        messages: messages,
      ));
    } else {
      emit(ChatLoading());
    }
    final result = await _chatsRepo.getSingleChat(
      receiverId,
    );
    result.fold(
      (failure) {
        if (isFromSendMessage) {
          ChatErrorAfterSendMessage(messages: messages);
        } else {
          emit(
            ChatError(errorModel: failure),
          );
        }
      },
      (messages) {
        this.messages = messages;
        emit(
          ChatSuccess(
            messages: messages,
          ),
        );
      },
    );
  }

  Future<void> sendMessage({required String receiverId}) async {
    emit(SendMessageLoading());
    final result = await _chatsRepo.sendMessage(
      receiverId: receiverId,
      message: messageController.text.trim(),
    );
    result.fold(
        (failure) => emit(
              SendMessageError(errorModel: failure),
            ), (success) {
      messageController.clear();
      getSingleChat(isFromSendMessage: true, receiverId: receiverId);
    });
  }
}
