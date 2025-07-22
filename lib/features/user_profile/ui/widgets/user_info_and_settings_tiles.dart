import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/settings/ui/widgets/sign_out_tile_and_bloc_listener.dart';
import 'package:translator/features/user_profile/data/models/user_profile_model.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:translator/features/user_profile/ui/widgets/list_tile_tabs_profile_and_settings.dart';
import 'package:translator/features/user_profile/ui/widgets/user_name_and_email_text_bloc_builder.dart';

class UserInfoAndSettingsTiles extends StatelessWidget {
  const UserInfoAndSettingsTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserNameAndEmailTextBlocBuilder(),
        verticalSpacing(10),
        Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.translatorsFavoritesView);
                },
                text: "Favorites",
                elevation: 0,
              ),
            ),
            horizontalSpacing(10),
            Expanded(
              child: AppElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.orderTranslatorsView);
                },
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
        ListTileTabsProfileAndSettings(
          icon: Icons.person,
          title: "Personal Information",
          onTap: () {
            context.pushNamed(
              Routes.personalInformationView,
              arguments: {
                "userProfileModel": getUserProfileModel(),
                'userProfileCubit': context.read<UserProfileCubit>(),
              },
            );
          },
        ),
        ListTileTabsProfileAndSettings(
          icon: Icons.payment,
          title: "Payments",
          onTap: () {},
        ),
        ListTileTabsProfileAndSettings(
          icon: Icons.settings,
          title: "Settings",
          onTap: () {
            context.pushNamed(Routes.settingsScreen);
          },
        ),
        const SignOutTileAndBlocListener(),
      ],
    );
  }

  UserProfileModel getUserProfileModel() {
    return UserProfileModel.fromJson(
      jsonDecode(
        getIt<SharedPrefHelper>().getString(
          SharedPrefKeys.kUserProfileKey,
        )!,
      ),
    );
  }
}
