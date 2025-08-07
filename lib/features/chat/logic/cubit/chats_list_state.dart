part of 'chats_list_cubit.dart';

sealed class ChatsListState extends Equatable {
  const ChatsListState();

  @override
  List<Object> get props => [];
}

final class ChatsListInitial extends ChatsListState {}

final class ChatsListLoading extends ChatsListState {}

final class ChatsListSuccess extends ChatsListState {
  final List<Chats> chats;
  const ChatsListSuccess({required this.chats});

  @override
  List<Object> get props => [chats];
}

final class ChatsListError extends ChatsListState {
  final ApiErrorModel errorModel;
  const ChatsListError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}

// delete chat

final class DeleteChatLoading extends ChatsListState {}

final class DeleteChatSuccess extends ChatsListState {}

final class DeleteChatError extends ChatsListState {
  final ApiErrorModel errorModel;
  const DeleteChatError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
