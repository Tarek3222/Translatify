// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/core/widgets/custom_app_bar.dart';
import 'package:translator/features/home/ui/widgets/recommended_translators_widgets/translator_sliver_list_item.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/payment/logic/orders_translators_cubit/orders_translators_cubit.dart';

class OrdersTranslatorsBody extends StatelessWidget {
  const OrdersTranslatorsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: CustomAppBar(title: "Orders"),
            ),
            InkWell(
              onTap: () {
                context
                    .read<OrdersTranslatorsCubit>()
                    .clearAllTranslators(SharedPrefKeys.kFavoritesListForUser);
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
          child: BlocBuilder<OrdersTranslatorsCubit, OrdersTranslatorsState>(
            buildWhen: (previous, current) =>
                current is OrdersTranslatorsEmptyList ||
                current is OrdersTranslatorsSuccess,
            builder: (context, state) {
              switch (state.runtimeType) {
                case OrdersTranslatorsEmptyList:
                  return const Center(
                    child: TitleTextWidet(title: "No Orders Found"),
                  );
                case OrdersTranslatorsSuccess:
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
      OrdersTranslatorsState state, BuildContext context) {
    double totalSalary = (state as OrdersTranslatorsSuccess)
        .translatorsList
        .map((e) => e.salary)
        .reduce((value, element) => value + element);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.translatorsList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: AppColors.mainRed,
                  margin: const EdgeInsets.symmetric(vertical: 16).w,
                ),
                onDismissed: (dismissDirection) {
                  context.read<OrdersTranslatorsCubit>().deleteTranslators(
                        SharedPrefKeys.kOrderListForUser,
                        state.translatorsList[index].translatorProfileModel
                            .translator!.first.id!,
                      );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8).w,
                  child: TranslatorSliverListItem(
                    translatorProfileModel:
                        state.translatorsList[index].translatorProfileModel,
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: AppColors.grey,
          thickness: 0.4,
          height: 30.h,
          endIndent: 20.w,
          indent: 20.w,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: TitleTextWidet(
                  title: "Payment Information",
                  fontSize: 20,
                ),
              ),
              verticalSpacing(10),
              buildRowForPayInof(
                "Subtotal :",
                "$totalSalary",
                16,
              ),
              buildRowForPayInof(
                "Taxes :",
                "${state.translatorsList.length * 200}",
                16,
              ),
              buildRowForPayInof(
                "Total :",
                "${totalSalary + (state.translatorsList.length * 200)}",
                18,
              ),
            ],
          ),
        ),
        AppElevatedButton(
          onPressed: () {},
          text: "Checkout",
          elevation: 0,
        ),
      ],
    );
  }

  Row buildRowForPayInof(String title, String subTitle, double fontSize) {
    return Row(
      children: [
        TitleTextWidet(title: title, fontSize: fontSize),
        const Spacer(),
        TitleTextWidet(
          title: subTitle,
          fontSize: fontSize,
        ),
      ],
    );
  }
}
