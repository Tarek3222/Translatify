// ignore_for_file: deprecated_member_use, type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translators/features/translator_profile/data/repos/reviews_repo.dart';
import 'package:translators/features/translator_profile/logic/delete_review_cubit/delete_review_cubit.dart';

dialogForDeleteReview(
  BuildContext context, {
  required ReviewModel reviewModel,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return BlocProvider(
        create: (context) => DeleteReviewCubit(getIt<ReviewsRepo>()),
        child: DeleteReviewAlertDialog(reviewModel: reviewModel),
      );
    },
  );
}

class DeleteReviewAlertDialog extends StatelessWidget {
  const DeleteReviewAlertDialog({super.key, required this.reviewModel});
  final ReviewModel reviewModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteReviewCubit, DeleteReviewState>(
      listenWhen: (previous, current) =>
          current is DeleteReviewSuccess || current is DeleteReviewError,
      listener: (context, state) {
        switch (state.runtimeType) {
          case DeleteReviewSuccess:
            showSnackBar(
                context: context,
                message: "Review Deleteed successfully.",
                backgroundColor: AppColors.mainBlue);
            context.pop();
            break;
          case DeleteReviewError:
            showSnackBar(
              context: context,
              message: (state as DeleteReviewError).errorModel.getAllMessages(),
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const TitleTextWidet(title: 'Delete Review'),
          content: Text(
            'Are you sure you want to delete this review?',
            style: getMediumStyle(
              fontSize: 14,
              color: AppColors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                'Cancel',
                style: getSemiBoldStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
            ),
            state is DeleteReviewLoading
                ? AppLoadingIndecator(
                    size: 10.w,
                  )
                : TextButton(
                    onPressed: () async {
                      await context.read<DeleteReviewCubit>().deleteReview(
                            reviewId: reviewModel.id!,
                          );
                    },
                    child: Text(
                      'Delete',
                      style: getSemiBoldStyle(
                        fontSize: 14,
                        color: AppColors.mainRed,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
