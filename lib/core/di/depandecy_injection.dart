import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/networking/api_service.dart';
import 'package:translators/core/networking/dio_factory.dart';
import 'package:translators/core/networking/network_info.dart';
import 'package:translators/features/home/data/date_source/local_data_source/translators_list_local_data_source.dart';
import 'package:translators/features/home/data/repos/translators_list_repo.dart';
import 'package:translators/features/payment/data/repos/check_out_repo.dart';
import 'package:translators/features/payment/data/repos/create_customer_repo.dart';
import 'package:translators/features/settings/data/repos/sign_out_and_delete_account_repo.dart';
import 'package:translators/features/settings/data/repos/update_password_repo.dart';
import 'package:translators/features/sign_in/data/repos/forget_password_repo.dart';
import 'package:translators/features/sign_in/data/repos/reset_password_repo.dart';
import 'package:translators/features/sign_in/data/repos/sign_in_repo.dart';
import 'package:translators/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:translators/features/translator_profile/data/repos/reviews_repo.dart';
import 'package:translators/features/user_profile/data/data_source/local_data_source/user_profile_local_data_source.dart';
import 'package:translators/features/user_profile/data/data_source/remote_data_source/upload_image_data_source.dart';
import 'package:translators/features/user_profile/data/repo/delete_user_images_repo.dart';
import 'package:translators/features/user_profile/data/repo/update_user_info_repo.dart';
import 'package:translators/features/user_profile/data/repo/upload_user_images_repo.dart';
import 'package:translators/features/user_profile/data/repo/user_profile_repo.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPrefHelper>(
      () => SharedPrefHelper(sharedPreferences));
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnection()));
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
  // User Profile
  getIt.registerLazySingleton<UserProfileLocalDataSource>(
    () => UserProfileLocalDataSource(),
  );
  getIt.registerLazySingleton<UserProfileRepo>(
    () => UserProfileRepo(
      getIt<ApiService>(),
      getIt<NetworkInfo>(),
      getIt<UserProfileLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<DeleteUserImagesRepo>(
    () => DeleteUserImagesRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<UploadImageDataSource>(
    () => UploadImageDataSource(dio: dio),
  );
  getIt.registerLazySingleton<UploadUserImagesRepo>(
    () => UploadUserImagesRepo(getIt<UploadImageDataSource>()),
  );
  getIt.registerLazySingleton<UpdateUserInfoRepo>(
    () => UpdateUserInfoRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<UpdatePasswordRepo>(
    () => UpdatePasswordRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<SignOutAndDeleteAccountRepo>(
    () => SignOutAndDeleteAccountRepo(getIt<ApiService>()),
  );

  // translators list
  getIt.registerLazySingleton<TranslatorsListLocalDataSource>(
    () => TranslatorsListLocalDataSource(),
  );
  getIt.registerLazySingleton<TranslatorsListRepo>(
    () => TranslatorsListRepo(
      getIt<ApiService>(),
      getIt<NetworkInfo>(),
      getIt<TranslatorsListLocalDataSource>(),
    ),
  );
  // reviews
  getIt.registerLazySingleton<ReviewsRepo>(
    () => ReviewsRepo(getIt<ApiService>()),
  );
  // Payment
  getIt.registerLazySingleton<CheckOutRepo>(
    () => CheckOutRepo(),
  );
  getIt.registerLazySingleton<CreateCustomerRepo>(
    () => CreateCustomerRepo(),
  );
}
