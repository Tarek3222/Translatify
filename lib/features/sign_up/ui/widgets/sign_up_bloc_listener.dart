// ignore_for_file: type_literal_in_constant_pattern, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/features/sign_up/logic/sign_up_cubit/sign_up_cubit.dart';

import '../../../../core/routing/routes.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignUpState>(
      listenWhen: (previous, current) =>
          current is SignupLoading ||
          current is SignupSuccess ||
          current is SignupError,
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignupLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(),
            );
            break;
          case SignupSuccess:
            String email =
                context.read<SignupCubit>().emailController.text.trim();
            context.pop(); // Dismiss the loading dialog
            showSuccessDialog(context, (state as SignupSuccess).message, email);
            break;
          case SignupError:
            // Dismiss the loading dialog and show error message
            final apiErrorModel = (state as SignupError).errorModel;
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
          title: Text('Signup Successful'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("User Registered Successfully , go to login".tr()),
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
                //todo:i return it when the otp is work in backend
                // context.pushNamed(Routes.verifyCodeEmail, arguments: email);
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
