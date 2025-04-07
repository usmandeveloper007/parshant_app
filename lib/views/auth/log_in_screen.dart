import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';
import 'package:parshant_app/core/services/firebase_auth.dart';
import 'package:parshant_app/views/auth/find_pasword_screens/fill_phone_number_screen.dart';
import 'package:parshant_app/views/dashboard/dashboard.dart';
import 'package:parshant_app/widgets/widgets.dart';

import 'register_screen.dart';

class LogInScreen extends StatefulWidget {
  final String phoneNumber;
  final String password;

  const LogInScreen({super.key, this.phoneNumber = "", this.password = ""});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    phoneController.text = widget.phoneNumber.length > 10
        ? widget.phoneNumber.substring(0, 10)
        : widget.phoneNumber;
    passwordController.text = widget.password;
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (isLoading.value) return;

    FocusScope.of(context).unfocus();
    String mobileNumber = phoneController.text.trim();
    String email = "$mobileNumber@ashu.com";
    String password = passwordController.text.trim();

    if (mobileNumber.isNotEmpty && password.isNotEmpty) {
      isLoading.value = true;

      bool loginSuccess = await AuthService.loginWithEmailPassword(
        loginEmail: email,
        loginPassword: password,
        context: context,
      );

      isLoading.value = false;
      if (loginSuccess && context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(navigationIndex: 0),
          ),
              (route) => false,
        );
      }
    } else {
      CustomFlushBar.showFlushBar(
        message: "Please enter details",
        context: context,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.textBodyPart2,
          body: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 250),
                TabHeader.buildHeader(
                  text1: "Log In",
                  text2: "Please enter details to log in",
                ),
                const SizedBox(height: 20),
                _buildCredentialsFields(),
                const SizedBox(height: 20),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildRegisterAndForgotPasswordRow(),
                // GestureDetector(
                //   onTap: (){
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard(navigationIndex: 0,)));
                //   },
                //   child: Container(
                //     height: 30,
                //     width: 80,
                //     color: Colors.amber,
                //     child: const Text("dashboard"),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialsFields() {
    return Column(
      children: [
        CredentialsTextField(
          labelText: 'Mobile Number',
          textEditingController: phoneController,
          prefixText: true,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        CredentialsTextField(
          labelText: 'Password',
          textEditingController: passwordController,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, loading, child) {
            return CustomButton(
              onPressed: 
              //   Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => Dashboard(navigationIndex: 0),
              //     ),
              //         (route) => false,
              //   );
              // },

              _handleLogin,
              backgroundColour: AppColors.primaryColor,
              minimumSize: const Size(300, 45),
              childWidget: loading
                  ? const CustomLoader()
                  : Text(
                      "Log In",
                      style: AppTextStyles.fontSize25(color: Colors.white),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRegisterAndForgotPasswordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildNavigationButton(
              label: "Register",
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              ),
            ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: _buildNavigationButton(
            label: "Find Password",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FillPhoneNumberScreen()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(
      {required String label, required VoidCallback onPressed}) {
    return CustomButton(
      onPressed: onPressed,
      backgroundColour: AppColors.primaryColor,
      minimumSize: const Size(180, 40),
      childWidget: Text(
        label,
        style: AppTextStyles.fontSize18(color: Colors.white),
      ),
    );
  }
}

