// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translator/features/translator_profile/data/repos/reviews_repo.dart';
import 'package:translator/features/translator_profile/logic/update_review_cubit/update_review_cubit.dart';
import 'package:translator/features/translator_profile/ui/widgets/edit_review_widgets_and_bloc_consumer.dart';

void showModelBottomSheetForUpdateReview(BuildContext context,
    {required ReviewModel reviewModel}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.background,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => UpdateReviewCubit(getIt<ReviewsRepo>()),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditReviewWidgetsAndBlocConsumer(
            reviewModel: reviewModel,
          ),
        ),
      );
    },
  );
}
