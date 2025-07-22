// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/widgets/app_loading_indecator.dart';
import 'package:translator/core/widgets/app_snack_bar.dart';
import 'package:translator/features/user_profile/logic/upload_user_cover_image_cubit/upload_user_cover_image_cubit.dart';

class UploadCoverImageBlocListener extends StatelessWidget {
  const UploadCoverImageBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadUserCoverImageCubit, UploadUserCoverImageState>(
      listenWhen: (previous, current) =>
          current is UploadUserCoverImageError ||
          current is UploadUserCoverImageSuccess ||
          current is UploadUserCoverImageLoading,
      listener: (context, state) {
        switch (state.runtimeType) {
          case UploadUserCoverImageLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case UploadUserCoverImageSuccess:
            context.pop(); // Dismiss the loading dialog
            showSnackBar(
                context: context,
                message: "Image Uploadd",
                backgroundColor: AppColors.mainBlue);
            break;
          case UploadUserCoverImageError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel =
                (state as UploadUserCoverImageError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    showSnackBar(context: context, message: apiErrorModel.getAllMessages());
  }
}
