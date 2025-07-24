import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/features/sign_up/ui/widgets/custom_gender_container.dart';

class SelectedGender extends StatefulWidget {
  const SelectedGender(
      {super.key,
      required this.onSelectMale,
      required this.onSelectFemale,
      this.initialGender});
  final VoidCallback onSelectMale;
  final VoidCallback onSelectFemale;
  final String? initialGender;
  @override
  State<SelectedGender> createState() => _SelectedGenderState();
}

class _SelectedGenderState extends State<SelectedGender> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.initialGender != null) {
      selectedIndex = widget.initialGender == "male".tr() ? 0 : 1;
    }
  }

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
                  widget.onSelectMale();
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
                  widget.onSelectFemale();
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
