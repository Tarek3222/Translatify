import 'package:flutter/material.dart';
import 'package:translator/core/routing/app_router.dart';
import 'package:translator/translators_app.dart';

void main() {
  runApp(
    TranslatorsApp(
      appRouter: AppRouter(),
    ),
  );
}
