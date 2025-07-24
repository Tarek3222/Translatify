// ignore_for_file: type_literal_in_constant_pattern

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/widgets/app_cached_network_image.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';
import 'package:translators/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:translators/features/user_profile/ui/widgets/show_image_options_bottom_sheet.dart';

class CoverImageBackgroundBlocBuilder extends StatelessWidget {
  const CoverImageBackgroundBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      buildWhen: (previous, current) =>
          current is UserProfileSuccess ||
          current is UserProfileError ||
          current is UserProfileLoading,
      builder: (context, state) {
        switch (state.runtimeType) {
          case UserProfileLoading:
            return setupLoadingState();
          case UserProfileSuccess:
            return setupSuccessState(state, context);
          case UserProfileError:
            return setupErrorState(state);
          default:
            return setupLoadingState();
        }
      },
    );
  }

  Widget setupLoadingState() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey,
      highlightColor: Colors.white,
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.lightGrey,
        ),
      ),
    );
  }

  Widget setupErrorState(state) {
    return Container(
      height: 200.h,
      width: double.infinity,
      color: AppColors.lightGrey,
      child: Center(
        child: TitleTextWidet(
          title: (state as UserProfileError).errorModel.getAllMessages(),
          textColor: AppColors.mainRed,
        ),
      ),
    );
  }

  Widget setupSuccessState(state, BuildContext context) {
    return (state as UserProfileSuccess).userProfileModel.user?.coverPic == null
        ? InkWell(
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
                  // Implement image picker logic here
                },
                onDeleteImage: () async {
                  // Implement delete API logic here
                },
              );
            },
            child: Container(
              height: 200.h,
              width: double.infinity,
              color: AppColors.lightGrey,
            ),
          )
        : AppCachedNetworkImage(
            imageUrl: state.userProfileModel.user?.coverPic?.secureUrl ?? "",
            width: double.infinity,
            height: 200.h,
          );
  }
}
