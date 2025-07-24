import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/sign_up/data/repos/sign_up_repo.dart';
part 'resend_confirm_email_state.dart';

class ResendConfirmEmailCubit extends Cubit<ResendConfirmEmailState> {
  final SignUpRepo signupRepo;
  ResendConfirmEmailCubit(this.signupRepo) : super(ResendConfirmEmailInitial());

  Future<void> resendConfirmEmail(String email) async {
    emit(ResendConfirmEmailLoading());
    final result = await signupRepo.resendConfirmEmail(email);
    result.fold(
      (failure) => emit(
        ResendConfirmEmailError(errorModel: failure),
      ),
      (success) => emit(
        ResendConfirmEmailSuccess(
          message: success,
        ),
      ),
    );
  }
}
