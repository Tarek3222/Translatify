import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/custom_app_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12).w,
      child: Row(
        children: [
          const CustomAppIcon(),
          const Spacer(flex: 1),
          Text(
            title,
            style: getSemiBoldStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
