import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/features/sign_up/logic/sign_up_cubit/sign_up_cubit.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value!;
          context.read<SignupCubit>().isTermsAccepted = value;
        });
      },
      fillColor:
          WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      checkColor: AppColors.mainBlue,
      side: const BorderSide(
        color: AppColors.mainBlue,
      ),
      activeColor: AppColors.mainBlue,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      // This will make the checkbox smaller
      // and more compact.
    );
  }
}
