// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';

class ChangePasswordAppBar extends StatelessWidget {
  const ChangePasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      pinned: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      expandedHeight: 50.h,
      title: const CustomAppBar(title: "Change Password"),
    );
  }
}
