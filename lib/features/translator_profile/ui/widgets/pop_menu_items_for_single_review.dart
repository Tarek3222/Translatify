// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translator/features/translator_profile/ui/widgets/delete_review_alert_dialog.dart';
import 'package:translator/features/translator_profile/ui/widgets/edit_review_bottom_sheet_and_bloc_listener.dart';

class PopMenuItemsForSingleReview extends StatelessWidget {
  const PopMenuItemsForSingleReview({super.key, required this.reviewModel});
  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.background,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: 'edit',
              child: Text(
                'Edit',
                style: getRegularStyle(
                  fontSize: 14.sp,
                  color: AppColors.grey,
                ),
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text(
                'Delete',
                style: getRegularStyle(
                  fontSize: 14.sp,
                  color: AppColors.mainRed,
                ),
              ),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 'delete') {
            dialogForDeleteReview(
              context,
              reviewModel: reviewModel,
            );
          } else if (value == 'edit') {
            showModelBottomSheetForUpdateReview(
              context,
              reviewModel: reviewModel,
            );
          }
        },
      ),
    );
  }
}
