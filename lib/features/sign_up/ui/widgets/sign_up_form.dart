import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/sign_up/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:translator/features/sign_up/ui/widgets/build_date_of_birth_picker.dart';
import 'package:translator/features/sign_up/ui/widgets/email_field.dart';
import 'package:translator/features/sign_up/ui/widgets/label_form.dart';
import 'package:translator/features/sign_up/ui/widgets/name_field.dart';
import 'package:translator/features/sign_up/ui/widgets/password_field.dart';
import 'package:translator/features/sign_up/ui/widgets/phone_field.dart';
import 'package:translator/features/sign_up/ui/widgets/selected_gender.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelForm(
          labelText: "name".tr(),
        ),
        NameField(nameController: context.read<SignupCubit>().nameController),
        LabelForm(
          labelText: "email".tr(),
        ),
        EmailField(
          emailController: context.read<SignupCubit>().emailController,
        ),
        LabelForm(
          labelText: "password".tr(),
        ),
        PasswordField(
          passwordController: context.read<SignupCubit>().passwordController,
        ),
        LabelForm(labelText: "phoneNumber".tr()),
        PhoneField(
            phoneController: context.read<SignupCubit>().phoneController),
        LabelForm(labelText: "dateOfBirth".tr()),
        BuildDateOfBirthPicker(
          fromAny: "signUp",
          onDateSelected: (pickedDate) {
            context.read<SignupCubit>().dateOfBirth = pickedDate;
          },
        ),
        LabelForm(labelText: context.tr("gender")),
        SelectedGender(
          onSelectMale: () {
            context.read<SignupCubit>().gender = "male";
          },
          onSelectFemale: () {
            context.read<SignupCubit>().gender = "female";
          },
        ),
      ],
    );
  }
}
