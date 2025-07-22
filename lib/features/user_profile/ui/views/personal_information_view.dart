// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/features/user_profile/data/models/user_profile_model.dart';
import 'package:translator/features/user_profile/logic/update_personal_information_cubit/update_personal_information_cubit.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:translator/features/user_profile/ui/widgets/personal_information_widgets/personal_information_body.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView(
      {super.key,
      required this.userProfileModel,
      required this.userProfileCubit});
  final UserProfileModel? userProfileModel;
  final UserProfileCubit userProfileCubit;

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  @override
  void initState() {
    context.read<UpdatePersonalInformationCubit>().emailController.text =
        widget.userProfileModel!.user!.email!;
    context.read<UpdatePersonalInformationCubit>().phoneController.text =
        widget.userProfileModel!.user!.mobileNumber!;
    context.read<UpdatePersonalInformationCubit>().nameController.text =
        widget.userProfileModel!.user!.name!;
    context.read<UpdatePersonalInformationCubit>().dateOfBirth =
        widget.userProfileModel!.user!.dob!;
    context.read<UpdatePersonalInformationCubit>().gender =
        widget.userProfileModel!.user!.gender!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        if (context.read<UpdatePersonalInformationCubit>().isChannged) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.userProfileCubit.getUserProfile(forceRefresh: true);
          });
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: PersonalInformationBody(
            userProfileCubit: widget.userProfileCubit,
            userProfileModel: widget.userProfileModel,
          ),
        ),
      ),
    );
  }
}
