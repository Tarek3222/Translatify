import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';
import 'package:translators/features/user_profile/data/repo/user_profile_repo.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepo userProfileRepo;
  UserProfileCubit(this.userProfileRepo) : super(UserProfileInitial());

  bool _dataFetched = false;

  Future<void> getUserProfile({bool forceRefresh = false}) async {
    if (_dataFetched && !forceRefresh) return; // ✅ Prevents second API call
    _dataFetched = true;
    emit(UserProfileLoading());
    final result = await userProfileRepo.getUserProfile();
    result.fold(
      (failure) => emit(
        UserProfileError(errorModel: failure),
      ),
      (userProfileModel) => emit(
        UserProfileSuccess(
          userProfileModel: userProfileModel,
        ),
      ),
    );
  }
}
