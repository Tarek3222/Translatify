// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/settings/logic/sign_out_cubit/sign_out_cubit.dart';

class SignOutBlocListener extends StatelessWidget {
  const SignOutBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listenWhen: (previous, current) =>
          current is SignOutError ||
          current is SignOutSuccess ||
          current is SignOutLoading,
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignOutLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case SignOutSuccess:
            context.pop(); // Dismiss the loading dialog
            context.pushNamedAndRemoveUntil(
              Routes.onBoardingScreen,
              predicate: (route) => false,
            );
            break;
          case SignOutError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel = (state as SignOutError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    showSnackBar(context: context, message: apiErrorModel.getAllMessages());
  }
}
