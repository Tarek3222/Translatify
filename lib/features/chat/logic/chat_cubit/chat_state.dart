part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoadingAfterSendMessage extends ChatState {
  final List<Messages> messages;
  const ChatLoadingAfterSendMessage({required this.messages});

  @override
  List<Object> get props => [messages];
}

final class ChatErrorAfterSendMessage extends ChatState {
  final List<Messages> messages;
  const ChatErrorAfterSendMessage({required this.messages});

  @override
  List<Object> get props => [messages];
}

final class ChatSuccess extends ChatState {
  final List<Messages> messages;
  const ChatSuccess({required this.messages});

  @override
  List<Object> get props => [messages];
}

final class ChatError extends ChatState {
  final ApiErrorModel errorModel;
  const ChatError({required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}

// send message
final class SendMessageLoading extends ChatState {}

final class SendMessageError extends ChatState {
  final ApiErrorModel errorModel;
  const SendMessageError({required this.errorModel});
}

final class SendMessageSuccess extends ChatState {}
