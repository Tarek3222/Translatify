import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/user_profile/ui/widgets/list_tile_tabs_profile.dart';

class UserInfoAndSettingsTiles extends StatelessWidget {
  const UserInfoAndSettingsTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextWidet(
          title: "Tarek Ahmed",
          fontSize: 24,
        ),
        Text(
          "tarekahmed@gmail.com",
          style: getRegularStyle(
            color: AppColors.grey,
            fontSize: 15,
          ),
        ),
        verticalSpacing(10),
        Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                onPressed: () {},
                text: "Favorites",
                elevation: 0,
              ),
            ),
            horizontalSpacing(10),
            Expanded(
              child: AppElevatedButton(
                onPressed: () {},
                elevation: 0,
                text: "Orders",
              ),
            ),
          ],
        ),
        Divider(
          color: AppColors.grey,
          thickness: 0.4,
          height: 30.h,
          indent: 15.w,
          endIndent: 15.w,
        ),
        ListTileTabsProfile(
          icon: Icons.person,
          title: "Personal Information",
          onTap: () {},
        ),
        ListTileTabsProfile(
          icon: Icons.payment,
          title: "Payments",
          onTap: () {},
        ),
        ListTileTabsProfile(
          icon: Icons.settings,
          title: "Settings",
          onTap: () {},
        ),
        ListTileTabsProfile(
          icon: Icons.logout,
          title: "Logout",
          color: AppColors.mainRed,
          onTap: () {},
        ),
      ],
    );
  }
}
