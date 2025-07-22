// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/widgets/app_text_shimmer_loading.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';

class WelcomeTextBlocBuilder extends StatelessWidget {
  const WelcomeTextBlocBuilder({super.key});

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
            return setupSuccessStata(state);
          case UserProfileError:
            return setupErrorState();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  TitleTextWidet setupErrorState() {
    return const TitleTextWidet(
      title: "Hello, Unknown!",
      textColor: AppColors.mainRed,
    );
  }

  TitleTextWidet setupSuccessStata(UserProfileState state) {
    return TitleTextWidet(
        title:
            "Hello, ${(state as UserProfileSuccess).userProfileModel.user?.name?.split(" ").first ?? ""}!");
  }

  Widget setupLoadingState() {
    return const AppTextShimmerLoading(
      height: 18,
      width: 130,
    );
  }
}
