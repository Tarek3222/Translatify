import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:translators/features/on_boarding/ui/views/widgets/change_language_widget.dart';

class ChangeLanguageAndThemeRow extends StatelessWidget {
  const ChangeLanguageAndThemeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ChangeLanguageWidget(),
          // Expanded(
          //   child: ChangeThemeSwitch(),
          // ),
        ],
      ),
    );
  }
}
