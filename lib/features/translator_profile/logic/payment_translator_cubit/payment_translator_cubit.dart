import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/translator_profile/data/data_source/local_data_source/order_translators_local_data_source.dart';
import 'package:translator/features/translator_profile/data/models/order_translator_model.dart';
part 'payment_translator_state.dart';

class PaymentTranslatorCubit extends Cubit<PaymentTranslatorState> {
  PaymentTranslatorCubit() : super(PaymentTranslatorInitial());
  String currency = 'EGP';
  TextEditingController durationController = TextEditingController();
  String? date;
  String? time;
  TextEditingController couponController = TextEditingController();
  double? salary;
  var formKey = GlobalKey<FormState>();
  Future<void> addTranslatorToOrder(
      {required String key, required TranslatorProfileModel translator}) async {
    emit(PaymentTranslatorLoading());
    bool isTranslatorInOrder =
        OrderTranslatorsLocalDataSource.isTranslatorInOrders(
            key, translator.translator!.first.id!);
    if (isTranslatorInOrder) {
      emit(
        const PaymentTranslatorError(errorMessage: "You Already pay an order"),
      );
    } else {
      int durationHours = int.parse(durationController.text.trim());
      var ratingFactor =
          (translator.translator!.first.averageRating! - 3) * 0.05;
      if (ratingFactor < 0) ratingFactor = 0;
      // todo: edit salary
      salary = durationHours * (1 + ratingFactor) * 1200;
      var orderTranslatorModel = OrderTranslatorModel(
          translatorProfileModel: translator,
          currency: currency,
          durationInHours: int.parse(durationController.text.trim()),
          date: date!,
          time: time!,
          coupon: couponController.text.trim(),
          salary: salary!);
      await OrderTranslatorsLocalDataSource.addTranslatorToOrder(
        key,
        orderTranslatorModel,
      );
      emit(
          PaymentTranslatorSuccess(orderTranslatorModel: orderTranslatorModel));
    }
  }
}
