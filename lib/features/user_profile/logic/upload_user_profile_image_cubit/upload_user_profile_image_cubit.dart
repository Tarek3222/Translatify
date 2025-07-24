import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/user_profile/data/repo/upload_user_images_repo.dart';
import 'package:translators/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
part 'upload_user_profile_image_state.dart';

class UploadUserProfileImageCubit extends Cubit<UploadUserProfileImageState> {
  final UploadUserImagesRepo uploadUserImagesRepo;
  final UserProfileCubit _userProfileCubit;
  UploadUserProfileImageCubit(this.uploadUserImagesRepo, this._userProfileCubit)
      : super(UploadUserProfileImageInitial());

  Future<void> uploadUserProfileImage({required File file}) async {
    emit(UploadUserProfileImageLoading());
    final result =
        await uploadUserImagesRepo.uploadUserProfileImage(file: file);
    result.fold(
        (failure) => emit(
              UploadUserProfileImageError(errorModel: failure),
            ), (suucess) async {
      await _userProfileCubit.getUserProfile(forceRefresh: true);
      emit(
        UploadUserProfileImageSuccess(),
      );
    });
  }
}
