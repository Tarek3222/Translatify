import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/features/user_profile/data/models/user_profile_model.dart';
import 'package:translator/features/user_profile/logic/delete_user_profile_image_cubit/delete_user_profile_image_cubit.dart';
import 'package:translator/features/user_profile/logic/upload_user_profile_image_cubit/upload_user_profile_image_cubit.dart';
import 'package:translator/features/user_profile/ui/widgets/custom_camera_icon.dart';
import 'package:translator/features/user_profile/ui/widgets/delete_profile_image_bloc_listener.dart';
import 'package:translator/features/user_profile/ui/widgets/show_image_options_bottom_sheet.dart';
import 'package:translator/features/user_profile/ui/widgets/upload_profile_image_bloc_listener.dart';

class IconProfileImageBlocListener extends StatelessWidget {
  const IconProfileImageBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCameraIcon(
          onTap: () {
            showImageOptionsBottomSheet(
              context: context,
              imageUrl: UserProfileModel.fromJson(jsonDecode(
                      getIt<SharedPrefHelper>()
                              .getString(SharedPrefKeys.kUserProfileKey) ??
                          ''))
                  .user
                  ?.profilePic
                  ?.secureUrl,
              onUploadImage: (file) async {
                await context
                    .read<UploadUserProfileImageCubit>()
                    .uploadUserProfileImage(file: file);
              },
              onDeleteImage: () async {
                await context
                    .read<DeleteUserProfileImageCubit>()
                    .deleteUserProfileImage();
              },
            );
          },
        ),
        const SizedBox(
            width: 1, height: 1, child: DeleteProfileImageBlocListener()),
        const SizedBox(
            width: 1, height: 1, child: UploadProfileImageBlocListener()),
      ],
    );
  }
}
