// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/user_profile/logic/upload_user_profile_image_cubit/upload_user_profile_image_cubit.dart';

class UploadProfileImageBlocListener extends StatelessWidget {
  const UploadProfileImageBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadUserProfileImageCubit,
        UploadUserProfileImageState>(
      listenWhen: (previous, current) =>
          current is UploadUserProfileImageError ||
          current is UploadUserProfileImageSuccess ||
          current is UploadUserProfileImageLoading,
      listener: (context, state) {
        switch (state.runtimeType) {
          case UploadUserProfileImageLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case UploadUserProfileImageSuccess:
            context.pop(); // Dismiss the loading dialog
            AppSnackBar.showSuccess(
              context: context,
              message: "Image uploaded",
            );
            break;
          case UploadUserProfileImageError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel =
                (state as UploadUserProfileImageError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    AppSnackBar.showError(
        context: context, message: apiErrorModel.getAllMessages());
  }
}
