// ignore_for_file: type_literal_in_constant_pattern

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_text_shimmer_loading.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';

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
    return TitleTextWidet(
      title: "Hello, Unknown!".tr(),
      textColor: AppColors.mainRed,
    );
  }

  TitleTextWidet setupSuccessStata(UserProfileState state) {
    return TitleTextWidet(
        title:
            "${tr("Hello,")} ${(state as UserProfileSuccess).userProfileModel.user?.name?.split(" ").first ?? ""}!");
  }

  Widget setupLoadingState() {
    return const AppTextShimmerLoading(
      height: 18,
      width: 130,
    );
  }
}
