part of 'sign_out_cubit.dart';

sealed class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object> get props => [];
}

final class SignOutInitial extends SignOutState {}

final class SignOutLoading extends SignOutState {}

final class SignOutSuccess extends SignOutState {}

final class SignOutError extends SignOutState {
  final ApiErrorModel errorModel;
  const SignOutError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
