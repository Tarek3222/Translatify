import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/shared_preference_helper.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/features/settings/data/repos/sign_out_and_delete_account_repo.dart';
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
      emit(
        DeleteAccountSuccess(),
      );
    });
  }

  deleteToken() async {
    await getIt<SharedPrefHelper>().clearAllSecuredData();
  }
}
