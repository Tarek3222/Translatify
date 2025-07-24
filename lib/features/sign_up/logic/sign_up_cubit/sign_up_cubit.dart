import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:translators/features/sign_up/data/repos/sign_up_repo.dart';
part 'sign_up_states.dart';

class SignupCubit extends Cubit<SignUpState> {
  final SignUpRepo signupRepo;
  SignupCubit(this.signupRepo) : super(SignupInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime? dateOfBirth;
  bool isTermsAccepted = false;
  String gender = 'male';

  var formKey = GlobalKey<FormState>();

  Future<void> signup() async {
    SignUpRequestBody signup = SignUpRequestBody(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      mobileNumber: phoneController.text.trim(),
      confirmPassword: passwordController.text,
      gender: gender.trim(),
      dateOfBirth: DateFormat('yyyy-MM-dd').format(dateOfBirth!),
    );
    emit(SignupLoading());
    final result = await signupRepo.sigUpUser(signup);
    result.fold(
      (failure) => emit(
        SignupError(errorModel: failure),
      ),
      (signUpSuccess) => emit(
        SignupSuccess(
          message: signUpSuccess,
        ),
      ),
    );
  }
}
