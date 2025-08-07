import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/settings/data/repos/sign_out_and_delete_account_repo.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final SignOutAndDeleteAccountRepo _signOutAndDeleteAccountRepo;

  DeleteAccountCubit(this._signOutAndDeleteAccountRepo)
      : super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    final result = await _signOutAndDeleteAccountRepo.deleteAccount();
    result.fold(
        (failure) => emit(
              DeleteAccountError(errorModel: failure),
            ), (suucess) async {
      // delete the token from the local storage
      await deleteToken();
      // delete customer id from shared preference
      await getIt<SharedPrefHelper>().removeData(SharedPrefKeys.kCustomerId);
      emit(
        DeleteAccountSuccess(),
      );
    });
  }

  deleteToken() async {
    await getIt<SharedPrefHelper>().clearAllSecuredData();
  }
}
