import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/chat/logic/cubit/chats_list_cubit.dart';
import 'package:translators/features/chat/ui/widgets/chats_tab_widget/chats_list_bloc_builder.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class ChatsBodyTab extends StatefulWidget {
  const ChatsBodyTab({super.key});

  @override
  State<ChatsBodyTab> createState() => _ChatsBodyTabState();
}

class _ChatsBodyTabState extends State<ChatsBodyTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    context.read<ChatsListCubit>().getChatsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          child: ChatsListBlocBuilder(),
        ),
      ],
    );
  }
}
