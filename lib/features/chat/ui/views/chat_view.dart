import 'package:flutter/material.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/chat/ui/widgets/chat_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChatBody(
          receiverInfoModel: receiverInfoModel,
        ),
      ),
    );
  }
}
