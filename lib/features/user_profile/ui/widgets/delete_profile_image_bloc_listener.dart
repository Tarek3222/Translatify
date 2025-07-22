// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/networking/api_error_model.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/widgets/app_loading_indecator.dart';
import 'package:translator/core/widgets/app_snack_bar.dart';
import 'package:translator/features/user_profile/logic/delete_user_profile_image_cubit/delete_user_profile_image_cubit.dart';

class DeleteProfileImageBlocListener extends StatelessWidget {
  const DeleteProfileImageBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteUserProfileImageCubit,
        DeleteUserProfileImageState>(
      listenWhen: (previous, current) =>
          current is DeleteUserProfileImageError ||
          current is DeleteUserProfileImageSuccess ||
          current is DeleteUserProfileImageLoading,
      listener: (context, state) {
        switch (state.runtimeType) {
          case DeleteUserProfileImageLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case DeleteUserProfileImageSuccess:
            context.pop(); // Dismiss the loading dialog
            showSnackBar(
                context: context,
                message: "Image deleted",
                backgroundColor: AppColors.mainBlue);
            break;
          case DeleteUserProfileImageError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel =
                (state as DeleteUserProfileImageError).errorModel;
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
