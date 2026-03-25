import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:chat_bot/widgets/typing_animation.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final bool isLoading;
  final Function(String) onSendMessage;
  final ThemeState themeState;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSendMessage,
    required this.themeState,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(widget.themeState),
        border: Border(
          top: BorderSide(
            color: AppColors.getOutlineColor(widget.themeState).withValues(alpha:  0.3),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 56, 
                maxHeight: 140,
              ),
              decoration: BoxDecoration(
                color: AppColors.getBackgroundColor(widget.themeState),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.getOutlineColor(widget.themeState).withValues(alpha: 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      enabled: !widget.isLoading,
                      maxLines: null,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: widget.onSendMessage,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: AppColors.getTextSecondaryColor(widget.themeState),
                          fontSize: 17, // Larger font
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      style: TextStyle(
                        color: AppColors.getTextColor(widget.themeState),
                        fontSize: 17, // Larger font
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 56, // Larger send button
            height: 56,
            decoration: BoxDecoration(
              color: widget.isLoading
                  ? AppColors.getTextSecondaryColor(widget.themeState).withValues(alpha: .5)
                  : AppColors.getPrimaryColor(widget.themeState),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.getPrimaryColor(widget.themeState).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: widget.isLoading
                ? const TypingAnimation()
                : IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 24, // Larger icon
                    ),
                    onPressed: () {
                      final text = widget.controller.text.trim();
                      if (text.isNotEmpty) {
                        widget.onSendMessage(text);
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
