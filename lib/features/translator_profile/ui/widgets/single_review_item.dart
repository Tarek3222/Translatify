import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/expanable_text.dart';

class SingleReviewItem extends StatelessWidget {
  const SingleReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            "https://res.cloudinary.com/dns6iddx7/image/upload/v1747299261/Graduation_Project/Users/et8v/Profile/kr8hf8hpelgdmrxywz60.jpg",
          ),
        ),
        horizontalSpacing(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Jane Cooper",
                    style: getSemiBoldStyle(
                      fontSize: 16,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Today",
                    style: getRegularStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              verticalSpacing(8),
              buildRatingBar(),
              verticalSpacing(10),
              const ExpandableText(
                text:
                    "As someone who lives in a remote area with limited access to healthcare, this telemedicine app has been a game changer for me.",
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
      initialRating: 5,
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: 24,
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
