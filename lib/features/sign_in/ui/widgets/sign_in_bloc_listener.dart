// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/widgets/app_loading_indecator.dart';
import 'package:translator/features/sign_in/logic/sign_in_cubit/sign_in_cubit.dart';

class SignInBlocListener extends StatelessWidget {
  const SignInBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (previous, current) =>
          current is SignInError ||
          current is SignInLoading ||
          current is SignInSuccess,
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignInLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(),
            );
            break;
          case SignInSuccess:
            context.pop(); // Dismiss the loading dialog
            signInSuccessState(context);
            break;
          case SignInError:
            // Dismiss the loading dialog and show error message
            final apiErrorModel = (state as SignInError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void signInSuccessState(BuildContext context) {
    context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (_) => false);
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
