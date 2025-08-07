import 'package:flutter/material.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/chat/data/repo/chats_repo.dart';
import 'package:translators/features/chat/ui/widgets/chat_messages.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class ChatMessagesStreamBuilder extends StatelessWidget {
  const ChatMessagesStreamBuilder({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Messages>>(
      stream: getMessagesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: TitleTextWidet(
                title: "start a conversation",
                textColor: AppColors.mainBlue,
              ),
            );
          } else {
            return ChatMessages(messages: snapshot.data!);
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Stream<List<Messages>> getMessagesStream() async* {
    while (true) {
      final result =
          await getIt<ChatsRepo>().getSingleChat(receiverInfoModel.userId);
      yield result.fold((l) => [], (data) => data);

      await Future.delayed(
        const Duration(microseconds: 500),
      );
    }
  }
}
