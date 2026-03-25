part of 'chat_history_cubit.dart';

@immutable
sealed class ChatHistoryState {}

final class ChatHistoryInitial extends ChatHistoryState {}

class ChatHistoryLoading extends ChatHistoryState {}

class ChatHistoryLoaded extends ChatHistoryState {
  final List<ChatMessage> messages;

  ChatHistoryLoaded(this.messages);
}

class ChatHistoryError extends ChatHistoryState {
  final String message;

  ChatHistoryError(this.message);
}