import 'package:flutter/material.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';

class SearchLanguageTextField extends StatelessWidget {
  const SearchLanguageTextField({super.key, required this.onChanged});
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      onChanged: onChanged,
      hintText: "Search language",
      labelText: 'Search language',
      prefixIcon: const Icon(
        Icons.search,
        color: AppColors.mainBlue,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.mainBlue),
      ),
    );
  }
}
