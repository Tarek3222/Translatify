// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/widgets/app_loading_indecator.dart';
import 'package:translators/features/chat/logic/chat_cubit/chat_cubit.dart';
import 'package:translators/features/chat/ui/widgets/chat_bubble.dart';
import 'package:translators/features/chat/ui/widgets/chat_messages.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class ChatMessagesBlocBuilder extends StatelessWidget {
  const ChatMessagesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          current is ChatSuccess ||
          current is ChatError ||
          current is ChatLoading ||
          current is ChatLoadingAfterSendMessage ||
          current is ChatErrorAfterSendMessage,
      builder: (context, state) {
        switch (state.runtimeType) {
          case ChatLoading:
            return setupLoadingState();
          case ChatError:
            return setupErrorState(state);
          case ChatSuccess:
            return setupSuccessState(state);
          case ChatLoadingAfterSendMessage:
            return setupLoadingAfterSendMessageState(state);
          case ChatErrorAfterSendMessage:
            return setupErrorAfterSendMessageState(state);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget setupLoadingState() {
    return const AppLoadingIndecator();
  }

  Widget setupLoadingAfterSendMessageState(ChatState state) {
    final loadingAfterSendMessageState = state as ChatLoadingAfterSendMessage;
    // get the list of translators with rating above 3.0
    return loadingAfterSendMessageState.messages.isNotEmpty
        ? ListView.builder(
            itemCount: loadingAfterSendMessageState.messages.length + 1,
            itemBuilder: (context, index) {
              return index == loadingAfterSendMessageState.messages.length
                  ? const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: CircularProgressIndicator())
                  : ChatBubble(
                      message: loadingAfterSendMessageState.messages[index],
                    );
            },
          )
        : const Align(
            alignment: AlignmentDirectional.topEnd,
            child: AppLoadingIndecator(),
          );
  }

  Widget setupErrorAfterSendMessageState(ChatState state) {
    final errorAfterSendMessageState = state as ChatErrorAfterSendMessage;
    // get the list of translators with rating above 3.0
    return errorAfterSendMessageState.messages.isNotEmpty
        ? ListView.builder(
            itemCount: errorAfterSendMessageState.messages.length + 1,
            itemBuilder: (context, index) {
              return index == errorAfterSendMessageState.messages.length
                  ? const Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TitleTextWidet(
                        title: "something went wrong",
                        textColor: AppColors.mainRed,
                      ),
                    )
                  : ChatBubble(
                      message: errorAfterSendMessageState.messages[index],
                    );
            },
          )
        : const Align(
            alignment: AlignmentDirectional.topEnd,
            child: TitleTextWidet(
              title: "something went wrong",
              textColor: AppColors.mainRed,
            ),
          );
  }

  Widget setupSuccessState(ChatState state) {
    final successState = state as ChatSuccess;
    // get the list of translators with rating above 3.0
    return successState.messages.isNotEmpty
        ? ChatMessages(
            messages: successState.messages,
          )
        : const Center(
            child: TitleTextWidet(
              title: "start a conversation",
              textColor: AppColors.mainBlue,
            ),
          );
  }

  Widget setupErrorState(ChatState state) {
    final errorState = state as ChatError;
    return Center(
      child: TitleTextWidet(
        title: "Error: ${errorState.errorModel.getAllMessages()}",
        textColor: Colors.red,
      ),
    );
  }
}
