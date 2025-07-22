// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_text_shimmer_loading.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';

class UserNameAndEmailTextBlocBuilder extends StatelessWidget {
  const UserNameAndEmailTextBlocBuilder({super.key});

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
            return setupSuccessState(state);
          case UserProfileError:
            return setupErrorState(state);
          default:
            return setupLoadingState();
        }
      },
    );
  }

  Widget setupLoadingState() {
    return Column(
      children: [
        AppTextShimmerLoading(
          height: 30.h,
          width: 100.w,
        ),
        AppTextShimmerLoading(
          height: 20.h,
          width: 200.w,
        ),
      ],
    );
  }

  Widget setupErrorState(state) {
    return TitleTextWidet(
      title: (state as UserProfileError).errorModel.getAllMessages(),
      textColor: AppColors.mainRed,
    );
  }

  Widget setupSuccessState(state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidet(
          title: (state as UserProfileSuccess).userProfileModel.user?.name ??
              "unknown",
          fontSize: 24,
        ),
        Text(
          state.userProfileModel.user?.email ?? "",
          style: getRegularStyle(
            color: AppColors.grey,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
