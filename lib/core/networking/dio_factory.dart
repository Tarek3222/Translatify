import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/core/utils/user_model.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {
      'Authorization': token,
    };
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? userToken = await getToken();
          if (!userToken.isNullOrEmpty()) {
            options.headers['token'] = userToken;
          }
          String? refreshToken = await getRefreshToken();
          if (!refreshToken.isNullOrEmpty()) {
            options.headers['refreshtoken'] = refreshToken;
          }
          return handler.next(options);
        },
      ),
    );
  }
}

Future<String?> getToken() async {
  String? userData = await getIt<SharedPrefHelper>()
      .getSecuredString(SharedPrefKeys.kUserDataKey);
  String? userToken;
  if (userData != null) {
    userToken = UserModel.fromJson(
      jsonDecode(userData),
    ).token.accessToken;
  }
  return userToken;
}

Future<String?> getRefreshToken() async {
  String? userData = await getIt<SharedPrefHelper>()
      .getSecuredString(SharedPrefKeys.kUserDataKey);
  String? refreshToken;
  if (userData != null) {
    refreshToken = UserModel.fromJson(
      jsonDecode(userData),
    ).token.refreshToken;
  }
  return refreshToken;
}
