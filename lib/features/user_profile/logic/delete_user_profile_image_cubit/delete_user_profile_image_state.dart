part of 'delete_user_profile_image_cubit.dart';

sealed class DeleteUserProfileImageState extends Equatable {
  const DeleteUserProfileImageState();

  @override
  List<Object> get props => [];
}

final class DeleteUserProfileImageInitial extends DeleteUserProfileImageState {}

final class DeleteUserProfileImageLoading extends DeleteUserProfileImageState {}

final class DeleteUserProfileImageSuccess extends DeleteUserProfileImageState {}

final class DeleteUserProfileImageError extends DeleteUserProfileImageState {
  final ApiErrorModel errorModel;
  const DeleteUserProfileImageError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
