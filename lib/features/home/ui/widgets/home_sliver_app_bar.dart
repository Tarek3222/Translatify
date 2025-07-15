// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:translator/features/home/ui/widgets/custom_list_tile.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      pinned: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      expandedHeight: 50.h,
      title: buildSliverAppBarTitle(),
      actions: [
        FaIcon(
          FontAwesomeIcons.magnifyingGlass,
          color: Theme.of(context).colorScheme.secondary,
          size: 20.sp,
        ),
      ],
    );
  }

  Widget buildSliverAppBarTitle() {
    return const CustomListTitle(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ1pXeIU3NM8AbIOKZIacRtTRUC3SgtlQQd8XredDWWAu_lfT84bXTE-pjxWndTbqQlB8&usqp=CAU",
        title: "Hello, Tarek",
        subtitle: "How are you today?");
  }
}
