import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: AppTextFormField(
            hintText: 'Type a message...',
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.image,
            color: AppColors.mainBlue,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.send,
            color: AppColors.mainBlue,
          ),
        ),
      ],
    );
  }
}
