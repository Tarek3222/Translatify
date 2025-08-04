import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/utils/current_user_data.dart';
import 'package:translators/core/utils/time_formated.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });
  final Messages message;
  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = getIdCurruntUser() == message.senderId!.id!;
    var colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: isCurrentUser
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            topStart: isCurrentUser ? const Radius.circular(20) : Radius.zero,
            bottomEnd: const Radius.circular(20),
            bottomStart: const Radius.circular(20),
            topEnd: isCurrentUser ? Radius.zero : const Radius.circular(20),
          ),
          color: isCurrentUser ? AppColors.mainBlue : colorScheme.secondary,
        ),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.body!,
              style: getMediumStyle(
                fontSize: 16,
                // ignore: deprecated_member_use
                color: isCurrentUser ? AppColors.white : colorScheme.background,
              ),
            ),
            Text(
              getChatTimeFormatted(context: context, time: message.createdAt!),
              style: getMediumStyle(
                fontSize: 14,
                color: AppColors.lightGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
