import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';
import 'package:translators/features/user_profile/logic/delete_user_cover_image_cubit/delete_user_cover_image_cubit.dart';
import 'package:translators/features/user_profile/logic/upload_user_cover_image_cubit/upload_user_cover_image_cubit.dart';
import 'package:translators/features/user_profile/ui/widgets/custom_camera_icon.dart';
import 'package:translators/features/user_profile/ui/widgets/delete_cover_image_bloc_listener.dart';
import 'package:translators/features/user_profile/ui/widgets/show_image_options_bottom_sheet.dart';
import 'package:translators/features/user_profile/ui/widgets/upload_cover_image_bloc_listener.dart';

class IconCoverImageBlocListener extends StatelessWidget {
  const IconCoverImageBlocListener({super.key});

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
                  ?.coverPic
                  ?.secureUrl,
              onUploadImage: (file) async {
                await context
                    .read<UploadUserCoverImageCubit>()
                    .uploadUserCoverImage(file: file);
              },
              onDeleteImage: () async {
                await context
                    .read<DeleteUserCoverImageCubit>()
                    .deleteUserCoverImage();
              },
            );
          },
        ),
        const SizedBox(
            width: 1, height: 1, child: DeleteCoverImageBlocListener()),
        const SizedBox(
            width: 1, height: 1, child: UploadCoverImageBlocListener()),
      ],
    );
  }
}
