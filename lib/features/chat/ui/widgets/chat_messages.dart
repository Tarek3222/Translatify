import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';
import 'package:translators/features/chat/logic/chat_cubit/chat_cubit.dart';
import 'package:translators/features/chat/ui/widgets/chat_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    required this.messages,
  });
  final List<Messages> messages;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: context.read<ChatCubit>().scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatBubble(
          message: messages[index],
        );
      },
    );
  }
}
