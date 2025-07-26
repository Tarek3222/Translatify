// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/utils/time_formated.dart';
import 'package:translators/core/widgets/app_user_avatar.dart';
import 'package:translators/core/widgets/expanable_text.dart';
import 'package:translators/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translators/features/translator_profile/ui/widgets/pop_menu_items_for_single_review.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';

class SingleReviewItem extends StatelessWidget {
  const SingleReviewItem({super.key, required this.reviewModel});
  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    final String jsonString = getIt<SharedPrefHelper>().getString(
      SharedPrefKeys.kUserProfileKey,
    )!;
    UserProfileModel curruentUser = UserProfileModel.fromJson(
      json.decode(jsonString),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        curruentUser.user!.id! == reviewModel.reviewerId!.id!
            ? AppUserAvatar(
                imageUrl: curruentUser.user!.profilePic?.secureUrl,
                radius: 30,
                name: curruentUser.user!.name ?? 'Unknown User',
                fontSize: 14.sp,
              )
            : const SizedBox(),
        horizontalSpacing(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    reviewModel.reviewerId!.name ?? 'Unknown User',
                    style: getSemiBoldStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    getTimeFormated(
                      context: context,
                      time: reviewModel.updatedAt!,
                    ),
                    style: getRegularStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey,
                    ),
                  ),
                  horizontalSpacing(5),
                  if (curruentUser.user!.id! == reviewModel.reviewerId!.id!)
                    PopMenuItemsForSingleReview(
                      reviewModel: reviewModel,
                    ),
                ],
              ),
              verticalSpacing(8),
              buildRatingBar(),
              verticalSpacing(10),
              ExpandableText(
                text: reviewModel.comment ?? 'No review provided',
                fontSize: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRatingBar() {
    return RatingBar.builder(
      initialRating: reviewModel.rating!.toDouble(),
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: 24,
      allowHalfRating: true,
      ignoreGestures: true,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        // Handle rating update if needed
      },
    );
  }
}
