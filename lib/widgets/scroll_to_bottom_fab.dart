import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class ScrollToBottomFab extends StatelessWidget {
  final VoidCallback onTap;
  final ThemeState themeState;

  const ScrollToBottomFab({super.key, 
    required this.onTap,
    required this.themeState,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: onTap,
      backgroundColor: AppColors.getSurfaceColor(themeState),
      foregroundColor: AppColors.getPrimaryColor(themeState),
      elevation: 4,
      child: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 24,
      ),
    );
  }
}