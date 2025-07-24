import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/home/ui/widgets/recommended_translators_widgets/translator_sliver_list_item.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/payment/ui/widgets/pay_now_button_model_bottom_sheet.dart';
import 'package:translators/features/translator_profile/data/models/order_translator_model.dart';

class PaymentProccessedBody extends StatelessWidget {
  const PaymentProccessedBody({super.key, required this.orderTranslatorModel});
  final OrderTranslatorModel orderTranslatorModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleTextWidet(title: "Booking Information", fontSize: 20),
            ListTile(
              leading: const Icon(
                Icons.date_range_outlined,
                color: AppColors.mainBlue,
              ),
              title: const TitleTextWidet(title: "Date & Time"),
              subtitle: buildTextWidget(
                  "${orderTranslatorModel.date}\n${orderTranslatorModel.time}",
                  14),
            ),
            Divider(color: AppColors.grey, thickness: 0.4, height: 30.h),
            const TitleTextWidet(title: "Translator Information", fontSize: 20),
            verticalSpacing(10),
            TranslatorSliverListItem(
              translatorProfileModel:
                  orderTranslatorModel.translatorProfileModel,
            ),
            verticalSpacing(20),
            const TitleTextWidet(title: "Payment Information", fontSize: 20),
            Row(
              children: [
                buildTextWidget("Subtotal :", 16),
                const Spacer(),
                buildTextWidget(
                  "${orderTranslatorModel.salary.toStringAsFixed(2)}  ${orderTranslatorModel.currency}",
                  16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
            verticalSpacing(10),
            Row(
              children: [
                buildTextWidget("Tax :", 16),
                const Spacer(),
                buildTextWidget(
                  "200  ${orderTranslatorModel.currency}",
                  16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
            Row(
              children: [
                const TitleTextWidet(title: "Payment Total", fontSize: 16),
                const Spacer(),
                buildTextWidget(
                  "${orderTranslatorModel.salary + 200}  ${orderTranslatorModel.currency}",
                  16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
            const Spacer(),
            AppElevatedButton(
                onPressed: () {
                  payNowButtonModelBottomSheet(
                    context: context,
                    orderTranslator: orderTranslatorModel,
                  );
                },
                text: "Pay Now"),
          ],
        ),
      ),
    );
  }

  Text buildTextWidget(String title, double fontSize, {Color? color}) {
    return Text(
      title,
      style: getRegularStyle(
        fontSize: fontSize,
        color: color ?? AppColors.grey,
      ),
    );
  }
}
