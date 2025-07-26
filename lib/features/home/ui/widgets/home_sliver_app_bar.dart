// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translators/features/home/ui/widgets/welcome_text_bloc_builder.dart';
import 'package:translators/features/main/ui/widgets/image_user_bloc_builder.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      pinned: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      expandedHeight: 50.h,
      title: buildSliverAppBarTitle(),
      actions: [
        InkWell(
          onTap: () {
            context.pushNamed(Routes.recommendedTranslatorsView, arguments: {
              'title': 'Search Translators'.tr(),
              'translatorsList':
                  context.read<GetTranslatorsListCubit>().translatorsList,
            });
          },
          child: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: Theme.of(context).colorScheme.secondary,
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget buildSliverAppBarTitle() {
    return Row(
      children: [
        const ImageUserBlocBuilder(radius: 30),
        horizontalSpacing(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeTextBlocBuilder(),
            verticalSpacing(5),
            Text(
              "How are you today?".tr(),
              style: getRegularStyle(
                color: AppColors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
