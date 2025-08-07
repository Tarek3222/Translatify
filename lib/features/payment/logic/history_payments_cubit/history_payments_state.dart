part of 'history_payments_cubit.dart';

sealed class HistoryPaymentsState extends Equatable {
  const HistoryPaymentsState();

  @override
  List<Object> get props => [];
}

final class HistoryPaymentsInitial extends HistoryPaymentsState {}

final class HistoryPaymentsLoadingClearAll extends HistoryPaymentsState {}

final class HistoryPaymentsLoadingDeleteTranslator
    extends HistoryPaymentsState {}

final class HistoryPaymentsSuccess extends HistoryPaymentsState {
  final List<PaymentResponseModel> paymentTranslatorsList;

  const HistoryPaymentsSuccess({required this.paymentTranslatorsList});

  @override
  List<Object> get props => [paymentTranslatorsList];
}

final class HistoryPaymentsEmptyList extends HistoryPaymentsState {}
