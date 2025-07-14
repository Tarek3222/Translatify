import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';

class TranslatorSliverListItem extends StatelessWidget {
  const TranslatorSliverListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(
            width: 110.w,
            height: 110.h,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ1pXeIU3NM8AbIOKZIacRtTRUC3SgtlQQd8XredDWWAu_lfT84bXTE-pjxWndTbqQlB8&usqp=CAU",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpacing(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleTextWidet(title: "Tarek Ahmed"),
                verticalSpacing(5),
                Text(
                  "3.5 ⭐  years ex: 3",
                  style: getRegularStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
                verticalSpacing(5),
                Text(
                  "phone: 01271845331",
                  style: getRegularStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
