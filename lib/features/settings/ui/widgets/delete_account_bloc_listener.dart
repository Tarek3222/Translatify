// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/settings/logic/delete_account_cubit/delete_account_cubit.dart';

class DeleteAccountBlocListener extends StatelessWidget {
  const DeleteAccountBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (previous, current) =>
          current is DeleteAccountError ||
          current is DeleteAccountSuccess ||
          current is DeleteAccountLoading,
      listener: (context, state) {
        switch (state.runtimeType) {
          case DeleteAccountLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case DeleteAccountSuccess:
            context.pop(); // Dismiss the loading dialog
            context.pushNamedAndRemoveUntil(
              Routes.onBoardingScreen,
              predicate: (route) => false,
            );
            break;
          case DeleteAccountError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel = (state as DeleteAccountError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    AppSnackBar.showError(
        context: context, message: apiErrorModel.getAllMessages());
  }
}
