part of 'resend_confirm_email_cubit.dart';

sealed class ResendConfirmEmailState extends Equatable {
  const ResendConfirmEmailState();

  @override
  List<Object> get props => [];
}

final class ResendConfirmEmailInitial extends ResendConfirmEmailState {}

final class ResendConfirmEmailLoading extends ResendConfirmEmailState {}

final class ResendConfirmEmailSuccess extends ResendConfirmEmailState {
  final String message;
  const ResendConfirmEmailSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class ResendConfirmEmailError extends ResendConfirmEmailState {
  final ApiErrorModel errorModel;
  const ResendConfirmEmailError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
