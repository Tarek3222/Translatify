part of 'payment_cubit.dart';

class PaymentStates extends Equatable {
  const PaymentStates();
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentStates {}

class PaymentLoading extends PaymentStates {}

class PaymentSuccess extends PaymentStates {
  final PaymentResponseModel paymentResponseModel;

  const PaymentSuccess({required this.paymentResponseModel});

  @override
  List<Object?> get props => [paymentResponseModel];
}

class PaymentError extends PaymentStates {
  final String error;

  const PaymentError(this.error);
}
