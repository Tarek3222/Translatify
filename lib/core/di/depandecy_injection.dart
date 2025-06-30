import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/networking/api_service.dart';
import 'package:translator/core/networking/dio_factory.dart';
import 'package:translator/features/sign_in/data/repos/forget_password_repo.dart';
import 'package:translator/features/sign_in/data/repos/reset_password_repo.dart';
import 'package:translator/features/sign_in/data/repos/sign_in_repo.dart';
import 'package:translator/features/sign_up/data/repos/sign_up_repo.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPrefHelper>(
      () => SharedPrefHelper(sharedPreferences));
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dio),
  );
  // Sign Up
  getIt.registerLazySingleton<SignUpRepo>(
    () => SignUpRepo(getIt<ApiService>()),
  );
  // forget password
  getIt.registerLazySingleton<ForgetPasswordRepo>(
    () => ForgetPasswordRepo(getIt<ApiService>()),
  );
  // Reset Password
  getIt.registerLazySingleton<ResetPasswordRepo>(
    () => ResetPasswordRepo(getIt<ApiService>()),
  );
  // Sign In
  getIt.registerLazySingleton<SignInRepo>(
    () => SignInRepo(getIt<ApiService>()),
  );
}
