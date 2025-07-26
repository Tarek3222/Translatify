import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/di/depandecy_injection.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/shared_preference_helper.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/utils/app_constants.dart';
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
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getCustomerId();
    super.initState();
  }

  Future<void> getCustomerId() async {
    if (getIt<SharedPrefHelper>().getString(SharedPrefKeys.kCustomerId) ==
        null) {
      await getIt<CreateCustomerRepo>().createCustomer();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 5)
              .w,
      child: RefreshIndicator(
        onRefresh: () async {
          await context
              .read<GetTranslatorsListCubit>()
              .getTranslatorsList(forceRefresh: true);
        },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacing(15),
                  Row(
                    children: [
                      TitleTextWidet(title: "Recommended Translators".tr()),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(Routes.recommendedTranslatorsView,
                              arguments: {
                                'title': 'Recommended Translators'.tr(),
                                'translatorsList': context
                                    .read<GetTranslatorsListCubit>()
                                    .translatorsList,
                              });
                        },
                        child: Text(
                          "See All".tr(),
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
              ),
            ),
            const RecommendedTranslatorsBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
