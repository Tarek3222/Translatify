import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/user_profile/data/models/update_user_request_body.dart';
import 'package:translators/features/user_profile/data/repo/update_user_info_repo.dart';
part 'update_personal_information_state.dart';

class UpdatePersonalInformationCubit
    extends Cubit<UpdatePersonalInformationState> {
  final UpdateUserInfoRepo updateUserInfoRepo;

  UpdatePersonalInformationCubit(this.updateUserInfoRepo)
      : super(UpdatePersonalInformationInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? gender;
  String? dateOfBirth;
  bool isUpdate = false;
  var formKey = GlobalKey<FormState>();
  bool isChannged = false;

  Future<void> updateUserInformation() async {
    UpdateUserRequestBody updateUserRequestBody = UpdateUserRequestBody(
      nameController.text.trim(),
      phoneController.text.trim(),
      dateOfBirth!,
      gender!,
    );
    emit(UpdatePersonalInformationLoading());
    final result =
        await updateUserInfoRepo.updateUserInfo(updateUserRequestBody);
    result.fold(
        (failure) => emit(
              UpdatePersonalInformationError(errorModel: failure),
            ), (suucess) {
      isChannged = true;
      emit(
        UpdatePersonalInformationSuccess(),
      );
    });
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
