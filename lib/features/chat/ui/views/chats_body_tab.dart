import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/chat/ui/widgets/chats_tab_widget/chats_list_view.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class ChatsBodyTab extends StatelessWidget {
  const ChatsBodyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 5).w,
          child: const TitleTextWidet(
            title: "Chats",
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 10),
        const Expanded(
          child: ChatsListView(),
        ),
      ],
    );
  }
}
