import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/widgets/custom_app_bar.dart';
import 'package:translator/features/user_profile/data/models/user_profile_model.dart';
import 'package:translator/features/user_profile/logic/update_personal_information_cubit/update_personal_information_cubit.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:translator/features/user_profile/ui/widgets/personal_information_widgets/user_info_data_form.dart';

class PersonalInformationBody extends StatelessWidget {
  const PersonalInformationBody(
      {super.key,
      required this.userProfileModel,
      required this.userProfileCubit});
  final UserProfileModel? userProfileModel;
  final UserProfileCubit userProfileCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: userProfileModel!.user!.name!,
          onBackPress: () {
            context.pop();
            if (context.read<UpdatePersonalInformationCubit>().isChannged) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                userProfileCubit.getUserProfile(forceRefresh: true);
              });
            }
          },
        ),
        verticalSpacing(10),
        Expanded(
          child: UserInfoDataForm(
            userProfileModel: userProfileModel,
          ),
        ),
      ],
    );
  }
}
