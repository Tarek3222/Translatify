import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translators/core/theme/app_colors.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem(
      {super.key, required this.isSelected, required this.imagePath});
  final bool isSelected;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 103.w,
      height: 62.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1.5,
          color: isSelected ? AppColors.mainBlue : Colors.black54,
        ),
        boxShadow: isSelected
            ? [
                const BoxShadow(
                  color: AppColors.mainBlue,
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 0),
                )
              ]
            : [],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: SvgPicture.asset(imagePath),
        ),
      ),
    );
  }
}
