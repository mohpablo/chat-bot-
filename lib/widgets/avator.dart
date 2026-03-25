import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final bool isAI;
  final ThemeState themeState;

  const Avatar({super.key, 
    required this.isAI,
    required this.themeState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44, // Larger avatar
      height: 44,
      decoration: BoxDecoration(
        color: isAI
            ? AppColors.getPrimaryColor(themeState)
            : AppColors.getTextSecondaryColor(themeState),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        isAI ? Icons.smart_toy_rounded : Icons.person,
        color: Colors.white,
        size: 22, // Larger icon
      ),
    );
  }
}