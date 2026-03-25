import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onThemeToggle;
  final VoidCallback onClearHistory;
  final ThemeState? themeState;

  const CustomAppBar({
    super.key,
    required this.onThemeToggle,
    required this.onClearHistory,
    this.themeState,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final currentThemeState = themeState ?? context.watch<ThemeCubit>().state;
    final isDarkMode = currentThemeState is ThemeDark;

    return AppBar(
      backgroundColor: AppColors.getSurfaceColor(currentThemeState),
      elevation: 1,
      title: Row(
        children: [
          Container(
            width: 44, // Larger logo
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.getPrimaryColor(currentThemeState),
                  AppColors.getPrimaryDarkColor(currentThemeState),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.smart_toy_rounded,
              color: Colors.white,
              size: 24, // Larger icon
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Grok Assistant',
            style: TextStyle(
              color: AppColors.getTextColor(currentThemeState),
              fontWeight: FontWeight.w700,
              fontSize: 20, // Larger font
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: AppColors.getTextColor(currentThemeState),
            size: 26, // Larger icon
          ),
          onPressed: onThemeToggle,
        ),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.getTextColor(currentThemeState),
            size: 26, // Larger icon
          ),
          onSelected: (value) {
            if (value == 'clear') {
              _showClearConfirmationDialog(context, currentThemeState);
            }
          },
          color: AppColors.getSurfaceColor(
            currentThemeState,
          ), // Background color of popup
          surfaceTintColor: AppColors.getSurfaceColor(
            currentThemeState,
          ), // For Material 3
          shadowColor: Colors.black.withValues(alpha: 0.3),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.getOutlineColor(
                currentThemeState,
              ).withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'clear',
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: AppColors.getErrorColor(currentThemeState),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Clear History',
                    style: TextStyle(
                      color: AppColors.getTextColor(currentThemeState),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showClearConfirmationDialog(
    BuildContext context,
    ThemeState themeState,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.getSurfaceColor(themeState),
        surfaceTintColor: AppColors.getSurfaceColor(themeState),
        title: Text(
          'Clear Chat History',
          style: TextStyle(
            color: AppColors.getTextColor(themeState),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        content: Text(
          'Are you sure you want to clear all chat history? This action cannot be undone.',
          style: TextStyle(
            color: AppColors.getTextSecondaryColor(themeState),
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.getTextSecondaryColor(themeState),
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClearHistory();
            },
            child: Text(
              'Clear',
              style: TextStyle(
                color: AppColors.getErrorColor(themeState),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
