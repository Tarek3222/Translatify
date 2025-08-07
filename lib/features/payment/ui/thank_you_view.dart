// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';
import 'package:translators/features/payment/data/models/payment_response_model.dart';
import 'package:translators/features/payment/logic/orders_translators_cubit/orders_translators_cubit.dart';
import 'package:translators/features/payment/ui/widgets/thank_you_body.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView(
      {super.key, required this.paymentResponseModel, this.orderCubit});
  final PaymentResponseModel paymentResponseModel;
  final OrdersTranslatorsCubit? orderCubit;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if order cubit is null i will pop to translator view else pack to orders view
        if (orderCubit != null) {
          orderCubit!
              .getTranslatorsFromOrders(SharedPrefKeys.kOrderListForUser);
          context.pop();
        } else {
          context.pop();
          context.pop();
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Payment Done",
                onBackPress: () {
                  if (orderCubit != null) {
                    orderCubit!.getTranslatorsFromOrders(
                        SharedPrefKeys.kOrderListForUser);
                    context.pop();
                  } else {
                    context.pop();
                    context.pop();
                  }
                },
              ),
              ThankYouBody(paymentResponseModel: paymentResponseModel),
            ],
          ),
        ),
      ),
    );
  }
}
