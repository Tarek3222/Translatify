import 'package:flutter/material.dart';
import 'package:translator/features/user_profile/ui/widgets/user_cover_image.dart';
import 'package:translator/features/user_profile/ui/widgets/user_info_and_settings_container.dart';
import 'package:translator/features/user_profile/ui/widgets/user_profile_image.dart';

class UserProfileTabBody extends StatelessWidget {
  const UserProfileTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        UserCoverImage(),
        UserInfoAndSettingsContainer(),
        UserProfileImage(),
      ],
    );
  }
}
