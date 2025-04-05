import 'package:flutter/material.dart';
import 'package:parshant_app/core/services/firebase_auth.dart';
import 'package:parshant_app/core/utils/shared_prefrences.dart';
import 'package:parshant_app/views/auth/log_in_screen.dart';
import 'package:parshant_app/views/dashboard/dashboard.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> navigateToNextScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2)); // Show splash for 2 sec

    String? userMobileNumber =
        await SharedPreferencesHelper.getMobileNumber() ?? '';
    String? userPassword = await SharedPreferencesHelper.getPassword() ?? '';
    bool isLoggedIn = false;

    if (userMobileNumber.isNotEmpty && userPassword.isNotEmpty) {
      isLoggedIn = await AuthService.loginWithEmailPassword(
        loginEmail: '$userMobileNumber@ashu.com',
        loginPassword: userPassword,
        context: context,
      );
    }

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn
              ? const Dashboard(navigationIndex: 0)
              : const LogInScreen(),
        ),
            (route) => false, // Ensures all previous screens are removed
      );
    }
  }
}
