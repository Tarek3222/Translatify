import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/core/widgets/app_loading_indecator.dart';
import 'package:translator/core/widgets/app_snack_bar.dart';
import 'package:translator/features/payment/data/models/payment_intnet_input_model.dart';
import 'package:translator/features/payment/logic/orders_translators_cubit/orders_translators_cubit.dart';
import 'package:translator/features/payment/logic/payment_cubit/payment_cubit.dart';
import 'package:translator/features/translator_profile/data/models/order_translator_model.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
    required this.orderTranslator,
    this.orderCubit,
  });
  final OrderTranslatorModel orderTranslator;
  final OrdersTranslatorsCubit? orderCubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentStates>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          // todo: navigate to success screen
          context.pushReplacementNamed(
            Routes.thankYouView,
            arguments: {
              "paymentResponseModel": state.paymentResponseModel,
              "orderCubit": orderCubit
            },
          );
        }
        if (state is PaymentError) {
          context.pop();
          showSnackBar(context: context, message: state.error);
        }
      },
      builder: (context, state) {
        return state is PaymentLoading
            ? const AppLoadingIndecator()
            : AppElevatedButton(
                text: 'Continue',
                onPressed: () {
                  PaymentIntentInputModel paymentIntentInputModel =
                      PaymentIntentInputModel(
                    amount: orderTranslator.salary.toInt() + 200,
                    currency: orderTranslator.currency,
                    customerId: getIt<SharedPrefHelper>().getString(
                      SharedPrefKeys.kCustomerId,
                    )!,
                  );
                  context.read<PaymentCubit>().makePayment(
                        paymentIntentInput: paymentIntentInputModel,
                        orderTranslator: orderTranslator,
                        totalSalary: orderTranslator.salary + 200,
                      );
                },
              );
      },
    );
  }
}
