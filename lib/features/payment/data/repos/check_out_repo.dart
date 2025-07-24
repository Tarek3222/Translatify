import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/networking/network_info.dart';
import 'package:translators/features/payment/data/data_source/remote_data_source/stripe_service.dart';
import 'package:translators/features/payment/data/models/payment_intnet_input_model.dart';

class CheckOutRepo {
  final StripeService stripeService = StripeService();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();
  Future<Either<ApiErrorModel, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInput}) async {
    if (await networkInfo.isConnected) {
      try {
        await stripeService.makePayment(paymentIntentInput: paymentIntentInput);
        return const Right(null);
      } on StripeException catch (e) {
        return Left(
          ApiErrorModel(
            message: e.error.message ?? "Something went wrong",
          ),
        );
      } catch (e) {
        return Left(
          ApiErrorModel(
            message: e.toString(),
          ),
        );
      }
    } else {
      return const Left(ApiErrorModel(message: "No internet connection"));
    }
  }
}
