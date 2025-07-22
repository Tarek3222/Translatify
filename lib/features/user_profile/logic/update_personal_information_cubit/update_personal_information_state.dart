part of 'update_personal_information_cubit.dart';

sealed class UpdatePersonalInformationState extends Equatable {
  const UpdatePersonalInformationState();

  @override
  List<Object> get props => [];
}

final class UpdatePersonalInformationInitial
    extends UpdatePersonalInformationState {}

final class UpdatePersonalInformationLoading
    extends UpdatePersonalInformationState {}

final class UpdatePersonalInformationSuccess
    extends UpdatePersonalInformationState {}

final class UpdatePersonalInformationError
    extends UpdatePersonalInformationState {
  final ApiErrorModel errorModel;
  const UpdatePersonalInformationError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
