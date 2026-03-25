part of 'ai_chat_cubit.dart';

@immutable
sealed class AiChatState {}

final class AiChatInitial extends AiChatState {}

class AiChatLoading extends AiChatState {}

class AiChatSuccess extends AiChatState {
  final String message;
  AiChatSuccess(this.message);
}

class AiChatError extends AiChatState {
  final String message;
  AiChatError(this.message);
}