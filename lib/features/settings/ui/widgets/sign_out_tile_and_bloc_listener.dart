// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/core/helpers/extensions.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/home/ui/widgets/title_text_widet.dart';
import 'package:translator/features/settings/data/repos/sign_out_and_delete_account_repo.dart';
import 'package:translator/features/settings/logic/sign_out_cubit/sign_out_cubit.dart';
import 'package:translator/features/settings/ui/widgets/sign_out_bloc_listener.dart';
import 'package:translator/features/user_profile/ui/widgets/list_tile_tabs_profile_and_settings.dart';

class SignOutTileAndBlocListener extends StatelessWidget {
  const SignOutTileAndBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignOutCubit(getIt<SignOutAndDeleteAccountRepo>()),
      child: Builder(builder: (context) {
        return Column(
          children: [
            ListTileTabsProfileAndSettings(
              title: "Sign Out",
              icon: Icons.logout_outlined,
              onTap: () {
                buildDialogForSignOut(context);
              },
              color: AppColors.mainRed,
            ),
            const SignOutBlocListener(),
          ],
        );
      }),
    );
  }

  void buildDialogForSignOut(BuildContext context) {
    final parentContext = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const TitleTextWidet(
            title: "Sign out",
            fontSize: 20,
          ),
          content: Text(
            "Are you sure you want to logout?",
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
                await parentContext.read<SignOutCubit>().signOut();
              },
              child: Text("Sign Out",
                  style: getSemiBoldStyle(
                    fontSize: 16,
                    color: AppColors.mainBlue,
                  )),
            ),
          ],
        );
      },
    );
  }
}
