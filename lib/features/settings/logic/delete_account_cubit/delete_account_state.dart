part of 'delete_account_cubit.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoading extends DeleteAccountState {}

final class DeleteAccountSuccess extends DeleteAccountState {}

final class DeleteAccountError extends DeleteAccountState {
  final ApiErrorModel errorModel;
  const DeleteAccountError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
