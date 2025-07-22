import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/features/user_profile/data/repo/delete_user_images_repo.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
part 'delete_user_profile_image_state.dart';

class DeleteUserProfileImageCubit extends Cubit<DeleteUserProfileImageState> {
  final DeleteUserImagesRepo deleteUserImagesRepo;
  final UserProfileCubit _userProfileCubit;
  DeleteUserProfileImageCubit(this.deleteUserImagesRepo, this._userProfileCubit)
      : super(DeleteUserProfileImageInitial());

  Future<void> deleteUserProfileImage() async {
    emit(DeleteUserProfileImageLoading());
    final result = await deleteUserImagesRepo.deleteUserProfileImage();
    result.fold(
        (failure) => emit(
              DeleteUserProfileImageError(errorModel: failure),
            ), (suucess) async {
      await _userProfileCubit.getUserProfile(forceRefresh: true);
      emit(
        DeleteUserProfileImageSuccess(),
      );
    });
  }
}
