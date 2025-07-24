// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';

class BuildDateOfBirthPicker extends StatefulWidget {
  const BuildDateOfBirthPicker({
    super.key,
    required this.onDateSelected,
    this.initialDate,
    this.title,
    this.firstDate,
    this.lastDate,
    required this.fromAny,
  });
  final void Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  final String? title;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String fromAny;

  @override
  State<BuildDateOfBirthPicker> createState() => _BuildDateOfBirthPickerState();
}

class _BuildDateOfBirthPickerState extends State<BuildDateOfBirthPicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDate = widget.initialDate;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.fromAny == "translator"
          ? widget.initialDate ?? DateTime.now()
          : widget.initialDate ?? DateTime(2000, 1, 1),
      helpText: widget.title ?? 'selectDOB'.tr(),
      cancelText: 'Cancel'.tr(),
      confirmText: 'Confirm'.tr(),
      fieldLabelText: widget.title ?? 'dateOfBirth'.tr(),
      errorFormatText: 'Invalid date format'.tr(),
      errorInvalidText: 'Date is out of range'.tr(),
      locale: context.locale,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.mainBlue,
            colorScheme: const ColorScheme.light(primary: AppColors.mainBlue),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ??
          DateTime.now().subtract(const Duration(days: 365 * 5)),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String dobText = _selectedDate == null
        ? widget.title ?? 'selectDOB'.tr()
        : DateFormat('yyyy-MM-dd').format(_selectedDate!);
    return GestureDetector(
      onTap: () => _selectDate(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14).w,
        decoration: BoxDecoration(
          color: AppColors.mainBlue,
          borderRadius: BorderRadius.circular(12).r,
        ),
        child: Row(
          children: [
            Text(
              dobText,
              style: getMediumStyle(
                fontSize: 16.sp,
                color: AppColors.white,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.calendar_today_outlined,
              color: AppColors.white,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
