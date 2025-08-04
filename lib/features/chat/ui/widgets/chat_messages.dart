import 'package:flutter/material.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';
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
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatBubble(
          message: messages[index],
        );
      },
    );
  }
}
