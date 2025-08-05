import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_styles.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    super.key,
    this.icon,
    this.padding,
  });
  final Widget? icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DropdownButton<String>(
          style: getMediumStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
          icon: icon,
          value: context.locale.languageCode == 'en'
              ? context.tr("English")
              : context.locale.languageCode == 'ar'
                  ? context.tr("Arabic")
                  : context.locale.languageCode == 'fr'
                      ? context.tr("French")
                      : context.locale.languageCode == 'es'
                          ? context.tr("Spanish")
                          : context.locale.languageCode == 'de'
                              ? context.tr("German")
                              : context.tr("English"),
          items: <String>[
            context.tr("English"),
            context.tr("Arabic"),
            context.tr("French"),
            context.tr("Spanish"),
            context.tr("German"),
            context.tr("Chinese"),
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null && newValue.isNotEmpty) {
              context.setLocale(
                Locale(
                  newValue == context.tr("English")
                      ? 'en'
                      : newValue == context.tr("Arabic")
                          ? 'ar'
                          : newValue == context.tr("French")
                              ? 'fr'
                              : newValue == context.tr("Spanish")
                                  ? 'es'
                                  : newValue == context.tr("German")
                                      ? 'de'
                                      : newValue == context.tr("Chinese")
                                          ? 'zh'
                                          : 'en',
                ),
              );
            }
          },
          underline: const SizedBox(),
          // ignore: deprecated_member_use
          dropdownColor: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
