import 'package:flutter/material.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/translator_profile/ui/widgets/translator_profile_body.dart';

class TranslatorProfileView extends StatelessWidget {
  const TranslatorProfileView(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TranslatorProfileBody(
          translatorProfileModel: translatorProfileModel,
        ),
      ),
    );
  }
}
