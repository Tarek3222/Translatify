// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/features/sign_up/logic/confirm_email_cubit/confirm_email_cubit.dart';

import '../../../../core/routing/routes.dart';

class VerifyEmailBlocListener extends StatelessWidget {
  const VerifyEmailBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfirmEmailCubit, ConfirmEmailState>(
      listenWhen: (previous, current) =>
          current is ConfirmEmailError ||
          current is ConfirmEmailSuccess ||
          current is ConfirmEmailLoading,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ConfirmEmailLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(),
            );
            break;
          case ConfirmEmailSuccess:
            context.pop(); // Dismiss the loading dialog
            showSuccessDialog(context, (state as ConfirmEmailSuccess).message);
            break;
          case ConfirmEmailError:
            // Dismiss the loading dialog and show error message
            final apiErrorModel = (state as ConfirmEmailError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('Email Verified'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Email confirmed successfully, go to login".tr(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                surfaceTintColor: Colors.grey,
              ),
              onPressed: () {
                context.pushNamedAndRemoveUntil(Routes.onBoardingScreen,
                    predicate: (Route<dynamic> route) => false);
              },
              child: Text('continue'.tr()),
            ),
          ],
        );
      },
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          apiErrorModel.getAllMessages(),
          style: getMediumStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it'.tr(),
              style: getMediumStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
