// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/translator_profile/logic/payment_translator_cubit/payment_translator_cubit.dart';

class ProccessedButtonAndBlocConsumer extends StatelessWidget {
  const ProccessedButtonAndBlocConsumer({super.key, required this.translator});
  final TranslatorProfileModel translator;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentTranslatorCubit, PaymentTranslatorState>(
      listener: (context, state) {
        if (state is PaymentTranslatorError) {
          showCustomDialog(context, "Duplicate Payment", state.errorMessage);
        } else if (state is PaymentTranslatorSuccess) {
          context.pop();
          context.pushNamed(Routes.paymentProccessView,
              arguments: state.orderTranslatorModel);
        }
      },
      builder: (context, state) {
        return AppElevatedButton(
          onPressed: () async {
            final paymentTranslatorCubit =
                context.read<PaymentTranslatorCubit>();
            await proccessdButtonState(paymentTranslatorCubit, context);
          },
          text: "Proccessed",
        );
      },
    );
  }

  Future<void> proccessdButtonState(
      PaymentTranslatorCubit paymentTranslatorCubit,
      BuildContext context) async {
    if (paymentTranslatorCubit.formKey.currentState!.validate()) {
      if (paymentTranslatorCubit.time.isNullOrEmpty() ||
          paymentTranslatorCubit.date.isNullOrEmpty()) {
        showCustomDialog(
            context, "Pick DateTime", "Please Pick Scheduled Time & Date");
      } else {
        DateTime date = DateTime.parse(paymentTranslatorCubit.date!);
        bool isFutureDate = date.isAfter(DateTime.now());
        if (isFutureDate) {
          await paymentTranslatorCubit.addTranslatorToOrder(
              key: SharedPrefKeys.kOrderListForUser, translator: translator);
        } else {
          showCustomDialog(context, "Pick DateTime", "Please Pick Future Date");
        }
      }
    }
  }

  void showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: TitleTextWidet(title: title, textColor: Colors.red),
          content: Text(
            message,
            style: getMediumStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                "OK",
                style:
                    getSemiBoldStyle(fontSize: 16, color: AppColors.mainBlue),
              ),
            ),
          ],
        );
      },
    );
  }
}
