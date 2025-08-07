// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/features/sign_in/logic/forget_password_cubit/forget_password_cubit.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  const ForgetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          current is ForgetPasswordError ||
          current is ForgetPasswordLoading ||
          current is ForgetPasswordSuccess,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ForgetPasswordLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(),
            );
            break;
          case ForgetPasswordSuccess:
            context.pop(); // Dismiss the loading dialog
            String email =
                context.read<ForgetPasswordCubit>().emailController.text.trim();
            showSuccessDialog(
                context, (state as ForgetPasswordSuccess).message, email);
            break;
          case ForgetPasswordError:
            // Dismiss the loading dialog and show error message
            final apiErrorModel = (state as ForgetPasswordError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void showSuccessDialog(BuildContext context, String message, String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('success'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "OTP sent to your email, now go to reset your password".tr(),
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
                context.pop(); // Dismiss the success dialog
                context.pushNamed(Routes.resetPassword, arguments: email);
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
    var theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.background,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          apiErrorModel.getAllMessages(),
          style: getMediumStyle(
            fontSize: 16,
            color: theme.colorScheme.error,
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
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
