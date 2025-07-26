// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/translator_profile/logic/payment_translator_cubit/payment_translator_cubit.dart';
import 'package:translators/features/translator_profile/ui/widgets/add_review_button_and_bloc_provider.dart';
import 'package:translators/features/translator_profile/ui/widgets/add_to_favorite_icon_button.dart';
import 'package:translators/features/translator_profile/ui/widgets/payment_bottom_sheet_widgets/pay_now_bottom_sheet_widget.dart';

class TranslatorNameAndRateAndBioSection extends StatelessWidget {
  const TranslatorNameAndRateAndBioSection(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                translatorProfileModel.name ?? 'Unknown Translator'.tr(),
                style: getSemiBoldStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Spacer(),
              AddToFavoriteIconButton(
                translatorProfileModel: translatorProfileModel,
              ),
              horizontalSpacing(20),
              Icon(
                Icons.chat,
                color: AppColors.mainBlue,
                size: 30.sp,
              ),
            ],
          ),
          verticalSpacing(8),
          Text(
            "${translatorProfileModel.translator!.first.averageRating} ⭐  (${translatorProfileModel.translator!.first.numberOfRating} reviews)",
            style: getRegularStyle(
              color: AppColors.grey,
              fontSize: 15,
            ),
          ),
          verticalSpacing(8),
          Text(
            translatorProfileModel.translator!.first.bio ??
                'No bio available'.tr(),
            style: getRegularStyle(
              color: AppColors.grey,
              fontSize: 13,
            ),
          ),
          verticalSpacing(5),
          Row(
            children: [
              AddReviewButtonAndBlocListener(
                translatorProfileModle: translatorProfileModel,
              ),
              horizontalSpacing(10),
              translatorProfileModel.translator!.first.availability!
                  ? Expanded(
                      child: AppElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: BlocProvider(
                                  create: (context) => PaymentTranslatorCubit(),
                                  child: PayNowBottomSheetWidget(
                                    translatorProfileModel:
                                        translatorProfileModel,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        text: "pay".tr(),
                        height: 40.h,
                        elevation: 0,
                      ),
                    )
                  : Expanded(
                      child: Text(
                        "Currently Unavailable".tr(),
                        style: getRegularStyle(
                          color: AppColors.mainRed,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
