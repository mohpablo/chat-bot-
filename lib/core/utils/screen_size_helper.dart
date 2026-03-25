import 'package:flutter/material.dart';

class ScreenSizeHelper {
  static late double width;
  static late double height;
  static late double paddingTop;
  static late double paddingBottom;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
    paddingTop = mediaQuery.padding.top;
    paddingBottom = mediaQuery.padding.bottom;
  }

  static double get responsiveWidth => width * 0.9;
  static double get chatBubbleMaxWidth => width * 0.75;
  static double get iconSizeSmall => width * 0.055;
  static double get iconSizeMedium => width * 0.065;
  static double get iconSizeLarge => width * 0.075;
}
