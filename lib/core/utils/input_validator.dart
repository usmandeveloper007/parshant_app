import 'package:flutter/material.dart';
import 'package:parshant_app/widgets/widgets.dart';


class InputValidatorRegister {
  static bool isPhoneNumberTabValid({
    required BuildContext context,
    required String name,
    required String mobileNumber,
    required String password,
    required String confirmPassword,
  }) {
    // Mobile Number Validation
    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
      CustomFlushBar.showFlushBar(
        context: context,
        message: 'Invalid Mobile Number',
      );

      return false;
    }

    // Password Validation
    if (password.isEmpty) {
      CustomFlushBar.showFlushBar(
        context: context,
        message: 'Please enter a Password',
      );

      return false;
    }
    if (!_isValidPassword(password)) {
      CustomFlushBar.showFlushBar(
        context: context,
        message:
            'Password Requirements\n• At least 8 characters\n• Must include one letter (a-z or A-Z)\n• Must include one number (0-9)',
      );

      return false;
    }

    // Confirm Password Validation
    if (password != confirmPassword) {
      CustomFlushBar.showFlushBar(
        context: context,
        message: 'Passwords do not match.',
      );

      return false;
    }

    // Name Validation
    if (name.isEmpty || name.length < 3 || name.length > 15) {
      CustomFlushBar.showFlushBar(
        context: context,
        message: 'Name must be between 3 to 15 characters.',
      );
      return false;
    }

    return true;
  }

  // Helper: Password Validation Logic
  static bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'(?=.*[0-9])').hasMatch(password) &&
        RegExp(r'(?=.*[a-zA-Z])').hasMatch(password);
  }
}
