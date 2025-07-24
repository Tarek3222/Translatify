import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/utils/app_constants.dart';
import 'package:translator/features/payment/data/data_source/local_data_source/payment_translators_local_data_source.dart';
import 'package:translator/features/payment/data/models/payment_intnet_input_model.dart';
import 'package:translator/features/payment/data/models/payment_response_model.dart';
import 'package:translator/features/payment/repos/check_out_repo.dart';
import 'package:translator/features/translator_profile/data/data_source/local_data_source/order_translators_local_data_source.dart';
import 'package:translator/features/translator_profile/data/models/order_translator_model.dart';

part 'payment_states.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  final CheckOutRepo checkOutRepo;
  PaymentCubit(this.checkOutRepo) : super(PaymentInitial());

  Future<void> makePayment(
      {required PaymentIntentInputModel paymentIntentInput,
      required OrderTranslatorModel orderTranslator,
      required double totalSalary}) async {
    emit(PaymentLoading());
    final result =
        await checkOutRepo.makePayment(paymentIntentInput: paymentIntentInput);
    result.fold(
        (error) => emit(
              PaymentError(
                error.message!,
              ),
            ), (makePaymentSuccess) async {
      await deleteTranslatorFromOrderThenAddAfterEdti(orderTranslator);
      var paymentResponseModel = PaymentResponseModel(
        date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        time: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        totalSalary: totalSalary,
        orderTranslator: orderTranslator,
      );
      await addOrderToPaymnets(paymentResponseModel);
      emit(
        PaymentSuccess(
          paymentResponseModel: paymentResponseModel,
        ),
      );
    });
  }

  Future<void> deleteTranslatorFromOrderThenAddAfterEdti(
      OrderTranslatorModel orderTranslator) async {
    await OrderTranslatorsLocalDataSource.deleteTranslatorFromOrders(
        SharedPrefKeys.kOrderListForUser,
        orderTranslator.translatorProfileModel.translator!.first.id!);
    orderTranslator.isPaid = true;
    await OrderTranslatorsLocalDataSource.addTranslatorToOrder(
        SharedPrefKeys.kOrderListForUser, orderTranslator);
  }

  Future<void> addOrderToPaymnets(
      PaymentResponseModel paymentResponseModel) async {
    await PaymentTranslatorsLocalDataSource.addTranslatorsToPayments(
        SharedPrefKeys.kPaymnetsListForUser, paymentResponseModel);
  }
}
