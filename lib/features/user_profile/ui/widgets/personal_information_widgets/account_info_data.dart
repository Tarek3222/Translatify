import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/sign_up/ui/widgets/label_form.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';

class AccountInfoData extends StatelessWidget {
  const AccountInfoData({super.key, this.userProfileModel});
  final UserProfileModel? userProfileModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LabelForm(labelText: "Your Age"),
        Text(
          userProfileModel!.user!.age.toString(),
          style: getRegularStyle(
            color: AppColors.grey,
            fontSize: 15,
          ),
        ),
        verticalSpacing(15),
        const LabelForm(labelText: "Account Created At"),
        Text(
          DateFormat('dd MMM yyyy, hh:mm a').format(
              DateTime.parse(userProfileModel!.user!.createdAt!).toLocal()),
          style: getRegularStyle(
            color: AppColors.grey,
            fontSize: 15,
          ),
        ),
        verticalSpacing(15),
        const LabelForm(labelText: "Last Updated At"),
        Text(
          DateFormat('dd MMM yyyy, hh:mm a').format(
              DateTime.parse(userProfileModel!.user!.updatedAt!).toLocal()),
          style: getRegularStyle(
            color: AppColors.grey,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
