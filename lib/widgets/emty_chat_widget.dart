import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class EmptyChatWidget extends StatelessWidget {
  final ThemeState themeState;

  const EmptyChatWidget({super.key, required this.themeState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140, // Larger icon
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.getPrimaryColor(themeState),
                    AppColors.getPrimaryDarkColor(themeState),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(70),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getPrimaryColor(themeState).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.smart_toy_outlined,
                color: Colors.white,
                size: 60, // Larger icon
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome to Grok Assistant',
              style: TextStyle(
                color: AppColors.getTextColor(themeState),
                fontSize: 28, // Larger font
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Start a conversation by typing a message below.\nI\'m here to help you with any questions!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.getTextSecondaryColor(themeState),
                fontSize: 18, // Larger font
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}