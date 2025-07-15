import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/features/on_boarding/ui/views/widgets/change_language_widget.dart';
import 'package:translator/features/on_boarding/ui/views/widgets/theme_switch_widget.dart';
import 'package:translator/features/user_profile/ui/widgets/list_tile_tabs_profile_and_settings.dart';

class SettingsTileTabs extends StatelessWidget {
  const SettingsTileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12).w,
      child: Column(
        children: [
          ListTileTabsProfileAndSettings(
            title: "Change Password",
            icon: Icons.lock_open_outlined,
            onTap: () {},
          ),
          const ListTileTabsProfileAndSettings(
            title: "Language",
            icon: Icons.language_outlined,
            trailing: ChangeLanguageWidget(
              icon: Icon(
                Icons.arrow_forward_ios,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          const ListTileTabsProfileAndSettings(
            title: "Dark Mode",
            icon: Icons.dark_mode_outlined,
            trailing: ThemeSwitchWidget(),
          ),
          ListTileTabsProfileAndSettings(
            title: "FAQ",
            icon: Icons.question_answer_outlined,
            onTap: () {},
          ),
          ListTileTabsProfileAndSettings(
            title: "Support",
            icon: Icons.support_agent_outlined,
            onTap: () {},
          ),
          ListTileTabsProfileAndSettings(
            title: "Logout",
            icon: Icons.logout_outlined,
            onTap: () {},
            color: AppColors.mainRed,
          ),
          ListTileTabsProfileAndSettings(
            title: "Delete Account",
            icon: Icons.delete_outlined,
            onTap: () {},
            color: AppColors.mainRed,
          ),
        ],
      ),
    );
  }
}
