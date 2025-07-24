import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/utils/time_formated.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/payment/data/models/payment_response_model.dart';

class ThankYouBody extends StatelessWidget {
  const ThankYouBody({super.key, required this.paymentResponseModel});
  final PaymentResponseModel paymentResponseModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Lottie.asset(
              "assets/images/success.json",
              height: 200.h,
              width: 200.w,
            ),
          ),
          const TitleTextWidet(title: "Payment Information", fontSize: 20),
          verticalSpacing(15),
          buidCutomRow(
            title: "Date",
            subTitle: getTimeFormated(
                context: context, time: paymentResponseModel.date),
          ),
          verticalSpacing(10),
          buidCutomRow(
            title: "To",
            subTitle: "TranslationsHub",
          ),
          Divider(
            color: AppColors.grey,
            thickness: 0.4,
            height: 30.h,
          ),
          buidCutomRow(
            title: "Total",
            subTitle:
                "${paymentResponseModel.totalSalary.toStringAsFixed(2)} ${paymentResponseModel.orderTranslator.currency} ",
            fontSize: 20,
          ),
        ],
      ),
    );
  }

  Row buidCutomRow(
      {required String title, required String subTitle, double? fontSize}) {
    return Row(
      children: [
        TitleTextWidet(title: title, fontSize: fontSize ?? 16),
        const Spacer(),
        TitleTextWidet(title: subTitle, fontSize: fontSize ?? 16),
      ],
    );
  }
}
