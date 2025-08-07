// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/translator_profile/data/models/reviews_response_body.dart';
import 'package:translators/features/translator_profile/logic/get_reviews_cubit/get_reviews_cubit.dart';
import 'package:translators/features/translator_profile/ui/widgets/single_review_item.dart';

class ReviewsTabBarBlocBuilder extends StatefulWidget {
  const ReviewsTabBarBlocBuilder(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;

  @override
  State<ReviewsTabBarBlocBuilder> createState() =>
      _ReviewsTabBarBlocBuilderState();
}

class _ReviewsTabBarBlocBuilderState extends State<ReviewsTabBarBlocBuilder>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    context.read<GetReviewsCubit>().getReviews(
        translatorId: widget.translatorProfileModel.translator!.first.id!);
    _scrollController.addListener(() {
      _paginationScrollListener();
    });
    super.initState();
  }

  void _paginationScrollListener() {
    final state = context.read<GetReviewsCubit>().state;
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _scrollController.position.maxScrollExtent > 0 &&
        state is GetReviewsSuccess &&
        state.hasMore) {
      context.read<GetReviewsCubit>().getReviews(
          translatorId: widget.translatorProfileModel.translator!.first.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<GetReviewsCubit, GetReviewsState>(
      buildWhen: (previous, current) =>
          current is GetReviewsSuccess ||
          current is GetReviewsLoading ||
          current is GetReviewsError,
      builder: (context, state) {
        switch (state.runtimeType) {
          case GetReviewsLoading:
            return const AppLoadingIndecator();
          case GetReviewsError:
            return buildErrorState(state);
          case GetReviewsSuccess:
            final reviews = (state as GetReviewsSuccess).reviewsList;
            if (reviews.isEmpty) {
              return buildNoReviewsTextWidget(context);
            }
            return buildReviewsListView(reviews, state);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildErrorState(GetReviewsState state) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<GetReviewsCubit>().getReviews(
            refresh: true,
            translatorId: widget.translatorProfileModel.translator!.first.id!);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Center(
            child: Text(
              (state as GetReviewsError).errorModel.getAllMessages(),
              style: getSemiBoldStyle(
                fontSize: 16,
                color: AppColors.mainRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNoReviewsTextWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<GetReviewsCubit>().getReviews(
            refresh: true,
            translatorId: widget.translatorProfileModel.translator!.first.id!);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Center(
            child: Text(
              "No reviews available.",
              style: getSemiBoldStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReviewsListView(
      List<ReviewModel> reviews, GetReviewsSuccess state) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<GetReviewsCubit>().getReviews(
            refresh: true,
            translatorId: widget.translatorProfileModel.translator!.first.id!);
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: reviews.length + (!state.hasMore ? 1 : 0),
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          if (index < reviews.length) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16).r,
              child: SingleReviewItem(
                reviewModel: reviews[index],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16).r,
              child: const AppLoadingIndecator(),
            );
          }
        },
      ),
    );
  }
}
