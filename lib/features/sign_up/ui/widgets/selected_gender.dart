import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/features/sign_up/ui/widgets/custom_gender_container.dart';

class SelectedGender extends StatefulWidget {
  const SelectedGender({super.key});

  @override
  State<SelectedGender> createState() => _SelectedGenderState();
}

class _SelectedGenderState extends State<SelectedGender> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.mainBlue,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomGenderContainer(
              gender: "male".tr(),
              isSelected: selectedIndex == 0,
              onTap: () {
                if (selectedIndex != 0) {
                  // context.read<SignupCubit>().gender = "male";
                  setState(() {
                    selectedIndex = 0;
                  });
                }
              },
            ),
          ),
          Expanded(
            child: CustomGenderContainer(
              gender: "female".tr(),
              isSelected: selectedIndex == 1,
              onTap: () {
                if (selectedIndex != 1) {
                  // context.read<SignupCubit>().gender = "female";
                  setState(() {
                    selectedIndex = 1;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
