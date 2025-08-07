part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  const ForgetPasswordSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class ForgetPasswordError extends ForgetPasswordState {
  final ApiErrorModel errorModel;
  const ForgetPasswordError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
