import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/chat/ui/widgets/chats_tab_widget/custom_chat_list_tile.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.symmetric(horizontal: 12).w,
      itemBuilder: (context, index) {
        return const CustomChatListTile();
      },
    );
  }
}
