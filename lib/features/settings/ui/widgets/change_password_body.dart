import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/widgets/app_elevated_button.dart';
import 'package:translators/features/settings/logic/change_password_cubit/change_password_cubit.dart';
import 'package:translators/features/settings/ui/widgets/change_password_app_bar.dart';
import 'package:translators/features/settings/ui/widgets/change_password_form.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const ChangePasswordAppBar(),
        const SliverToBoxAdapter(
          child: ChangePasswordForm(),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).w,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AppElevatedButton(
                onPressed: () async {
                  if (context
                      .read<ChangePasswordCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    await context
                        .read<ChangePasswordCubit>()
                        .updateUserInformation();
                  }
                },
                text: "Save",
              ),
            ),
          ),
        )
      ],
    );
  }
}
