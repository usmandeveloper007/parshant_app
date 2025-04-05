import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


class CustomFlushBar {

  static void showFlushBar({
    FlushbarPosition position = FlushbarPosition.TOP,
    required String message,
    required BuildContext context,
    Color backgroundColor = Colors.blue,
  }) {

    Flushbar(
      flushbarPosition: position,
      margin: const EdgeInsets.only(top: 20),
      message: message,
      messageSize: 16,
      messageColor:  Colors.white,
      backgroundColor: backgroundColor,
      reverseAnimationCurve: Curves.ease,
      forwardAnimationCurve: Curves.ease,
      duration: const Duration(seconds: 5),
    ).show(context);
  }
}
