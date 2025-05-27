import 'package:flutter/material.dart';
import 'package:translator/core/routing/app_router.dart';
import 'package:translator/core/routing/routes.dart';

class TranslatorsApp extends StatelessWidget {
  const TranslatorsApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      title: 'Translators App',
      initialRoute: Routes.onBoarding,
    );
  }
}
