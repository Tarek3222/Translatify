import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/chat/logic/chat_cubit/chat_cubit.dart';
import 'package:translators/features/chat/ui/widgets/send_button_bloc_consumer.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextFormField(
            hintText: 'Type a message...',
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: context.read<ChatCubit>().messageController,
          ),
        ),
        SendButtonBlocConsumer(receiverInfoModel: receiverInfoModel),
      ],
    );
  }
}
