import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';
import 'package:parshant_app/core/services/firebase_find_user_number.dart';
import 'package:parshant_app/widgets/widgets.dart';

import 'otp_screen.dart';

class FillPhoneNumberScreen extends StatelessWidget {
  FillPhoneNumberScreen({super.key});

  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabHeader.buildHeader(
            text1: "Find Password",
            text2: "Please enter your registered phone number",
          ),
          const SizedBox(height: 50),
          CredentialsTextField(
            labelText: 'Mobile Number',
            textEditingController: _phoneController,
            prefixText: true,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () => _sendOtp(context),
            backgroundColour: Colors.blue,
            minimumSize: const Size(300, 40),
            childWidget: ValueListenableBuilder<bool>(
              valueListenable: _isLoading,
              builder: (context, isLoading, child) {
                return isLoading
                    ? const CustomLoader()
                    : Text(
                        "Send OTP",
                        style: AppTextStyles.fontSize20(color: Colors.white),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _sendOtp(BuildContext context) async {
    if (_phoneController.text.isEmpty || _phoneController.text.length != 10) {
      _showError(context, '❌ Please enter a valid mobile number');
      return;
    }

    _isLoading.value = true;
    try {
      String formattedPhone = "${_phoneController.text.trim()}@ashu.com";
      bool isUserValid =
          await FirebaseFindUserNumber.checkuserNumber(formattedPhone);

      if (!isUserValid) {
        _showError(context, '❌ Enter correct details');
        _isLoading.value = false;
        return;
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_phoneController.text}',
        verificationCompleted: (_) => _isLoading.value = false,
        verificationFailed: (e) {
          _showError(context, '❌ Verification failed: ${e.message}');
          _isLoading.value = false;
        },
        codeSent: (String verificationId, int? resendToken) {
          _isLoading.value = false;
          _navigateToOtpScreen(context, verificationId);
        },
        codeAutoRetrievalTimeout: (_) => _isLoading.value = false,
      );
    } catch (e) {
      _showError(context, '❌ An error occurred: $e');
      _isLoading.value = false;
    }
  }

  void _navigateToOtpScreen(BuildContext context, String verificationId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(
          verificationId: verificationId,
          phoneNumber: "${_phoneController.text.trim()}@ashu.com",
        ),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    CustomFlushBar.showFlushBar(
      message: message,
      context: context,
      backgroundColor: Colors.black,
    );
  }
}
