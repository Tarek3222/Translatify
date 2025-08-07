part of 'payment_translator_cubit.dart';

sealed class PaymentTranslatorState extends Equatable {
  const PaymentTranslatorState();

  @override
  List<Object> get props => [];
}

final class PaymentTranslatorInitial extends PaymentTranslatorState {}

final class PaymentTranslatorLoading extends PaymentTranslatorState {}

final class PaymentTranslatorSuccess extends PaymentTranslatorState {
  final OrderTranslatorModel orderTranslatorModel;
  const PaymentTranslatorSuccess({
    required this.orderTranslatorModel,
  });

  @override
  List<Object> get props => [orderTranslatorModel];
}

final class PaymentTranslatorError extends PaymentTranslatorState {
  final String errorMessage;
  const PaymentTranslatorError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
