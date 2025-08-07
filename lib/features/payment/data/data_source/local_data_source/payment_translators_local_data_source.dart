import 'dart:convert';
import 'dart:developer';

import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/features/payment/data/models/payment_response_model.dart';

class PaymentTranslatorsLocalDataSource {
  /// Add Translator to Favorite
  static Future<void> addTranslatorsToPayments(
      String key, PaymentResponseModel paymentResponseModel) async {
    final payments = getPaymentsTranslators(key);
    payments.add(paymentResponseModel);
    final jsonList = payments.map((t) => jsonEncode(t.toJson())).toList();
    log(jsonList.toString());
    await getIt<SharedPrefHelper>().setList(key, jsonList);
  }

  ///  Get All Favorite Translators
  static List<PaymentResponseModel> getPaymentsTranslators(String key) {
    final jsonList = getIt<SharedPrefHelper>().getList(key);
    if (!jsonList.isNullOrEmpty()) {
      return jsonList!
          .map(
            (jsonStr) => PaymentResponseModel.fromJson(
              jsonDecode(jsonStr),
            ),
          )
          .toList();
    } else {
      return [];
    }
  }

  ///  Delete Translator from Favorites
  static Future<void> deleteTranslatorFromPayments(
      String key, String time) async {
    final payments = getPaymentsTranslators(key);

    payments.removeWhere((payment) => payment.time == time);

    final jsonList =
        payments.map((payment) => jsonEncode(payment.toJson())).toList();
    await getIt<SharedPrefHelper>().setList(key, jsonList);
  }

  ///  Clear All Favorites
  static Future<void> clearAll(String key) async {
    await getIt<SharedPrefHelper>().removeData(key);
  }
}
