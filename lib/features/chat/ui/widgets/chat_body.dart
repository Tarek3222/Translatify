import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/chat/data/repo/chats_repo.dart';
import 'package:translators/features/chat/logic/chat_cubit/chat_cubit.dart';
import 'package:translators/features/chat/ui/widgets/chat_messages_and_input_field.dart';
import 'package:translators/features/chat/ui/widgets/custom_chat_app_bar.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomChatAppBar(
          receiverInfoModel: receiverInfoModel,
        ),
        BlocProvider(
          create: (context) => ChatCubit(getIt<ChatsRepo>()),
          child: Expanded(
            child: ChatMessagesAndInputField(
              receiverInfoModel: receiverInfoModel,
            ),
          ),
        ),
      ],
    );
  }
}
