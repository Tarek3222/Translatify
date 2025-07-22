import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/features/settings/data/models/update_password_request_body.dart';
import 'package:translator/features/settings/data/repos/update_password_repo.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UpdatePasswordRepo _updatePasswordRepo;

  ChangePasswordCubit(this._updatePasswordRepo)
      : super(ChangePasswordInitial());
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  Future<void> updateUserInformation() async {
    UpdatePasswordRequestBody updatePasswordRequestBody =
        UpdatePasswordRequestBody(
      currentPassword: currentPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
      confirmNewPassword: confirmPasswordController.text.trim(),
    );
    emit(ChangePasswordLoading());
    final result =
        await _updatePasswordRepo.updatePassword(updatePasswordRequestBody);
    result.fold(
        (failure) => emit(
              ChangePasswordError(errorModel: failure),
            ), (suucess) {
      emit(
        ChangePasswordSuccess(),
      );
    });
  }
}
