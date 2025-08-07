part of 'delete_user_cover_image_cubit.dart';

sealed class DeleteUserCoverImageState extends Equatable {
  const DeleteUserCoverImageState();

  @override
  List<Object> get props => [];
}

final class DeleteUserCoverImageInitial extends DeleteUserCoverImageState {}

final class DeleteUserCoverImageLoading extends DeleteUserCoverImageState {}

final class DeleteUserCoverImageSuccess extends DeleteUserCoverImageState {}

final class DeleteUserCoverImageError extends DeleteUserCoverImageState {
  final ApiErrorModel errorModel;
  const DeleteUserCoverImageError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
