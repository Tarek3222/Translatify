import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/sign_up/ui/widgets/build_date_of_birth_picker.dart';
import 'package:translators/features/sign_up/ui/widgets/email_field.dart';
import 'package:translators/features/sign_up/ui/widgets/label_form.dart';
import 'package:translators/features/sign_up/ui/widgets/name_field.dart';
import 'package:translators/features/sign_up/ui/widgets/phone_field.dart';
import 'package:translators/features/sign_up/ui/widgets/selected_gender.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';
import 'package:translators/features/user_profile/logic/update_personal_information_cubit/update_personal_information_cubit.dart';
import 'package:translators/features/user_profile/ui/widgets/personal_information_widgets/account_info_data.dart';
import 'package:translators/features/user_profile/ui/widgets/personal_information_widgets/update_user_info_bloc_listener.dart';

class UserInfoDataForm extends StatefulWidget {
  const UserInfoDataForm({super.key, required this.userProfileModel});
  final UserProfileModel? userProfileModel;

  @override
  State<UserInfoDataForm> createState() => _UserInfoDataFormState();
}

class _UserInfoDataFormState extends State<UserInfoDataForm> {
  @override
  Widget build(BuildContext context) {
    var updatePersonalInfoCubit =
        context.read<UpdatePersonalInformationCubit>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2).w,
        child: Form(
          key: updatePersonalInfoCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelForm(
                labelText: "email".tr(),
              ),
              EmailField(
                isReadOnly: false,
                emailController: updatePersonalInfoCubit.emailController,
              ),
              verticalSpacing(10),
              LabelForm(
                labelText: "name".tr(),
              ),
              NameField(
                isReadOnly: updatePersonalInfoCubit.isUpdate,
                nameController: updatePersonalInfoCubit.nameController,
              ),
              verticalSpacing(10),
              LabelForm(labelText: "phoneNumber".tr()),
              PhoneField(
                isReadOnly: updatePersonalInfoCubit.isUpdate,
                phoneController: updatePersonalInfoCubit.phoneController,
              ),
              verticalSpacing(10),
              LabelForm(labelText: context.tr("gender")),
              IgnorePointer(
                ignoring: !updatePersonalInfoCubit.isUpdate,
                child: SelectedGender(
                  initialGender: updatePersonalInfoCubit.gender,
                  onSelectMale: () {
                    updatePersonalInfoCubit.gender = "male";
                  },
                  onSelectFemale: () {
                    updatePersonalInfoCubit.gender = "female";
                  },
                ),
              ),
              verticalSpacing(10),
              LabelForm(labelText: "dateOfBirth".tr()),
              IgnorePointer(
                ignoring: !updatePersonalInfoCubit.isUpdate,
                child: BuildDateOfBirthPicker(
                  fromAny: "update",
                  onDateSelected: (pickedDate) {
                    updatePersonalInfoCubit.dateOfBirth =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  },
                  initialDate: DateTime.tryParse(
                      updatePersonalInfoCubit.dateOfBirth ?? ""),
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
                    await savePersonalDataState(updatePersonalInfoCubit);
                  },
                  text: updatePersonalInfoCubit.isUpdate
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

  Future<void> savePersonalDataState(
      UpdatePersonalInformationCubit updatePersonalInfoCubit) async {
    if (updatePersonalInfoCubit.isUpdate) {
      updatePersonalInfoCubit.isUpdate = false;
      if (updatePersonalInfoCubit.formKey.currentState!.validate()) {
        await updatePersonalInfoCubit.updateUserInformation();
      }
    } else {
      updatePersonalInfoCubit.isUpdate = true;
    }
    setState(() {});
  }
}
