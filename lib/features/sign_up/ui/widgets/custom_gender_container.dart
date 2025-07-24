import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

class CustomGenderContainer extends StatelessWidget {
  const CustomGenderContainer(
      {super.key,
      required this.isSelected,
      required this.gender,
      required this.onTap});
  final bool isSelected;
  final String gender;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainBlue : AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          gender,
          style: getMediumStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : AppColors.mainDarkBlue,
          ),
        ),
      ),
    );
  }
}
