import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/settings/data/repos/sign_out_and_delete_account_repo.dart';
part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutAndDeleteAccountRepo _signOutAndDeleteAccountRepo;

  SignOutCubit(this._signOutAndDeleteAccountRepo) : super(SignOutInitial());

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await _signOutAndDeleteAccountRepo.signOut();
    result.fold(
        (failure) => emit(
              SignOutError(errorModel: failure),
            ), (suucess) async {
      // delete the token from the local storage
      await deleteToken();
      // delete customer id from shared preference
      await getIt<SharedPrefHelper>().removeData(SharedPrefKeys.kCustomerId);
      emit(
        SignOutSuccess(),
      );
    });
  }

  deleteToken() async {
    await getIt<SharedPrefHelper>().clearAllSecuredData();
  }
}
