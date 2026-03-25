import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:chat_bot/widgets/chat_bubble.dart';
import 'package:chat_bot/widgets/chat_input_field.dart';
import 'package:chat_bot/widgets/custom_app_bar.dart';
import 'package:chat_bot/widgets/emty_chat_widget.dart';
import 'package:chat_bot/widgets/error_state_widget.dart';
import 'package:chat_bot/widgets/loading_widget.dart';
import 'package:chat_bot/widgets/scroll_to_bottom_fab.dart';
import 'package:chat_bot/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_bot/core/utils/screen_size_helper.dart';
import 'package:chat_bot/cubit/ai_chat_cubit.dart';
import 'package:chat_bot/cubit/chat_history_cubit.dart';
import 'package:chat_bot/models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScreenSizeHelper.init(context);
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final distanceFromBottom = maxScroll - currentScroll;
    
    final shouldShowButton = distanceFromBottom > 300; // Show button when scrolled up

    if (shouldShowButton != _showScrollToBottom) {
      setState(() {
        _showScrollToBottom = shouldShowButton;
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    
    setState(() {
      _showScrollToBottom = false;
    });
  }

  void _sendMessage(String message) {
    if (message.trim().isNotEmpty) {
      context.read<ChatHistoryCubit>().addUserMessage(message);
      context.read<AiChatCubit>().sendMessage(message);
      // Auto-scroll to bottom when user sends message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeHelper.init(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocListener<AiChatCubit, AiChatState>(
          listener: (context, state) {
            if (state is AiChatLoading) {
              setState(() => _isLoading = true);
            } else if (state is AiChatSuccess) {
              setState(() => _isLoading = false);
              context.read<ChatHistoryCubit>().addAssistantMessage(state.message);
              _messageController.clear();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToBottom();
              });
            } else if (state is AiChatError) {
              setState(() => _isLoading = false);
              _showErrorSnackBar(state.message, themeState);
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.getBackgroundColor(themeState),
            appBar: CustomAppBar(
              onThemeToggle: () => context.read<ThemeCubit>().toggleTheme(),
              onClearHistory: () {
                context.read<ChatHistoryCubit>().clearHistory();
              },
            ),
            body: Column(
              children: [
                // MAIN SCROLLABLE CONTENT
                Expanded(
                  child: _buildChatContent(themeState),
                ),
                ChatInputField(
                  controller: _messageController,
                  isLoading: _isLoading,
                  onSendMessage: _sendMessage,
                  themeState: themeState,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatContent(ThemeState themeState) {
    return BlocBuilder<ChatHistoryCubit, ChatHistoryState>(
      builder: (context, state) {
        if (state is ChatHistoryLoaded) {
          final messages = state.messages;

          return Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(), 
                slivers: [
                  if (messages.isEmpty)
                    _buildEmptyStateSliver(themeState)
                  else
                    _buildMessagesSliver(messages, themeState),

                  if (_isLoading) _buildTypingIndicatorSliver(themeState),                  
                  _buildBottomPaddingSliver(),
                ],
              ),
              if (_showScrollToBottom)
                Positioned(
                  bottom: 20,
                  right: 16,
                  child: ScrollToBottomFab(
                    onTap: _scrollToBottom,
                    themeState: themeState,
                  ),
                ),
            ],
          );
        } else if (state is ChatHistoryError) {
          return ErrorStateWidget(
            message: state.message,
            themeState: themeState,
          );
        }
        return LoadingWidget(themeState: themeState);
      },
    );
  }


  SliverFillRemaining _buildEmptyStateSliver(ThemeState themeState) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: EmptyChatWidget(themeState: themeState),
    );
  }

  
  SliverList _buildMessagesSliver(List<ChatMessage> messages, ThemeState themeState) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final message = messages[index];
          return ChatBubble(
            message: message,
            isFirst: index == 0,
            isLast: index == messages.length - 1,
            themeState: themeState,
          );
        },
        childCount: messages.length,
      ),
    );
  }

  
  SliverToBoxAdapter _buildTypingIndicatorSliver(ThemeState themeState) {
    return SliverToBoxAdapter(
      child: TypingIndicator(themeState: themeState),
    );
  }


  SliverPadding _buildBottomPaddingSliver() {
    return const SliverPadding(
      padding: EdgeInsets.only(bottom: 20),
    );
  }

  void _showErrorSnackBar(String message, ThemeState themeState) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.getErrorColor(themeState),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
