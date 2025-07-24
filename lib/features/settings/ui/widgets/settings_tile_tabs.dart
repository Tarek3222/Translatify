import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/features/on_boarding/ui/views/widgets/change_language_widget.dart';
import 'package:translators/features/on_boarding/ui/views/widgets/theme_switch_widget.dart';
import 'package:translators/features/settings/ui/widgets/delete_account_tile_and_bloc_listener.dart';
import 'package:translators/features/settings/ui/widgets/sign_out_tile_and_bloc_listener.dart';
import 'package:translators/features/user_profile/ui/widgets/list_tile_tabs_profile_and_settings.dart';

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
            onTap: () {
              context.pushNamed(Routes.changePasswordView);
            },
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
            onTap: () {
              context.pushNamed(Routes.faqVeiw);
            },
          ),
          ListTileTabsProfileAndSettings(
            title: "Support",
            icon: Icons.support_agent_outlined,
            onTap: () {
              context.pushNamed(Routes.supportView);
            },
          ),
          const SignOutTileAndBlocListener(),
          const DeleteAccountTileAndBlocListener(),
        ],
      ),
    );
  }
}
