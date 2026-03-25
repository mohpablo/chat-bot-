import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final ThemeState themeState;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.themeState,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.getErrorColor(themeState),
              size: 80, // Larger icon
            ),
            const SizedBox(height: 30),
            Text(
              'Something went wrong',
              style: TextStyle(
                color: AppColors.getTextColor(themeState),
                fontSize: 24, // Larger font
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.getTextSecondaryColor(themeState),
                fontSize: 18, // Larger font
              ),
            ),
          ],
        ),
      ),
    );
  }
}

