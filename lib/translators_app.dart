import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/routing/app_router.dart';
import 'package:translator/core/routing/routes.dart';
import 'package:translator/features/settings/logic/cubit/change_theme_state.dart';

import 'features/settings/logic/cubit/change_theme_cubit.dart';

class TranslatorsApp extends StatelessWidget {
  const TranslatorsApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocBuilder<ChangeThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            theme: state.themeData,
            locale: context.locale,
            title: 'Translators App',
            initialRoute: Routes.onBoardingScreen,
          );
        },
      ),
    );
  }
}
