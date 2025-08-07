// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/features/user_profile/ui/widgets/user_info_and_settings_tiles.dart';

class UserInfoAndSettingsContainer extends StatelessWidget {
  const UserInfoAndSettingsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 190.h),
      padding: EdgeInsetsDirectional.only(top: 85.h, start: 20.w, end: 20.w),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      child: const UserInfoAndSettingsTiles(),
    );
  }
}
