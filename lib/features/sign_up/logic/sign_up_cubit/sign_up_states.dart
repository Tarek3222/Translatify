part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignUpState {}

final class SignupLoading extends SignUpState {}

final class SignupSuccess extends SignUpState {
  final String message;
  const SignupSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class SignupError extends SignUpState {
  final ApiErrorModel errorModel;
  const SignupError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
