// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/utils/time_formated.dart';
import 'package:translator/core/widgets/custom_app_bar.dart';
import 'package:translator/features/home/ui/widgets/recommended_translators_widgets/translator_sliver_list_item.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/payment/logic/history_payments_cubit/history_payments_cubit.dart';

class PaymentsHistoryBody extends StatelessWidget {
  const PaymentsHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: CustomAppBar(title: "History Payments"),
            ),
            InkWell(
              onTap: () {
                context
                    .read<HistoryPaymentsCubit>()
                    .clearAllPaymentsTranslators(
                        SharedPrefKeys.kPaymnetsListForUser);
              },
              child: Icon(
                Icons.clear_rounded,
                size: 30.w,
                color: AppColors.mainRed,
              ),
            ),
            horizontalSpacing(10),
          ],
        ),
        Expanded(
          child: BlocBuilder<HistoryPaymentsCubit, HistoryPaymentsState>(
            buildWhen: (previous, current) =>
                current is HistoryPaymentsEmptyList ||
                current is HistoryPaymentsSuccess,
            builder: (context, state) {
              switch (state.runtimeType) {
                case HistoryPaymentsEmptyList:
                  return const Center(
                    child: TitleTextWidet(title: "No payments yet"),
                  );
                case HistoryPaymentsSuccess:
                  return buildTranslatorsListView(state, context);
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        )
      ],
    );
  }

  Widget buildTranslatorsListView(
      HistoryPaymentsState state, BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: AppColors.grey,
        thickness: 0.5,
        indent: 30.w,
        endIndent: 30.w,
      ),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount:
          (state as HistoryPaymentsSuccess).paymentTranslatorsList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: AppColors.mainRed,
            margin: const EdgeInsets.symmetric(vertical: 16).w,
          ),
          onDismissed: (dismissDirection) {
            context.read<HistoryPaymentsCubit>().deletePaymnetFromHistory(
                  SharedPrefKeys.kPaymnetsListForUser,
                  state.paymentTranslatorsList[index].time,
                );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
            child: Column(
              children: [
                TranslatorSliverListItem(
                  translatorProfileModel: state.paymentTranslatorsList[index]
                      .orderTranslator.translatorProfileModel,
                ),
                verticalSpacing(10),
                Row(
                  children: [
                    buildCustomRow(
                      "Salary: ",
                      "${state.paymentTranslatorsList[index].totalSalary.toStringAsFixed(2)} ${state.paymentTranslatorsList[0].orderTranslator.currency}",
                    ),
                    const Spacer(),
                    TitleTextWidet(
                      title: getTimeFormated(
                        context: context,
                        time: state.paymentTranslatorsList[index].date,
                      ),
                      fontSize: 14,
                      textColor: AppColors.grey,
                    ),
                  ],
                ),
                Row(
                  children: [
                    buildCustomRow(
                      "order Date: ",
                      state.paymentTranslatorsList[index].orderTranslator.date,
                    ),
                    buildCustomRow(
                      " At ",
                      state.paymentTranslatorsList[index].orderTranslator.time,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCustomRow(String title, String subTitle) {
    return Row(
      children: [
        TitleTextWidet(
          title: title,
          fontSize: 16,
        ),
        TitleTextWidet(
          title: subTitle,
          fontSize: 14,
          textColor: AppColors.grey,
        ),
      ],
    );
  }
}
