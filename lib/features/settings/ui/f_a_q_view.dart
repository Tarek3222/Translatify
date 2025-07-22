// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/core/utils/faq_map.dart';
import 'package:translator/core/widgets/app_text_form_field.dart';
import 'package:translator/core/widgets/custom_app_bar.dart';

class FAQView extends StatefulWidget {
  const FAQView({super.key});

  @override
  State<FAQView> createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> with TickerProviderStateMixin {
  final ValueNotifier<String> _searchQuery = ValueNotifier('');
  final Map<String, bool> _expandedMap = {};

  List<Map<String, String>> get _filteredFAQs {
    if (_searchQuery.value.isEmpty) return faqData;
    return faqData
        .where((faq) =>
            faq['question']!
                .toLowerCase()
                .contains(_searchQuery.value.toLowerCase()) ||
            faq['answer']!
                .toLowerCase()
                .contains(_searchQuery.value.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: "FAQs"),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextFormField(
                hintText: "Search FAQs...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.mainBlue,
                ),
                onChanged: (query) => _searchQuery.value = query,
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: _searchQuery,
                builder: (context, value, _) {
                  final faqs = _filteredFAQs;
                  if (faqs.isEmpty) {
                    return Center(
                      child: Text(
                        'No FAQs Found',
                        style: getSemiBoldStyle(
                          color: theme.colorScheme.secondary,
                          fontSize: 20.sp,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: faqs.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final question = faqs[index]['question']!;
                      final answer = faqs[index]['answer']!;
                      final isExpanded = _expandedMap[question] ?? false;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isExpanded
                              ? AppColors.mainDarkBlue
                              : Colors.grey[850],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            title: Text(
                              question,
                              style: getBoldStyle(
                                color: AppColors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            trailing: AnimatedRotation(
                              turns: isExpanded ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(Icons.expand_more),
                            ),
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _expandedMap[question] = expanded;
                              });
                            },
                            children: [
                              AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: isExpanded
                                    ? Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          answer,
                                          style: getRegularStyle(
                                            color: AppColors.lightGrey,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
