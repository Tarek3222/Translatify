import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/core/validators/app_validator.dart';
import 'package:translator/core/widgets/app_text_form_field.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, this.emailController});
  final TextEditingController? emailController;
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: "enterYourEmail".tr(),
      autofillHints: const [AutofillHints.email],
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return AppValidators.validateEmail(value);
      },
    );
  }
}
