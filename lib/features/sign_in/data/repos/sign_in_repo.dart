import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:translator/core/networking/api_error_handler.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/core/utils/user_model.dart';
import 'package:translator/features/sign_in/data/models/sign_in_request_body.dart';

class SignInRepo {
  final ApiService _apiService;
  SignInRepo(this._apiService);

  Future<Either<ApiErrorModel, UserModel>> signIn(
      {required SignInRequestBody signInRequestBody}) async {
    try {
      final response = await _apiService.signIn(signInRequestBody);
      Map<String, dynamic> jsonDecodeResponse = jsonDecode(response);
      return Right(UserModel.fromJson(jsonDecodeResponse));
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
