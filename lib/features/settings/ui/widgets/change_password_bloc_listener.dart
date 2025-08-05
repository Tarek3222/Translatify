// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/settings/logic/change_password_cubit/change_password_cubit.dart';

class ChangePasswordBlocListener extends StatelessWidget {
  const ChangePasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
          current is ChangePasswordError ||
          current is ChangePasswordLoading ||
          current is ChangePasswordSuccess,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ChangePasswordLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case ChangePasswordSuccess:
            context.pop(); // Dismiss the loading dialog
            AppSnackBar.showSuccess(
              context: context,
              message: "Password updated successfully",
            );
            break;
          case ChangePasswordError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel = (state as ChangePasswordError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    AppSnackBar.showError(context: context, message: apiErrorModel.message!);
  }
}
