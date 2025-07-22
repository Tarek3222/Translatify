import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/features/home/data/models/translator_response_model.dart';
import 'package:translator/features/home/ui/widgets/translator_filtered_item.dart';

class TranslatorsFilteredListView extends StatelessWidget {
  const TranslatorsFilteredListView({super.key, required this.translatorsList});
  final List<TranslatorProfileModel> translatorsList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => TranslatorFilteredItem(
          translator: translatorsList[index],
        ),
        itemCount: translatorsList.length,
      ),
    );
  }
}
