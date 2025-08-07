import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translators/core/validators/app_validator.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key, required this.phoneController, this.isReadOnly});
  final TextEditingController phoneController;
  final bool? isReadOnly;

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: context.tr("enterYourPhone"),
      autofillHints: const [AutofillHints.telephoneNumber],
      controller: phoneController,
      keyboardType: TextInputType.phone,
      enabled: isReadOnly,
      validator: (value) {
        return AppValidators.validatePhoneNumber(value);
      },
    );
  }
}
