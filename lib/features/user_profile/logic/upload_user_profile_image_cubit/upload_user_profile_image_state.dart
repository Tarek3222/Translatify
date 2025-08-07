part of 'upload_user_profile_image_cubit.dart';

sealed class UploadUserProfileImageState extends Equatable {
  const UploadUserProfileImageState();

  @override
  List<Object> get props => [];
}

final class UploadUserProfileImageInitial extends UploadUserProfileImageState {}

final class UploadUserProfileImageLoading extends UploadUserProfileImageState {}

final class UploadUserProfileImageSuccess extends UploadUserProfileImageState {}

final class UploadUserProfileImageError extends UploadUserProfileImageState {
  final ApiErrorModel errorModel;
  const UploadUserProfileImageError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
