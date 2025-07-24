// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/translator_profile/data/repos/reviews_repo.dart';
import 'package:translators/features/translator_profile/logic/add_review_cubit/add_review_cubit.dart';
import 'package:translators/features/translator_profile/ui/widgets/add_review_widgets_and_bloc_consumer.dart';

class AddReviewButtonAndBlocListener extends StatelessWidget {
  const AddReviewButtonAndBlocListener(
      {super.key, required this.translatorProfileModle});
  final TranslatorProfileModel translatorProfileModle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppElevatedButton(
        onPressed: () {
          showModelBottomSheetForAddReview(context);
        },
        text: "Add Review",
        height: 40.h,
        elevation: 0,
      ),
    );
  }

  void showModelBottomSheetForAddReview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => AddReviewCubit(getIt<ReviewsRepo>()),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddReviewWidgetsAndBlocConsumer(
              translatorProfileModle: translatorProfileModle,
            ),
          ),
        );
      },
    );
  }
}
