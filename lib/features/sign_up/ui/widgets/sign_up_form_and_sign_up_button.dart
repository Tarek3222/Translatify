import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/sign_up/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:translators/features/sign_up/ui/widgets/sign_up_bloc_listener.dart';
import 'package:translators/features/sign_up/ui/widgets/sign_up_form.dart';

class SignUpFormAndSignupButton extends StatelessWidget {
  const SignUpFormAndSignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          const SignUpForm(),
          verticalSpacing(20),
          AppElevatedButton(
            onPressed: () {
              signUpUserState(context);
            },
            elevation: 0,
            text: 'Sign Up'.tr(),
          ),
          const SignupBlocListener(),
        ],
      ),
    );
  }

  void signUpUserState(BuildContext context) async {
    // Dismiss the keyboard if it's open
    FocusScope.of(context).unfocus();
    // show messages when the date of birth is not set or terms are not accepted
    if (context.read<SignupCubit>().dateOfBirth == null) {
      showSnackBar(context: context, message: 'pleaseSelectDateOfBirth'.tr());
    } else if (!context.read<SignupCubit>().isTermsAccepted) {
      showSnackBar(
          context: context, message: 'pleaseAcceptTermsAndPrivacyPolicy'.tr());
    }
    // Check if the form is valid, terms are accepted, and date of birth is set
    if (context.read<SignupCubit>().formKey.currentState!.validate() &&
        context.read<SignupCubit>().isTermsAccepted &&
        context.read<SignupCubit>().dateOfBirth != null) {
      await context.read<SignupCubit>().signup();
    }
  }
}
