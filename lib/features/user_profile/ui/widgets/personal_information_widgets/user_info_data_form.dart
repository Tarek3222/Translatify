import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/helpers/spacing.dart';
import 'package:translator/core/widgets/app_elevated_button.dart';
import 'package:translator/features/sign_up/ui/widgets/build_date_of_birth_picker.dart';
import 'package:translator/features/sign_up/ui/widgets/email_field.dart';
import 'package:translator/features/sign_up/ui/widgets/label_form.dart';
import 'package:translator/features/sign_up/ui/widgets/name_field.dart';
import 'package:translator/features/sign_up/ui/widgets/phone_field.dart';
import 'package:translator/features/sign_up/ui/widgets/selected_gender.dart';
import 'package:translator/features/user_profile/data/models/user_profile_model.dart';
import 'package:translator/features/user_profile/logic/update_personal_information_cubit/update_personal_information_cubit.dart';
import 'package:translator/features/user_profile/ui/widgets/personal_information_widgets/account_info_data.dart';
import 'package:translator/features/user_profile/ui/widgets/personal_information_widgets/update_user_info_bloc_listener.dart';

class UserInfoDataForm extends StatefulWidget {
  const UserInfoDataForm({super.key, required this.userProfileModel});
  final UserProfileModel? userProfileModel;

  @override
  State<UserInfoDataForm> createState() => _UserInfoDataFormState();
}

class _UserInfoDataFormState extends State<UserInfoDataForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2).w,
        child: Form(
          key: context.read<UpdatePersonalInformationCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelForm(
                labelText: "email".tr(),
              ),
              EmailField(
                isReadOnly: false,
                emailController: context
                    .read<UpdatePersonalInformationCubit>()
                    .emailController,
              ),
              verticalSpacing(10),
              LabelForm(
                labelText: "name".tr(),
              ),
              NameField(
                isReadOnly:
                    context.read<UpdatePersonalInformationCubit>().isUpdate,
                nameController: context
                    .read<UpdatePersonalInformationCubit>()
                    .nameController,
              ),
              verticalSpacing(10),
              LabelForm(labelText: "phoneNumber".tr()),
              PhoneField(
                isReadOnly:
                    context.read<UpdatePersonalInformationCubit>().isUpdate,
                phoneController: context
                    .read<UpdatePersonalInformationCubit>()
                    .phoneController,
              ),
              verticalSpacing(10),
              LabelForm(labelText: context.tr("gender")),
              IgnorePointer(
                ignoring:
                    !context.read<UpdatePersonalInformationCubit>().isUpdate,
                child: SelectedGender(
                  initialGender:
                      context.read<UpdatePersonalInformationCubit>().gender,
                  onSelectMale: () {
                    context.read<UpdatePersonalInformationCubit>().gender =
                        "male";
                  },
                  onSelectFemale: () {
                    context.read<UpdatePersonalInformationCubit>().gender =
                        "female";
                  },
                ),
              ),
              verticalSpacing(10),
              LabelForm(labelText: "dateOfBirth".tr()),
              IgnorePointer(
                ignoring:
                    !context.read<UpdatePersonalInformationCubit>().isUpdate,
                child: BuildDateOfBirthPicker(
                  onDateSelected: (pickedDate) {
                    context.read<UpdatePersonalInformationCubit>().dateOfBirth =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  },
                  initialDate: context
                      .read<UpdatePersonalInformationCubit>()
                      .dateOfBirth,
                ),
              ),
              verticalSpacing(10),
              AccountInfoData(
                userProfileModel: widget.userProfileModel,
              ),
              verticalSpacing(10),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: AppElevatedButton(
                  onPressed: () async {
                    if (context
                        .read<UpdatePersonalInformationCubit>()
                        .isUpdate) {
                      context.read<UpdatePersonalInformationCubit>().isUpdate =
                          false;
                      if (context
                          .read<UpdatePersonalInformationCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                        await context
                            .read<UpdatePersonalInformationCubit>()
                            .updateUserInformation();
                      }
                    } else {
                      context.read<UpdatePersonalInformationCubit>().isUpdate =
                          true;
                    }
                    setState(() {});
                  },
                  text: context.read<UpdatePersonalInformationCubit>().isUpdate
                      ? "Save Profile"
                      : "Edit Profile",
                  width: MediaQuery.sizeOf(context).width * 0.5,
                ),
              ),
              const UpdateUserInfoBlocListener()
            ],
          ),
        ),
      ),
    );
  }
}
