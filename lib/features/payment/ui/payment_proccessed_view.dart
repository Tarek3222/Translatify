import 'package:flutter/material.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';
import 'package:translators/features/payment/ui/widgets/payment_proccessed_body.dart';
import 'package:translators/features/translator_profile/data/models/order_translator_model.dart';

class PaymentProccessedView extends StatelessWidget {
  const PaymentProccessedView({super.key, required this.orderTranslatorModel});
  final OrderTranslatorModel orderTranslatorModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: "Payment Proccessed"),
            PaymentProccessedBody(
              orderTranslatorModel: orderTranslatorModel,
            ),
          ],
        ),
      ),
    );
  }
}
