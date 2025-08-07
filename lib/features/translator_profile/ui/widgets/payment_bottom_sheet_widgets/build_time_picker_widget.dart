// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

class BuildTimePickerWidget extends StatefulWidget {
  const BuildTimePickerWidget({
    super.key,
    required this.onTimeSelected,
    this.initialTime,
    this.title,
  });

  final void Function(TimeOfDay) onTimeSelected;
  final String? initialTime;
  final String? title;

  @override
  State<BuildTimePickerWidget> createState() => _BuildTimePickerWidgetState();
}

class _BuildTimePickerWidgetState extends State<BuildTimePickerWidget> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.initialTime != null) {
      final parsedTime = TimeOfDay(
        hour: int.parse(widget.initialTime!.split(":")[0]),
        minute: int.parse(widget.initialTime!.split(":")[1]),
      );
      _selectedTime = parsedTime;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      helpText: widget.title ?? 'Select Time'.tr(),
      cancelText: 'Cancel'.tr(),
      confirmText: 'Confirm'.tr(),
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
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        // Convert to DateTime using today's date
        widget.onTimeSelected(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeText = _selectedTime == null
        ? widget.title ?? 'Select Time'.tr()
        : _selectedTime!.format(context); // formatted time like 3:45 PM
    return GestureDetector(
      onTap: () => _selectTime(context),
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
              timeText,
              style: getMediumStyle(
                fontSize: 16.sp,
                color: AppColors.white,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.access_time,
              color: AppColors.white,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
