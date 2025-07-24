import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/features/translator_profile/logic/payment_translator_cubit/payment_translator_cubit.dart';

class CurrencyDropDwonMenuItem extends StatefulWidget {
  const CurrencyDropDwonMenuItem({super.key});

  @override
  State<CurrencyDropDwonMenuItem> createState() =>
      _CurrencyDropDwonMenuItemState();
}

class _CurrencyDropDwonMenuItemState extends State<CurrencyDropDwonMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.mainBlue,
          width: 0.5,
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: context.read<PaymentTranslatorCubit>().currency,
        items: <String>["EGP", "USD", "EUR"].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          if (!value.isNullOrEmpty()) {
            context.read<PaymentTranslatorCubit>().currency = value!;
            setState(() {});
          }
        },
        underline: const SizedBox(),
        // ignore: deprecated_member_use
        dropdownColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
