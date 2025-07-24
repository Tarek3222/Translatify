// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/settings/data/repos/sign_out_and_delete_account_repo.dart';
import 'package:translators/features/settings/logic/delete_account_cubit/delete_account_cubit.dart';
import 'package:translators/features/settings/ui/widgets/delete_account_bloc_listener.dart';
import 'package:translators/features/user_profile/ui/widgets/list_tile_tabs_profile_and_settings.dart';

class DeleteAccountTileAndBlocListener extends StatelessWidget {
  const DeleteAccountTileAndBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeleteAccountCubit(getIt<SignOutAndDeleteAccountRepo>()),
      child: Builder(builder: (context) {
        return Column(
          children: [
            ListTileTabsProfileAndSettings(
              title: "Delete Account",
              icon: Icons.delete_outlined,
              onTap: () {
                buildDialogForDeleteAccount(context);
              },
              color: AppColors.mainRed,
            ),
            const DeleteAccountBlocListener(),
          ],
        );
      }),
    );
  }

  void buildDialogForDeleteAccount(BuildContext context) {
    final parentContext = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const TitleTextWidet(
            title: "Delete Account",
            fontSize: 20,
          ),
          content: Text(
            "Are you sure you want to delete your account?",
            style: getMediumStyle(
              fontSize: 16,
              color: AppColors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text("Cancel",
                  style: getSemiBoldStyle(
                    fontSize: 16,
                    color: AppColors.mainRed,
                  )),
            ),
            TextButton(
              onPressed: () async {
                context.pop();
                await parentContext.read<DeleteAccountCubit>().deleteAccount();
              },
              child: Text(
                "Delete",
                style: getSemiBoldStyle(
                  fontSize: 16,
                  color: AppColors.mainBlue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
