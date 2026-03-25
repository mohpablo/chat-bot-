import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final ThemeState themeState;

  const LoadingWidget({super.key, required this.themeState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.getPrimaryColor(themeState),
        strokeWidth: 3,
      ),
    );
  }
}