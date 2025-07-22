import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/core/validators/app_validator.dart';
import 'package:translator/core/widgets/app_text_form_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key, this.passwordController, this.validator, this.hintText});
  final TextEditingController? passwordController;
  final String? Function(String?)? validator;
  final String? hintText;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordObscureText = true;
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: widget.hintText ?? "password".tr(),
      autofillHints: const [AutofillHints.password],
      controller: widget.passwordController,
      keyboardType: TextInputType.visiblePassword,
      isObscureText: isPasswordObscureText,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            isPasswordObscureText = !isPasswordObscureText;
          });
        },
        child: Icon(
          isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      ),
      validator: widget.validator ??
          (value) {
            return AppValidators.validatePassword(value);
          },
    );
  }
}
