import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/features/home/ui/widgets/custom_list_tile.dart';

class TranslatorFilteredItem extends StatelessWidget {
  const TranslatorFilteredItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.translatorProfileScreen);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: 230.w,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12).w,
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const CustomListTitle(
            imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ1pXeIU3NM8AbIOKZIacRtTRUC3SgtlQQd8XredDWWAu_lfT84bXTE-pjxWndTbqQlB8&usqp=CAU",
            title: "Tarek Ahmed",
            subtitle: "3.5 ⭐  years ex: 3"),
      ),
    );
  }
}
