// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_user_avatar.dart';
import 'package:translators/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';

class ImageUserBlocBuilder extends StatelessWidget {
  const ImageUserBlocBuilder({super.key, this.radius = 15});
  final double radius;
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
            return setupSuccessState(state, radius);
          case UserProfileError:
            return const Icon(
              Icons.error,
              color: Colors.red,
            );
          default:
            return setupLoadingState();
        }
      },
    );
  }

  Widget setupSuccessState(UserProfileState state, double radius) {
    return AppUserAvatar(
      imageUrl: (state as UserProfileSuccess)
          .userProfileModel
          .user
          ?.profilePic
          ?.secureUrl,
      name: state.userProfileModel.user?.name ?? "unknown",
      fontSize: radius / 2.3,
      radius: radius,
    );
  }

  Widget setupLoadingState() {
    return AppLoadingIndecator(
      size: 15.w,
    );
  }
}
