import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/sign_in/data/models/reset_password_request_body.dart';
import 'package:translators/features/sign_in/data/repos/reset_password_repo.dart';
part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo resetPasswordRepo;
  ResetPasswordCubit(this.resetPasswordRepo) : super(ResetPasswordInitial());
  String email = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String code = '';

  Future<void> resetPassword() async {
    ResetPasswordRequestBody resetPasswordRequestBody =
        ResetPasswordRequestBody(
      confirmOtp: code.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );
    emit(ResetPasswordLoading());
    final result = await resetPasswordRepo.resetPassword(
      email,
      resetPasswordRequestBody,
    );
    result.fold(
      (failure) => emit(
        ResetPasswordError(errorModel: failure),
      ),
      (resetPasswordSuccess) => emit(
        ResetPasswordSuccess(
          message: resetPasswordSuccess,
        ),
      ),
    );
  }
}
