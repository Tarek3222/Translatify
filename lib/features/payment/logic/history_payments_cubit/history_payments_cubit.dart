import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/features/payment/data/data_source/local_data_source/payment_translators_local_data_source.dart';
import 'package:translator/features/payment/data/models/payment_response_model.dart';
import 'package:translator/features/translator_profile/data/data_source/local_data_source/order_translators_local_data_source.dart';
part 'history_payments_state.dart';

class HistoryPaymentsCubit extends Cubit<HistoryPaymentsState> {
  HistoryPaymentsCubit() : super(HistoryPaymentsInitial());

  void getTranslatorsFromPayments(String key) {
    final paymentTranslatorsList =
        PaymentTranslatorsLocalDataSource.getPaymentsTranslators(key);
    if (paymentTranslatorsList.isEmpty) {
      emit(HistoryPaymentsEmptyList());
    } else {
      emit(HistoryPaymentsSuccess(
          paymentTranslatorsList: paymentTranslatorsList));
    }
  }

  Future<void> clearAllPaymentsTranslators(String key) async {
    emit(HistoryPaymentsLoadingClearAll());
    await OrderTranslatorsLocalDataSource.clearAll(key);
    getTranslatorsFromPayments(key);
  }

  Future<void> deletePaymnetFromHistory(String key, String time) async {
    await PaymentTranslatorsLocalDataSource.deleteTranslatorFromPayments(
        key, time);
    getTranslatorsFromPayments(key);
  }
}
