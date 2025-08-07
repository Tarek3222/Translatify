import 'package:flutter/material.dart';
import 'package:translators/features/settings/ui/widgets/settings_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SettingsBody(),
      ),
    );
  }
}
