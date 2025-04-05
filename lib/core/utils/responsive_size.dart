import 'package:flutter/material.dart';



double responsiveFontSize(BuildContext context, double baseSize) {
  double screenWidth = MediaQuery.of(context).size.width;

  // Scale factor based on original device dimensions
  double referenceWidth = 411;
  double adjustedFontSize = baseSize - ((referenceWidth - screenWidth) / 10);

  if (screenWidth > 600) {
    adjustedFontSize *= 1.2;
  }
  print('adjustFontSize $adjustedFontSize');
  return adjustedFontSize.clamp(11, 20);
}
