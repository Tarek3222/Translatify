import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/features/user_profile/data/repo/delete_user_images_repo.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
part 'delete_user_cover_image_state.dart';

class DeleteUserCoverImageCubit extends Cubit<DeleteUserCoverImageState> {
  final DeleteUserImagesRepo deleteUserImagesRepo;
  final UserProfileCubit _userProfileCubit;
  DeleteUserCoverImageCubit(this.deleteUserImagesRepo, this._userProfileCubit)
      : super(DeleteUserCoverImageInitial());

  Future<void> deleteUserCoverImage() async {
    emit(DeleteUserCoverImageLoading());
    final result = await deleteUserImagesRepo.deleteUserCoverImage();
    result.fold(
        (failure) => emit(
              DeleteUserCoverImageError(errorModel: failure),
            ), (suucess) async {
      await _userProfileCubit.getUserProfile(forceRefresh: true);
      emit(
        DeleteUserCoverImageSuccess(),
      );
    });
  }
}
