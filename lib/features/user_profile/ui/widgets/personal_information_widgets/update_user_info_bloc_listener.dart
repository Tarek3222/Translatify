// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/user_profile/logic/update_personal_information_cubit/update_personal_information_cubit.dart';

class UpdateUserInfoBlocListener extends StatelessWidget {
  const UpdateUserInfoBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePersonalInformationCubit,
        UpdatePersonalInformationState>(
      listenWhen: (previous, current) =>
          current is UpdatePersonalInformationLoading ||
          current is UpdatePersonalInformationError ||
          current is UpdatePersonalInformationSuccess,
      listener: (context, state) {
        switch (state.runtimeType) {
          case UpdatePersonalInformationLoading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const AppLoadingIndecator(
                size: 30,
              ),
            );
            break;
          case UpdatePersonalInformationSuccess:
            context.pop(); // Dismiss the loading dialog
            showSnackBar(
                context: context,
                message: "Personal information updated",
                backgroundColor: AppColors.mainBlue);
            break;
          case UpdatePersonalInformationError:
            // Dismiss the loading dialog and show error message
            context.pop();
            final apiErrorModel =
                (state as UpdatePersonalInformationError).errorModel;
            setupErrorState(context, apiErrorModel);
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    if (apiErrorModel.getAllMessages() ==
        "error in global middleware handler") {
      context.read<UpdatePersonalInformationCubit>().isChannged = true;
      showSnackBar(
        context: context,
        message: "Personal information updated",
        backgroundColor: AppColors.mainBlue,
      );
    } else {
      showSnackBar(context: context, message: apiErrorModel.getAllMessages());
    }
  }
}
