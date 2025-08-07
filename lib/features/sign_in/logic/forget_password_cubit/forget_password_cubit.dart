import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/sign_in/data/repos/forget_password_repo.dart';
part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo forgetPasswordRepo;
  ForgetPasswordCubit(this.forgetPasswordRepo) : super(ForgetPasswordInitial());
  TextEditingController emailController = TextEditingController();

  Future<void> forgetPassword() async {
    emit(ForgetPasswordLoading());
    final result = await forgetPasswordRepo.forgetPassword(
      emailController.text.trim(),
    );
    result.fold(
      (failure) => emit(
        ForgetPasswordError(errorModel: failure),
      ),
      (forgetPasswordSuccess) => emit(
        ForgetPasswordSuccess(
          message: forgetPasswordSuccess,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
