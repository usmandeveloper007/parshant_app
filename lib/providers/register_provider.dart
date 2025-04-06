import 'package:flutter/material.dart';

import '../core/services/firebase_auth.dart';
import '../core/utils/input_validator.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  void handleRegister(BuildContext context) async {
    if (isLoading.value) return;
    FocusScope.of(context).unfocus();

    bool isValid = InputValidatorRegister.isPhoneNumberTabValid(
      context: context,
      name: nameController.text.trim(),
      mobileNumber: mobileController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );

    if (isValid) {
      isLoading.value = true;
      String fullPhone = '${mobileController.text.trim()}@ashu.com';

      await AuthService.registerUser(
        context: context,
        phoneNumber: fullPhone,
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      );

      isLoading.value = false;
    }
  }
}