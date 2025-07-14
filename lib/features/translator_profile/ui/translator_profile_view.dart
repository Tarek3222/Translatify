import 'package:flutter/material.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_profile_body.dart';

class TranslatorProfileView extends StatelessWidget {
  const TranslatorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: TranslatorProfileBody(),
      ),
    );
  }
}
