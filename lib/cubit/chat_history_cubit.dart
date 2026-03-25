import 'package:bloc/bloc.dart';
import 'package:chat_bot/core/database/cache_hepler.dart';
import 'package:chat_bot/models/chat_message.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

part 'chat_history_state.dart';

class ChatHistoryCubit extends Cubit<ChatHistoryState> {
  ChatHistoryCubit() : super(ChatHistoryInitial()) {
    loadChatHistory();
  }

  final List<ChatMessage> _messages = [];
  static const String _chatHistoryKey = 'chat_history';

  Future<void> loadChatHistory() async {
    try {
      emit(ChatHistoryLoading());
      final historyJson = CacheHepler.getString(_chatHistoryKey);

      if (historyJson != null && historyJson.isNotEmpty) {
        final List decoded = json.decode(historyJson);
        _messages
          ..clear()
          ..addAll(decoded.map((e) => ChatMessage.fromJson(e)));
      }
      emit(ChatHistoryLoaded(List.unmodifiable(_messages)));
    } catch (e) {
      emit(ChatHistoryError('Failed to load chat history: $e'));
    }
  }

  Future<void> addMessage(ChatMessage message) async {
    _messages.add(message);
    emit(ChatHistoryLoaded(List.unmodifiable(_messages)));
    await _appendToStorage(message);
  }

  Future<void> addUserMessage(String content) {
    return addMessage(ChatMessage(
      role: 'user',
      content: content,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> addAssistantMessage(String content) {
    return addMessage(ChatMessage(
      role: 'assistant',
      content: content,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> clearHistory() async {
    _messages.clear();
    await CacheHepler.remove(_chatHistoryKey);
    emit(ChatHistoryLoaded(const []));
  }

  Future<void> _appendToStorage(ChatMessage msg) async {
    final historyJson = CacheHepler.getString(_chatHistoryKey);
    List<Map<String, dynamic>> historyList = [];

    if (historyJson != null && historyJson.isNotEmpty) {
      historyList = List<Map<String, dynamic>>.from(json.decode(historyJson));
    }

    historyList.add(msg.toJson());
    await CacheHepler.setString(_chatHistoryKey, json.encode(historyList));
  }

  List<ChatMessage> get messages => List.unmodifiable(_messages);
}
