// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/utils/faq_map.dart';
import 'package:translators/core/widgets/app_text_form_field.dart';
import 'package:translators/core/widgets/custom_app_bar.dart';
import 'dart:async';

class FAQView extends StatefulWidget {
  const FAQView({super.key});

  @override
  State<FAQView> createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> with TickerProviderStateMixin {
  final ValueNotifier<String> _searchQuery = ValueNotifier('');
  final Map<String, bool> _expandedMap = {};
  late final AnimationController _searchAnimationController;
  late final AnimationController _listAnimationController;
  late final Animation<double> _searchAnimation;
  late final Animation<double> _listAnimation;

  // Debouncing for search
  Timer? _searchDebounceTimer;
  static const Duration _searchDebounceDuration = Duration(milliseconds: 300);

  // Cache for filtered results
  List<Map<String, String>>? _cachedFilteredFAQs;
  String? _lastSearchQuery;

  // Performance optimizations
  static const double _defaultPadding = 12.0;
  static const double _defaultMargin = 12.0;
  static const double _defaultBorderRadius = 12.0;
  static const Duration _animationDuration = Duration(milliseconds: 250);
  static const Duration _rotationDuration = Duration(milliseconds: 200);
  static const Duration _sizeAnimationDuration = Duration(milliseconds: 300);

  List<Map<String, String>> get _filteredFAQs {
    // Return cached result if search query hasn't changed
    if (_lastSearchQuery == _searchQuery.value && _cachedFilteredFAQs != null) {
      return _cachedFilteredFAQs!;
    }

    final query = _searchQuery.value.toLowerCase().trim();
    List<Map<String, String>> result;

    if (query.isEmpty) {
      result = faqData;
    } else {
      result = faqData.where((faq) {
        final question = faq['question']?.toLowerCase() ?? '';
        final answer = faq['answer']?.toLowerCase() ?? '';
        return question.contains(query) || answer.contains(query);
      }).toList();
    }

    // Cache the result
    _cachedFilteredFAQs = result;
    _lastSearchQuery = _searchQuery.value;

    return result;
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _searchAnimation = CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
    );
    _listAnimation = CurvedAnimation(
      parent: _listAnimationController,
      curve: Curves.easeOutCubic,
    );

    // Start list animation
    _listAnimationController.forward();
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    _searchAnimationController.dispose();
    _listAnimationController.dispose();
    _searchDebounceTimer?.cancel();
    _clearCache();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    _searchDebounceTimer?.cancel();

    // Set new timer for debouncing
    _searchDebounceTimer = Timer(_searchDebounceDuration, () {
      _searchQuery.value = query;
      // Trigger list animation on search
      _listAnimationController.reset();
      _listAnimationController.forward();
    });
  }

  void _toggleExpansion(String question) {
    setState(() {
      _expandedMap[question] = !(_expandedMap[question] ?? false);
    });
  }

  void _clearCache() {
    _cachedFilteredFAQs = null;
    _lastSearchQuery = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: "FAQs"),
            _buildSearchSection(),
            Expanded(
              child: _buildFAQList(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return AnimatedBuilder(
      animation: _searchAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (_searchAnimation.value * 0.05),
          child: Padding(
            padding: const EdgeInsets.all(_defaultPadding),
            child: AppTextFormField(
              hintText: "Search FAQs...",
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.mainBlue,
              ),
              onChanged: _onSearchChanged,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFAQList(ThemeData theme) {
    return ValueListenableBuilder<String>(
      valueListenable: _searchQuery,
      builder: (context, value, _) {
        final faqs = _filteredFAQs;

        if (faqs.isEmpty) {
          return _buildEmptyState(theme);
        }

        return AnimatedBuilder(
          animation: _listAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - _listAnimation.value)),
              child: Opacity(
                opacity: _listAnimation.value,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: faqs.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (context, index) => _buildFAQItem(
                    faqs[index],
                    theme,
                    index,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.sp,
            color: theme.colorScheme.secondary.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'No FAQs Found',
            style: AppTextStyles.titleMedium.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search terms',
            style: AppTextStyles.bodyMedium.copyWith(
              color: theme.colorScheme.secondary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(Map<String, String> faq, ThemeData theme, int index) {
    final question = faq['question']!;
    final answer = faq['answer']!;
    final isExpanded = _expandedMap[question] ?? false;

    return AnimatedContainer(
      duration: _animationDuration,
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: _defaultMargin.w),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: isExpanded
            ? theme.colorScheme.primary.withOpacity(0.1)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
        border: Border.all(
          color: isExpanded
              ? theme.colorScheme.primary.withOpacity(0.3)
              : theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(_defaultBorderRadius),
          onTap: () => _toggleExpansion(question),
          splashColor: theme.colorScheme.primary.withOpacity(0.1),
          highlightColor: theme.colorScheme.primary.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        question,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: isExpanded
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: _rotationDuration,
                      child: Icon(
                        Icons.expand_more,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  SizedBox(height: 12.h),
                  AnimatedSize(
                    duration: _sizeAnimationDuration,
                    curve: Curves.easeInOut,
                    child: Text(
                      answer,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: theme.colorScheme.secondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Performance optimization extension
// ignore: library_private_types_in_public_api
extension FAQViewPerformance on _FAQViewState {
  // ignore: unused_element
  void _optimizeMemory() {
    // Clear expansion map if too large
    if (_expandedMap.length > 50) {
      _expandedMap.clear();
    }
  }
}
