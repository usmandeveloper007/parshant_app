import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';
import 'package:parshant_app/core/services/firebase_auth.dart';
import 'package:parshant_app/core/utils/utils.dart';
import 'package:parshant_app/views/auth/log_in_screen.dart';
import 'package:parshant_app/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  void _handleRegister() async {
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
                const SizedBox(height: 130),
                TabHeader.buildHeader(
                    text1: "Register", text2: "Please enter details to register"),
                const SizedBox(height: 20),
                _buildFormFields(),
                const SizedBox(height: 20),
                _buildRegisterButton(),
                const SizedBox(height: 20),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        CredentialsTextField(
            labelText: 'Name', textEditingController: nameController),
        const SizedBox(height: 10),
        CredentialsTextField(
          prefixText: true,
          labelText: 'Mobile Number',
          textEditingController: mobileController,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        CredentialsTextField(
            labelText: 'Password', textEditingController: passwordController),
        const SizedBox(height: 10),
        CredentialsTextField(
            labelText: 'Confirm Password',
            textEditingController: confirmPasswordController),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Center(
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, value, child) {
          return CustomButton(
            onPressed: _handleRegister,
            backgroundColour: AppColors.primaryColor,
            minimumSize: const Size(300, 50),
            childWidget: value
                ? const CustomLoader()
                : Text("Register",
                    style: AppTextStyles.fontSize20(color: Colors.white)),
          );
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return Center(
      child: CustomButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
        ),
        backgroundColour: AppColors.primaryColor,
        minimumSize: const Size(200, 40),
        childWidget: Text('Log In',
            style: AppTextStyles.fontSize18(color: Colors.white)),
      ),
    );
  }
}

// class RegisterScreen1 extends StatefulWidget {
//   const RegisterScreen1({super.key});
//
//   @override
//   State<RegisterScreen1> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen1>
//     with SingleTickerProviderStateMixin {
//   // for phone
//
//   final TextEditingController phoneTabNameTextEditingController =
//       TextEditingController();
//   final TextEditingController mobileTextEditingController =
//       TextEditingController();
//   final TextEditingController passwordTextEditingController =
//       TextEditingController();
//   final TextEditingController confirmPasswordTextEditingController =
//       TextEditingController();
//
//   final ValueNotifier<bool> isLoading = ValueNotifier(false);
//
//   @override
//   void dispose() {
//     phoneTabNameTextEditingController.dispose();
//     mobileTextEditingController.dispose();
//     passwordTextEditingController.dispose();
//     confirmPasswordTextEditingController.dispose();
//     isLoading.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.textBodyPart2,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           reverse: true,
//           padding: const EdgeInsets.only(
//             left: 16.0,
//             right: 16.0,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 130),
//               TabHeader.buildHeader(
//                   text1: "Register", text2: "Please enter details to register"),
//               const SizedBox(height: 20),
//               buildPhoneTabFields(),
//               const SizedBox(
//                 height: 20,
//               ),
//               // yhe yha button work start h
//               Center(
//                 child: Column(
//                   children: [
//                     ValueListenableBuilder(
//                         valueListenable: isLoading,
//                         builder: (context, value, child) {
//                           return CustomButton(
//                             onPressed: () async {
//                               if (value == false) {
//                                 FocusScope.of(context).unfocus();
//                                 bool valdidationCheck = InputValidatorRegister
//                                     .isPhoneNumberTabValid(
//                                         context: context,
//                                         name: phoneTabNameTextEditingController
//                                             .text
//                                             .trim(),
//                                         mobileNumber:
//                                             mobileTextEditingController.text
//                                                 .trim(),
//                                         password: passwordTextEditingController
//                                             .text
//                                             .trim(),
//                                         confirmPassword:
//                                             confirmPasswordTextEditingController
//                                                 .text
//                                                 .trim());
//
//                                 if (valdidationCheck) {
//                                   isLoading.value = true;
//
//                                   String mobile =
//                                       mobileTextEditingController.text.trim();
//
//                                   String fullPhone = '$mobile@ashu.com';
//
//                                   await AuthService.registerUser(
//                                       context: context,
//                                       phoneNumber: fullPhone.trim(),
//                                       password: passwordTextEditingController
//                                           .text
//                                           .trim(),
//                                       name: phoneTabNameTextEditingController
//                                           .text
//                                           .trim());
//
//                                   isLoading.value = false;
//                                 }
//                               }
//                               null;
//                             },
//                             backgroundColour: AppColors.primaryColor,
//                             minimumSize: const Size(
//                               300,
//                               50,
//                             ),
//                             childWidget: value
//                                 ? const CustomLoader()
//                                 : Text(
//                                     "Register",
//                                     style: AppTextStyles.fontSize20(
//                                         color: Colors.white),
//                                   ),
//                           );
//                         }),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Center(
//                 child: CustomButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const LogInScreen1()));
//                   },
//                   backgroundColour: AppColors.primaryColor,
//                   minimumSize: const Size(
//                     200,
//                     40,
//                   ),
//                   childWidget: Text(
//                     'Log In',
//                     style: AppTextStyles.fontSize18(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildPhoneTabFields() {
//     return Column(
//       children: [
//         const SizedBox(height: 10),
//         CredentialsTextField(
//           labelText: 'Name',
//           textEditingController: phoneTabNameTextEditingController,
//         ),
//         const SizedBox(height: 10),
//         CredentialsTextField(
//           prefixText: true,
//           labelText: 'Mobile Number',
//           textEditingController: mobileTextEditingController,
//           keyboardType: TextInputType.phone,
//         ),
//         const SizedBox(height: 10),
//         CredentialsTextField(
//           labelText: 'Password',
//           textEditingController: passwordTextEditingController,
//         ),
//         const SizedBox(height: 10),
//         CredentialsTextField(
//           labelText: 'Confirm Password',
//           textEditingController: confirmPasswordTextEditingController,
//         ),
//       ],
//     );
//   }
// }
