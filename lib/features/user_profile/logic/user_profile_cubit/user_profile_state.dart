part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileSuccess extends UserProfileState {
  final UserProfileModel userProfileModel;
  const UserProfileSuccess({required this.userProfileModel});
  @override
  List<Object> get props => [userProfileModel];
}

final class UserProfileError extends UserProfileState {
  final ApiErrorModel errorModel;
  const UserProfileError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
