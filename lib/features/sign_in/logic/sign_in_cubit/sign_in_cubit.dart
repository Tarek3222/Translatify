import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/dio_factory.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/utils/user_model.dart';
import 'package:translator/features/sign_in/data/models/sign_in_request_body.dart';
import 'package:translator/features/sign_in/data/repos/sign_in_repo.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo signInRepo;
  SignInCubit(this.signInRepo) : super(SignInInitial());
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> signInUser() async {
    SignInRequestBody signInRequestBody = SignInRequestBody(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    emit(SignInLoading());
    final result = await signInRepo.signIn(
      signInRequestBody: signInRequestBody,
    );
    result.fold(
        (failure) => emit(
              SignInError(errorModel: failure),
            ), (userModel) async {
      // Save user data to local storage or perform any necessary actions
      await saveUserData(userModel);
      emit(
        SignInSuccess(),
      );
    });
  }

  Future<void> saveUserData(UserModel userModel) async {
    await getIt<SharedPrefHelper>().setSecuredString(
        SharedPrefKeys.kUserDataKey, jsonEncode(userModel.toJson()));
    DioFactory.setTokenIntoHeaderAfterLogin(userModel.token.accessToken);
  }
}
