// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translators/features/translator_profile/logic/update_review_cubit/update_review_cubit.dart';

class EditReviewWidgetsAndBlocConsumer extends StatefulWidget {
  const EditReviewWidgetsAndBlocConsumer(
      {super.key, required this.reviewModel});
  final ReviewModel reviewModel;

  @override
  State<EditReviewWidgetsAndBlocConsumer> createState() =>
      _EditReviewWidgetsAndBlocConsumerState();
}

class _EditReviewWidgetsAndBlocConsumerState
    extends State<EditReviewWidgetsAndBlocConsumer> {
  @override
  void initState() {
    context.read<UpdateReviewCubit>().rating =
        widget.reviewModel.rating!.toDouble();
    context.read<UpdateReviewCubit>().commentController.text =
        widget.reviewModel.comment ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateReviewCubit, UpdateReviewState>(
      listenWhen: (previous, current) =>
          current is UpdateReviewSuccess || current is UpdateReviewError,
      listener: (context, state) {
        switch (state.runtimeType) {
          case UpdateReviewSuccess:
            showSnackBar(
                context: context,
                message: "Review updateed successfully.",
                backgroundColor: AppColors.mainBlue);
            context.pop();
            break;
          case UpdateReviewError:
            showCustomDialog(
              context,
              "Error",
              (state as UpdateReviewError).errorModel.getAllMessages(),
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).w,
            child: Column(
              children: [
                // tab
                Container(
                  width: 40.w,
                  height: 5.h,
                  padding: const EdgeInsets.all(10).w,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                ),
                verticalSpacing(20),
                // Rating stars
                IgnorePointer(
                  ignoring: state is UpdateReviewLoading,
                  child: buildRatingBar(context),
                ),
                verticalSpacing(20),
                // Comment field
                AppTextFormField(
                  hintText: "Add your comment...",
                  controller:
                      context.read<UpdateReviewCubit>().commentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  enabled: state is! UpdateReviewLoading,
                ),
                verticalSpacing(20),
                // Add Review button
                state is UpdateReviewLoading
                    ? const AppLoadingIndecator()
                    : AppElevatedButton(
                        onPressed: () async {
                          if (context.read<UpdateReviewCubit>().rating > 0) {
                            await context
                                .read<UpdateReviewCubit>()
                                .updateReview(
                                  reviewID: widget.reviewModel.id!,
                                );
                          } else {
                            // show a dialog if the rating is not selected
                            showCustomDialog(context, "Rating Required",
                                "Please select a rating before submitting your review.");
                          }
                        },
                        text: "Submit",
                        elevation: 0,
                        width: MediaQuery.sizeOf(context).width * 0.5,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: TitleTextWidet(title: title, textColor: Colors.red),
          content: Text(
            message,
            style: getMediumStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                "OK",
                style:
                    getSemiBoldStyle(fontSize: 16, color: AppColors.mainBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  RatingBar buildRatingBar(BuildContext context) {
    return RatingBar.builder(
      initialRating: context.read<UpdateReviewCubit>().rating,
      direction: Axis.horizontal,
      itemCount: 5,
      allowHalfRating: true,
      itemSize: 40.sp,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        context.read<UpdateReviewCubit>().rating = rating;
      },
    );
  }
}
