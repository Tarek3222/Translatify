// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_loading_indecator.dart';
import 'package:translator/features/sign_in/logic/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetPasswordError ||
          current is ResetPasswordLoading ||
          current is ResetPasswordSuccess,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ResetPasswordLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(),
            );
            break;
          case ResetPasswordSuccess:
            context.pop(); // Dismiss the loading dialog
            showSuccessDialog(context, (state as ResetPasswordSuccess).message);
            break;
          case ResetPasswordError:
            // Dismiss the loading dialog and show error message
            final apiErrorModel = (state as ResetPasswordError).errorModel;
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
          title: Text('success'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "Password reset successfully, now go to login".tr(),
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
                context.pushNamedAndRemoveUntil(Routes.signInScreen,
                    predicate: (Route<dynamic> route) => route.isFirst);
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
