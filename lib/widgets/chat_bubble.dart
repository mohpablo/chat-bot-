import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:chat_bot/models/chat_message.dart';
import 'package:chat_bot/widgets/avator.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isFirst;
  final bool isLast;
  final ThemeState themeState;

  const ChatBubble({
    super.key,
    required this.message,
    this.isFirst = false,
    this.isLast = false,
    required this.themeState,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';

    return Container(
      margin: EdgeInsets.only(
        top: isFirst ? 16 : 12,
        bottom: isLast ? 16 : 12,
      ),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Avatar(isAI: true, themeState: themeState),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isUser) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 6),
                    child: Text(
                      'Grok',
                      style: TextStyle(
                        color: AppColors.getTextSecondaryColor(themeState),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.78,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.getPrimaryColor(themeState)
                        : AppColors.getSurfaceColor(themeState),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isUser ? 20 : 8),
                      bottomRight: Radius.circular(isUser ? 8 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        message.content,
                        style: TextStyle(
                          color: isUser
                              ? Colors.white
                              : AppColors.getTextColor(themeState),
                          fontSize: 17, // Larger font size
                          height: 1.5, // Better line height
                          fontWeight: isUser ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _formatTime(message.timestamp),
                        style: TextStyle(
                          color: isUser
                              ? Colors.white70
                              : AppColors.getTextSecondaryColor(themeState),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 12),
            Avatar(isAI: false, themeState: themeState),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}