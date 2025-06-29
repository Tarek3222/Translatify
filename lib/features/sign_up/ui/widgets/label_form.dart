import 'package:flutter/material.dart';
import 'package:translator/core/theme/app_styles.dart';

class LabelForm extends StatelessWidget {
  final String labelText;
  const LabelForm({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: getMediumStyle(
        fontSize: 17,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
