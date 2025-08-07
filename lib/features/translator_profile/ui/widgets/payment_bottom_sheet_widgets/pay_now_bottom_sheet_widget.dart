import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/sign_up/ui/widgets/build_date_of_birth_picker.dart';
import 'package:translators/features/sign_up/ui/widgets/label_form.dart';
import 'package:translators/features/translator_profile/logic/payment_translator_cubit/payment_translator_cubit.dart';
import 'package:translators/features/translator_profile/ui/widgets/payment_bottom_sheet_widgets/build_time_picker_widget.dart';
import 'package:translators/features/translator_profile/ui/widgets/payment_bottom_sheet_widgets/currency_drop_dwon_menu_item.dart';
import 'package:translators/features/translator_profile/ui/widgets/payment_bottom_sheet_widgets/proccessed_button_and_bloc_consumer.dart';

class PayNowBottomSheetWidget extends StatelessWidget {
  const PayNowBottomSheetWidget(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).w,
      child: SingleChildScrollView(
        child: Form(
          key: context.read<PaymentTranslatorCubit>().formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  width: 40.w,
                  height: 5.h,
                  padding: const EdgeInsets.all(10).w,
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                ),
              ),
              verticalSpacing(10),
              const TitleTextWidet(title: "Payment Details"),
              verticalSpacing(20),
              const LabelForm(labelText: "Currency"),
              const CurrencyDropDwonMenuItem(),
              verticalSpacing(10),
              const LabelForm(labelText: "Duration (hours)"),
              AppTextFormField(
                hintText: "Enter Duration in hours",
                keyboardType: TextInputType.number,
                controller:
                    context.read<PaymentTranslatorCubit>().durationController,
                validator: (value) {
                  if (value.isNullOrEmpty()) {
                    return "please Enter the duration";
                  }
                  return null;
                },
              ),
              verticalSpacing(10),
              const LabelForm(labelText: "Scheduled Date & Time"),
              BuildDateOfBirthPicker(
                fromAny: "translator",
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                onDateSelected: (dateSelected) {
                  context.read<PaymentTranslatorCubit>().date =
                      DateFormat('yyyy-MM-dd').format(dateSelected);
                },
                title: "Select Date",
              ),
              Divider(
                height: 10.h,
                color: AppColors.grey,
                thickness: 0.5,
              ),
              BuildTimePickerWidget(
                onTimeSelected: (timeSelected) {
                  context.read<PaymentTranslatorCubit>().time =
                      timeSelected.format(context);
                },
              ),
              verticalSpacing(10),
              const LabelForm(labelText: "Coupon Code (Optional)"),
              AppTextFormField(
                hintText: "Enter Coupon if available",
                controller:
                    context.read<PaymentTranslatorCubit>().couponController,
              ),
              verticalSpacing(10),
              Row(
                children: [
                  const LabelForm(labelText: "Service Type : "),
                  Text(
                    translatorProfileModel.translator!.first.type!.join(" , "),
                  ),
                ],
              ),
              verticalSpacing(15),
              ProccessedButtonAndBlocConsumer(
                translator: translatorProfileModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
