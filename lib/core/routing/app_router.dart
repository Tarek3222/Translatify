import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/features/google_translate/logic/app_state.dart';
import 'package:translators/features/google_translate/ui/views/google_translate_view.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/home/data/repos/translators_list_repo.dart';
import 'package:translators/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translators/features/home/ui/recommended_translators_view.dart';
import 'package:translators/features/main/image_viewer_view.dart';
import 'package:translators/features/main/logic/bottom_nav_bar_cubit/bottom_nav_bar_index_cubit.dart';
import 'package:translators/features/main/ui/main_view.dart';
import 'package:translators/features/on_boarding/ui/views/on_boarding_view.dart';
import 'package:translators/features/payment/ui/orders_translators_view.dart';
import 'package:translators/features/payment/ui/payment_proccessed_view.dart';
import 'package:translators/features/payment/ui/payments_history_view.dart';
import 'package:translators/features/payment/ui/thank_you_view.dart';
import 'package:translators/features/settings/data/repos/update_password_repo.dart';
import 'package:translators/features/settings/logic/change_password_cubit/change_password_cubit.dart';
import 'package:translators/features/settings/ui/change_password_view.dart';
import 'package:translators/features/settings/ui/f_a_q_view.dart';
import 'package:translators/features/settings/ui/settings_view.dart';
import 'package:translators/features/settings/ui/support_view.dart';
import 'package:translators/features/sign_in/data/repos/reset_password_repo.dart';
import 'package:translators/features/sign_in/data/repos/sign_in_repo.dart';
import 'package:translators/features/sign_in/logic/forget_password_cubit/forget_password_cubit.dart';
import 'package:translators/features/sign_in/logic/reset_password_cubit/reset_password_cubit.dart';
import 'package:translators/features/sign_in/logic/sign_in_cubit/sign_in_cubit.dart';
import 'package:translators/features/sign_in/ui/views/forget_password_view.dart';
import 'package:translators/features/sign_in/ui/views/reset_password_view.dart';
import 'package:translators/features/sign_in/ui/views/sign_in_view.dart';
import 'package:translators/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:translators/features/sign_up/logic/confirm_email_cubit/confirm_email_cubit.dart';
import 'package:translators/features/sign_up/logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:translators/features/sign_up/ui/views/sign_up_view.dart';
import 'package:translators/features/sign_up/ui/views/verification_code_email_view.dart';
import 'package:translators/features/translator_profile/data/models/order_translator_model.dart';
import 'package:translators/features/translator_profile/ui/cv_viewer_view.dart';
import 'package:translators/features/translator_profile/ui/translator_profile_view.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';
import 'package:translators/features/user_profile/data/repo/update_user_info_repo.dart';
import 'package:translators/features/user_profile/data/repo/user_profile_repo.dart';
import 'package:translators/features/user_profile/logic/update_personal_information_cubit/update_personal_information_cubit.dart';
import 'package:translators/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:translators/features/user_profile/ui/views/personal_information_view.dart';
import 'package:translators/features/user_profile/ui/views/translators_favorites_view.dart';

import '../../features/sign_in/data/repos/forget_password_repo.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingView(),
        );
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BottomNavBarIndexCubit(),
              ),
              BlocProvider(
                create: (context) => UserProfileCubit(getIt<UserProfileRepo>())
                  ..getUserProfile(),
              ),
              BlocProvider(
                create: (context) =>
                    GetTranslatorsListCubit(getIt<TranslatorsListRepo>())
                      ..getTranslatorsList(),
              ),
            ],
            child: const MainView(),
          ),
        );
      case Routes.translatorProfileScreen:
        return MaterialPageRoute(
          builder: (context) => TranslatorProfileView(
            translatorProfileModel:
                settings.arguments as TranslatorProfileModel,
          ),
        );
      case Routes.changePasswordView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                ChangePasswordCubit(getIt<UpdatePasswordRepo>()),
            child: const ChangePasswordView(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignupCubit(getIt<SignUpRepo>()),
            child: const SignUpView(),
          ),
        );
      case Routes.signInScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => SignInCubit(getIt<SignInRepo>()),
              child: const SignInView()),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) =>
                  ForgetPasswordCubit(getIt<ForgetPasswordRepo>()),
              child: const ForgetPasswordView()),
        );
      case Routes.verifyCodeEmail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ConfirmEmailCubit(getIt<SignUpRepo>()),
            child: VerificationEmailCodeView(
              email: settings.arguments as String? ?? '',
            ),
          ),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingsView(),
        );
      case Routes.googleTranslateView:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => GoogleTranslateAppState(),
            child: const GoogleTranslateView(),
          ),
        );
      case Routes.cvViewerView:
        return MaterialPageRoute(
          builder: (context) =>
              CvViewerView(pdfUrl: settings.arguments as String),
        );
      case Routes.recommendedTranslatorsView:
        final date = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => RecommendedTranslatorsView(
            translatorsList:
                date['translatorsList'] as List<TranslatorProfileModel>,
            title: date['title'] as String,
          ),
        );
      case Routes.faqVeiw:
        return MaterialPageRoute(
          builder: (context) => const FAQView(),
        );
      case Routes.historyPaymentsView:
        return MaterialPageRoute(
          builder: (context) => const PaymentsHistoryView(),
        );
      case Routes.paymentProccessView:
        return MaterialPageRoute(
          builder: (context) => PaymentProccessedView(
            orderTranslatorModel: settings.arguments as OrderTranslatorModel,
          ),
        );
      case Routes.translatorsFavoritesView:
        return MaterialPageRoute(
          builder: (context) => const TranslatorsFavoritesView(),
        );
      case Routes.thankYouView:
        var data = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => ThankYouView(
            orderCubit: data?['orderCubit'],
            paymentResponseModel: data!['paymentResponseModel'],
          ),
        );
      case Routes.orderTranslatorsView:
        return MaterialPageRoute(
          builder: (context) => const OrdersTranslatorsView(),
        );
      case Routes.supportView:
        return MaterialPageRoute(
          builder: (context) => const SupportView(),
        );
      case Routes.personalInformationView:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                UpdatePersonalInformationCubit(getIt<UpdateUserInfoRepo>()),
            child: PersonalInformationView(
              userProfileModel:
                  arguments['userProfileModel'] as UserProfileModel,
              userProfileCubit:
                  arguments['userProfileCubit'] as UserProfileCubit,
            ),
          ),
        );
      case Routes.imageViewerScreen:
        return MaterialPageRoute(
          builder: (context) => ImageViewerView(
            imageUrl: settings.arguments as String? ?? '',
          ),
        );
      case Routes.resetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ResetPasswordCubit(getIt<ResetPasswordRepo>()),
            child: ResetPasswordView(
              email: settings.arguments as String? ?? '',
            ),
          ),
        );
      default:
        return null;
    }
  }
}
