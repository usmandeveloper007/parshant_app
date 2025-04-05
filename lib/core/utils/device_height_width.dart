import 'package:flutter/material.dart';

class ScreenDimensions {
  static double width = 0;
  static double height = 0;

  static void update(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
  }
}