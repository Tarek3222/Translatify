// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/features/payment/logic/orders_translators_cubit/orders_translators_cubit.dart';
import 'package:translators/features/payment/logic/payment_cubit/payment_cubit.dart';
import 'package:translators/features/payment/data/repos/check_out_repo.dart';
import 'package:translators/features/payment/ui/widgets/custom_button_bloc_consumer.dart';
import 'package:translators/features/payment/ui/widgets/payment_method_list_view.dart';
import 'package:translators/features/translator_profile/data/models/order_translator_model.dart';

payNowButtonModelBottomSheet(
    {required BuildContext context,
    required OrderTranslatorModel orderTranslator,
    OrdersTranslatorsCubit? orderCubit}) {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => PaymentCubit(
        getIt<CheckOutRepo>(),
      ),
      child: PaymentMethodsBottomSheet(
        orderTranslator: orderTranslator,
      ),
    ),
  );
}

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet(
      {super.key, required this.orderTranslator, this.orderCubit});
  final OrderTranslatorModel orderTranslator;
  final OrdersTranslatorsCubit? orderCubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).w,
      child: Column(
        spacing: 12.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          const PaymentMethodsListView(),
          CustomButtonBlocConsumer(
            orderTranslator: orderTranslator,
            orderCubit: orderCubit,
          ),
        ],
      ),
    );
  }
}
