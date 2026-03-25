import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:chat_bot/widgets/avator.dart';
import 'package:chat_bot/widgets/typing_dot.dart';
import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  final ThemeState themeState;

  const TypingIndicator({super.key, required this.themeState});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(isAI: true, themeState: themeState),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.getSurfaceColor(themeState),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TypingDot(delay: 0, themeState: themeState),
                    TypingDot(delay: 200, themeState: themeState),
                    TypingDot(delay: 400, themeState: themeState),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}