import 'package:chat_bot/core/utils/cubit/theme_cubit.dart';
import 'package:chat_bot/core/utils/custom_colors.dart';
import 'package:flutter/material.dart';

class TypingDot extends StatefulWidget {
  final int delay;
  final ThemeState themeState;

  const TypingDot({super.key, 
    required this.delay,
    required this.themeState,
  });

  @override
  State<TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<TypingDot> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 10, // Larger dots
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: AppColors.getTextSecondaryColor(widget.themeState)
                .withValues(alpha: _controller.value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}