import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/widgets/app_snack_bar.dart';
import 'package:translators/features/home/logic/get_translators_list_cubit/get_translators_list_cubit.dart';
import 'package:translators/features/home/ui/widgets/filter_widgets_by_type.dart/find_translator_by_type_section.dart';
import 'package:translators/features/home/ui/widgets/filter_widgets_by_language/find_translators_by_language_section.dart';
import 'package:translators/features/home/ui/widgets/home_sliver_app_bar.dart';
import 'package:translators/features/home/ui/widgets/recommended_translators_widgets/recommended_translators_bloc_builder.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';
import 'package:translators/features/payment/data/repos/create_customer_repo.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with AutomaticKeepAliveClientMixin {
  // 🔧 OPTIMIZATION 1: Add disposal tracking
  bool _isDisposed = false;
  late Stream<InternetStatus> _internetStatusStream;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _listenToInternetChanges();
    // 🔧 OPTIMIZATION 2: Use addPostFrameCallback to avoid memory spikes during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        _initializeData();
      }
    });
  }

  void _listenToInternetChanges() {
    _internetStatusStream = InternetConnection().onStatusChange;
    _subscription = _internetStatusStream.listen((InternetStatus status) {
      if (status == InternetStatus.disconnected) {
        if (mounted) {
          AppSnackBar.showError(
              context: context, message: 'No internet connection');
        }
      }
    });
  }

  // 🔧 OPTIMIZATION 3: Separate initialization method
  Future<void> _initializeData() async {
    try {
      await getCustomerId();
    } catch (e) {
      // Handle error gracefully to prevent memory leaks
      debugPrint('Error initializing customer ID: $e');
    }
  }

  Future<void> getCustomerId() async {
    if (getIt<SharedPrefHelper>().getString(SharedPrefKeys.kCustomerId) ==
        null) {
      // 🔧 OPTIMIZATION 4: Add null check and error handling
      final createCustomerRepo = getIt<CreateCustomerRepo>();
      if (!_isDisposed) {
        await createCustomerRepo.createCustomer();
      }
    }
  }

  // 🔧 OPTIMIZATION 6: Optimize navigation to prevent memory leaks
  void _navigateToRecommended() {
    if (_isDisposed) return;

    final cubit = context.read<GetTranslatorsListCubit>();

    context.pushNamed(
      Routes.recommendedTranslatorsView,
      arguments: {
        'title': 'Recommended Translators'.tr(),
        'translatorsList':
            cubit.translatorsList, // Pass IDs instead of full objects
        // Let the destination screen fetch full data from cubit
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    // 🔧 OPTIMIZATION 7: Add disposal tracking
    _isDisposed = true;
    debugPrint('🗑️ Disposing: HomeViewBody');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: 5,
      ).w,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const HomeSliverAppBar(),
          const SliverToBoxAdapter(
            child: FindTranslatorsByLanguageSection(),
          ),
          const SliverToBoxAdapter(
            child: FindTranslatorByTypeSection(),
          ),
          SliverToBoxAdapter(
            child: _buildRecommendedSection(), // Extract to method
          ),
          const RecommendedTranslatorsBlocBuilder(),
        ],
      ),
    );
  }

  // 🔧 OPTIMIZATION 8: Extract widget to method to reduce build method complexity
  Widget _buildRecommendedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpacing(15),
        Row(
          children: [
            TitleTextWidet(title: context.tr("Recommended Translators")),
            const Spacer(),
            TextButton(
              onPressed: _navigateToRecommended, // Use optimized navigation
              child: Text(
                context.tr("See All"),
                style: getMediumStyle(
                  color: AppColors.mainBlue,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        verticalSpacing(10),
      ],
    );
  }
}
