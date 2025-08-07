// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/chat/logic/chat_cubit/chat_cubit.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class SendButtonBlocConsumer extends StatelessWidget {
  const SendButtonBlocConsumer({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;
  @override
  Widget build(BuildContext context) {
    var chatCubit = context.read<ChatCubit>();
    return BlocConsumer<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          current is SendMessageLoading ||
          current is SendMessageError ||
          current is SendMessageSuccess,
      listener: (context, state) {
        switch (state.runtimeType) {
          case SendMessageError:
            showCustomDialog(
              context,
              "Error",
              (state as SendMessageError).errorModel.getAllMessages(),
            );
            break;
        }
      },
      builder: (context, state) {
        return IconButton(
          onPressed: () async {
            if (chatCubit.messageController.text.isNotEmpty) {
              await chatCubit.sendMessage(receiverId: receiverInfoModel.userId);
              scrollToLastMessage(chatCubit);
            }
          },
          icon: state is SendMessageLoading
              ? const CircularProgressIndicator()
              : const Icon(
                  Icons.send,
                  color: AppColors.mainBlue,
                ),
        );
      },
    );
  }

  void showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: TitleTextWidet(title: title, textColor: Colors.red),
          content: Text(
            message,
            style: getMediumStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                "OK",
                style:
                    getSemiBoldStyle(fontSize: 16, color: AppColors.mainBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  // scroll to last message
  void scrollToLastMessage(ChatCubit chatCubit) {
    if (chatCubit.scrollController.hasClients) {
      chatCubit.scrollController.animateTo(
        chatCubit.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
