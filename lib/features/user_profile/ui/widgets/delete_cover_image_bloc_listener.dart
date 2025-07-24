// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/user_profile/logic/delete_user_cover_image_cubit/delete_user_cover_image_cubit.dart';

class DeleteCoverImageBlocListener extends StatelessWidget {
  const DeleteCoverImageBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteUserCoverImageCubit, DeleteUserCoverImageState>(
      listenWhen: (previous, current) =>
          current is DeleteUserCoverImageError ||
          current is DeleteUserCoverImageSuccess ||
          current is DeleteUserCoverImageLoading,
      listener: (context, state) {
        switch (state.runtimeType) {
          case DeleteUserCoverImageLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case DeleteUserCoverImageSuccess:
            context.pop(); // Dismiss the loading dialog
            showSnackBar(
                context: context,
                message: "Image deleted",
                backgroundColor: AppColors.mainBlue);
            break;
          case DeleteUserCoverImageError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel =
                (state as DeleteUserCoverImageError).errorModel;
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
