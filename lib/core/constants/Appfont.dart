import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontSizes {
  static const double size25 = 25;
  static const double size22 = 22;
  static   double size20 = 20.sp;
  static const double size18 = 18;
  static const double size15 = 15;
}

class AppTextStyles {

  static TextStyle getTextStyle({
    required double fontSize,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }


  static TextStyle fontSize25({Color color = Colors.black}) {
    return getTextStyle(fontSize: AppFontSizes.size25, color: color);
  }

  static TextStyle fontSize22({Color color = Colors.black}) {
    return getTextStyle(fontSize: AppFontSizes.size22, color: color);
  }

  static TextStyle fontSize20({Color color = Colors.black}) {
    return getTextStyle(fontSize: AppFontSizes.size20, color: color);
  }

  static TextStyle fontSize18({Color color = Colors.black}) {
    return getTextStyle(fontSize: AppFontSizes.size18, color: color);
  }

  static TextStyle fontSize15({Color color = Colors.black}) {
    return getTextStyle(fontSize: AppFontSizes.size15, color: color);
  }
}