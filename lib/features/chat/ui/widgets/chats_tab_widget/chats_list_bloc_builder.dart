// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/features/chat/logic/cubit/chats_list_cubit.dart';
import 'package:translators/features/chat/ui/widgets/chats_tab_widget/chats_list_view.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class ChatsListBlocBuilder extends StatelessWidget {
  const ChatsListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsListCubit, ChatsListState>(
      buildWhen: (previous, current) =>
          current is ChatsListSuccess ||
          current is ChatsListError ||
          current is ChatsListLoading,
      builder: (context, state) {
        switch (state.runtimeType) {
          case ChatsListLoading:
            return setupLoadingState();
          case ChatsListError:
            return setupErrorState(state, context);
          case ChatsListSuccess:
            return setupSuccessState(state, context);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget setupLoadingState() {
    return const AppLoadingIndecator();
  }

  Widget setupSuccessState(ChatsListState state, BuildContext context) {
    final successState = state as ChatsListSuccess;
    // sort chats bsaed on last message
    successState.chats.sort((a, b) =>
        b.messages!.last.createdAt!.compareTo(a.messages!.last.createdAt!));
    return successState.chats.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async {
              await context
                  .read<ChatsListCubit>()
                  .getChatsList(forceRefresh: true);
            },
            child: ChatsListView(
              chats: successState.chats,
            ),
          )
        : RefreshIndicator(
            onRefresh: () async {
              await context
                  .read<ChatsListCubit>()
                  .getChatsList(forceRefresh: true);
            },
            child: const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: TitleTextWidet(
                  title: "No Chats Available",
                  textColor: AppColors.mainBlue,
                ),
              ),
            ),
          );
  }

  Widget setupErrorState(ChatsListState state, BuildContext context) {
    final errorState = state as ChatsListError;
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<ChatsListCubit>().getChatsList(forceRefresh: true);
      },
      child:
          ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
        Center(
          child: TitleTextWidet(
            title: "Error: ${errorState.errorModel.getAllMessages()}",
            textColor: Colors.red,
          ),
        ),
      ]),
    );
  }
}
