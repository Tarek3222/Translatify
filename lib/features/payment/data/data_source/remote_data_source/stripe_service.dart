import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:translators/core/utils/api_keys.dart';
import 'package:translators/features/payment/data/data_source/remote_data_source/stripe_api_services.dart';
import 'package:translators/features/payment/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:translators/features/payment/data/models/init_payment_sheet_input_model.dart';
import 'package:translators/features/payment/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:translators/features/payment/data/models/payment_intnet_input_model.dart';

class StripeService {
  final StripeApiServices _apiService = StripeApiServices();
  //for create customer to get the Customer id
  Future<String> createCustomer() async {
    var response = await _apiService.post(
      body: null,
      url: 'https://api.stripe.com/v1/customers',
      token: APiKeys.secretKey,
    );
    return response.data['id'];
  }

  // PaymentIntentObject =create payment intent (amount, currency)
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInput) async {
    var response = await _apiService.post(
      body: paymentIntentInput.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: APiKeys.secretKey,
    );
    return PaymentIntentModel.fromJson(response.data);
  }

  // ephemeral key object =Create Ephemeral key for customer(customer id)
  Future<EphemeralKeyModel> createPhemeralKey(
      {required String customerId}) async {
    var response = await _apiService.post(
      body: {'customer': customerId},
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      headers: {
        'Authorization': 'Bearer ${APiKeys.secretKey}',
        'Stripe-Version': '2024-12-18.acacia',
      },
      token: APiKeys.secretKey,
    );
    return EphemeralKeyModel.fromJson(response.data);
  }

// init PaymentSheet (PaymentIntentClientSecret, merchantDisplayName)
  Future<void> initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInput}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret:
            initPaymentSheetInput.paymentIntentClientSecret,
        merchantDisplayName: initPaymentSheetInput.merchantDisplayName,
        customerEphemeralKeySecret: initPaymentSheetInput.ephemeralKeySecret,
        customerId: initPaymentSheetInput.customerId,
      ),
    );
  }

// Present PaymentSheet
  Future<void> dispalyPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  // make Payment
  Future<void> makePayment(
      {required PaymentIntentInputModel paymentIntentInput}) async {
    PaymentIntentModel paymentIntentInputModel =
        await createPaymentIntent(paymentIntentInput);
    EphemeralKeyModel ephemeralKeyModel =
        await createPhemeralKey(customerId: paymentIntentInput.customerId);
    InitPaymentSheetInputModel initPaymentSheetInput =
        InitPaymentSheetInputModel(
      paymentIntentClientSecret: paymentIntentInputModel.clientSecret!,
      merchantDisplayName: 'TranslationHub',
      ephemeralKeySecret: ephemeralKeyModel.secret!,
      customerId: paymentIntentInput.customerId,
    );
    await initPaymentSheet(initPaymentSheetInput: initPaymentSheetInput);
    await dispalyPaymentSheet();
  }
}

// for save card to stripe for the customer
// 1) PaymentIntentModel=Create Payment intent (amount, currency, customer id)
//2)phemeral key secret =Create Ephemeral key for customer(Stripe version,customer id)
// 3)init PaymentSheet (PaymentIntentClientSecret, merchantDisplayName, customer id, ephemeral key secret)
// 4) Present PaymentSheet
