import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/sign_up/data/models/confirm_email_request_body.dart';
import 'package:translators/features/sign_up/data/repos/sign_up_repo.dart';
part 'confirm_email_state.dart';

class ConfirmEmailCubit extends Cubit<ConfirmEmailState> {
  final SignUpRepo signupRepo;
  ConfirmEmailCubit(this.signupRepo) : super(ConfirmEmailInitial());
  String email = '';
  String code = '';

  Future<void> confirmEmail() async {
    ConfirmEmailRequestBody confirmEmailRequestBody = ConfirmEmailRequestBody(
      email: email.trim(),
      code: code.trim(),
    );
    emit(ConfirmEmailLoading());
    final result = await signupRepo.confirmEmail(confirmEmailRequestBody);
    result.fold(
      (failure) => emit(
        ConfirmEmailError(errorModel: failure),
      ),
      (confirmEmailSuccess) => emit(
        ConfirmEmailSuccess(
          message: confirmEmailSuccess,
        ),
      ),
    );
  }
}
