import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';

class NameField extends StatelessWidget {
  const NameField({super.key, required this.nameController, this.isReadOnly});
  final TextEditingController nameController;
  final bool? isReadOnly;
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      hintText: "enterYourName".tr(),
      autofillHints: const [AutofillHints.name],
      controller: nameController,
      keyboardType: TextInputType.name,
      enabled: isReadOnly,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "pleaseEnterName".tr();
        }
        return null;
      },
    );
  }
}
