import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/payment/data/data_source/remote_data_source/stripe_service.dart';

class CreateCustomerRepo {
  StripeService stripeService = StripeService();

  Future<Either<ApiErrorModel, void>> createCustomer() async {
    try {
      String customerId = await stripeService.createCustomer();
      await getIt<SharedPrefHelper>()
          .setData(SharedPrefKeys.kCustomerId, customerId);
      log(customerId);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiErrorModel(
          message: e.toString(),
        ),
      );
    }
  }
}
