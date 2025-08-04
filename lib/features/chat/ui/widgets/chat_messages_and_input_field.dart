import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/chat/ui/widgets/chat_input_field.dart';
import 'package:translators/features/chat/ui/widgets/chat_messages_bloc_builder.dart';

class ChatMessagesAndInputField extends StatelessWidget {
  const ChatMessagesAndInputField({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).w,
      child: Column(
        children: [
          const Expanded(
            child: ChatMessagesBlocBuilder(),
          ),
          ChatInputField(
            receiverInfoModel: receiverInfoModel,
          ),
        ],
      ),
    );
  }
}
