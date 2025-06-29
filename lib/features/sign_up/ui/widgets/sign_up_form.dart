import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/validators/app_validator.dart';
import 'package:translator/core/widgets/app_text_form_field.dart';
import 'package:translator/features/sign_up/ui/widgets/build_date_of_birth_picker.dart';
import 'package:translator/features/sign_up/ui/widgets/email_field.dart';
import 'package:translator/features/sign_up/ui/widgets/label_form.dart';
import 'package:translator/features/sign_up/ui/widgets/password_field.dart';
import 'package:translator/features/sign_up/ui/widgets/selected_gender.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelForm(
          labelText: "name".tr(),
        ),
        AppTextFormField(
          hintText: "enterYourName".tr(),
          autofillHints: const [AutofillHints.name],
          // controller: context.read<SignupCubit>().firstNameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "pleaseEnterName".tr();
            }
            return null;
          },
        ),
        LabelForm(
          labelText: "email".tr(),
        ),
        const EmailField(),
        LabelForm(
          labelText: "password".tr(),
        ),
        const PasswordField(),
        LabelForm(labelText: "phoneNumber".tr()),
        AppTextFormField(
          hintText: context.tr("enterYourPhone"),
          autofillHints: const [AutofillHints.telephoneNumber],
          // controller: context.read<SignupCubit>().phoneController,
          keyboardType: TextInputType.phone,
          validator: (value) {
            return AppValidators.validatePhoneNumber(value);
          },
        ),
        LabelForm(labelText: "dateOfBirth".tr()),
        const BuildDateOfBirthPicker(),
        LabelForm(labelText: context.tr("gender")),
        const SelectedGender(),
      ],
    );
  }
}
