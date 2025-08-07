import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/features/translator_profile/data/data_source/local_data_source/order_translators_local_data_source.dart';
import 'package:translators/features/translator_profile/data/models/order_translator_model.dart';
part 'orders_translators_state.dart';

class OrdersTranslatorsCubit extends Cubit<OrdersTranslatorsState> {
  OrdersTranslatorsCubit() : super(OrdersTranslatorsInitial());

  void getTranslatorsFromOrders(String key) {
    final translatorsList =
        OrderTranslatorsLocalDataSource.getOrdersTranslators(key);
    if (translatorsList.isEmpty) {
      emit(OrdersTranslatorsEmptyList());
    } else {
      emit(OrdersTranslatorsSuccess(translatorsList: translatorsList));
    }
  }

  Future<void> clearAllTranslators(String key) async {
    emit(OrdersTranslatorsLoadingClearAll());
    await OrderTranslatorsLocalDataSource.clearAll(key);
    getTranslatorsFromOrders(key);
  }

  Future<void> deleteTranslators(String key, String translatorId) async {
    await OrderTranslatorsLocalDataSource.deleteTranslatorFromOrders(
        key, translatorId);
    getTranslatorsFromOrders(key);
  }
}
