import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/chat/data/models/chats_list_response_model.dart';
import 'package:translators/features/chat/ui/widgets/chats_tab_widget/custom_chat_list_tile.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key, required this.chats});
  final List<Chats> chats;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: chats.length,
      padding: const EdgeInsets.symmetric(horizontal: 12).w,
      itemBuilder: (context, index) {
        return CustomChatListTile(
          chat: chats[index],
        );
      },
    );
  }
}
