import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/user_profile/data/repo/upload_user_images_repo.dart';
import 'package:translators/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
part 'upload_user_cover_image_state.dart';

class UploadUserCoverImageCubit extends Cubit<UploadUserCoverImageState> {
  final UploadUserImagesRepo uploadUserImagesRepo;
  final UserProfileCubit _userProfileCubit;
  UploadUserCoverImageCubit(this.uploadUserImagesRepo, this._userProfileCubit)
      : super(UploadUserCoverImageInitial());

  Future<void> uploadUserCoverImage({required File file}) async {
    emit(UploadUserCoverImageLoading());
    final result = await uploadUserImagesRepo.uploadUserCoverImage(file: file);
    result.fold(
        (failure) => emit(
              UploadUserCoverImageError(errorModel: failure),
            ), (suucess) async {
      await _userProfileCubit.getUserProfile(forceRefresh: true);
      emit(
        UploadUserCoverImageSuccess(),
      );
    });
  }
}
