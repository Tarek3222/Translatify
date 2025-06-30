part of 'confirm_email_cubit.dart';

sealed class ConfirmEmailState extends Equatable {
  const ConfirmEmailState();

  @override
  List<Object> get props => [];
}

final class ConfirmEmailInitial extends ConfirmEmailState {}

final class ConfirmEmailLoading extends ConfirmEmailState {}

final class ConfirmEmailSuccess extends ConfirmEmailState {
  final String message;
  const ConfirmEmailSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class ConfirmEmailError extends ConfirmEmailState {
  final ApiErrorModel errorModel;
  const ConfirmEmailError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
