part of 'upload_user_cover_image_cubit.dart';

sealed class UploadUserCoverImageState extends Equatable {
  const UploadUserCoverImageState();

  @override
  List<Object> get props => [];
}

final class UploadUserCoverImageInitial extends UploadUserCoverImageState {}

final class UploadUserCoverImageLoading extends UploadUserCoverImageState {}

final class UploadUserCoverImageSuccess extends UploadUserCoverImageState {}

final class UploadUserCoverImageError extends UploadUserCoverImageState {
  final ApiErrorModel errorModel;
  const UploadUserCoverImageError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
