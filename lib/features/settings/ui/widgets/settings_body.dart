import 'package:flutter/material.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';
import 'package:translators/features/settings/ui/widgets/settings_tile_tabs.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppBar(title: "Settings"),
        SettingsTileTabs(),
      ],
    );
  }
}
