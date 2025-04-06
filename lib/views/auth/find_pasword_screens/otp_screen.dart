import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';
import 'package:parshant_app/core/services/firebase_find_user_number.dart';
import 'package:parshant_app/views/auth/log_in_screen.dart';
import 'package:parshant_app/widgets/widgets.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  @override
  void dispose() {
    pinController.dispose();

    super.dispose();
  }

  void _verifyOtp() async {
    // String smsCode =
    //     _otpControllers.map((controller) => controller.text).join();
    // debugPrint("Entered OTP: $smsCode");

    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: pinController.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("OTP verified successfully!");

      await FirebaseAuth.instance.currentUser?.delete();
      List<String> userData =
          await FirebaseFindUserNumber.userDataFind(widget.phoneNumber);

      if (userData.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LogInScreen(
              phoneNumber: userData[0].trim(),
              password: userData[1].trim(),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("OTP verification failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Colors.grey),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Page", textAlign: TextAlign.center),
        toolbarHeight: 50,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text("Enter your OTP here", style: AppTextStyles.fontSize25()),
            const SizedBox(height: 20),
            Form(
              child: Pinput(
                length: 6,
                controller: pinController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Enter a valid 6-digit OTP";
                  }
                  return null;
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
            ),
            // Form(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children:
            //         List.generate(6, (index) => _buildOtpTextField(index)),
            //   ),
            // ),
            const SizedBox(height: 40),
            CustomButton(
              onPressed: _verifyOtp,
              backgroundColour: Colors.blue,
              minimumSize: const Size(300, 50),
              childWidget: Text("Confirm",
                  style: AppTextStyles.fontSize20(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:parshant_app/core/constants/constants.dart';
// import 'package:parshant_app/core/services/services.dart';
// import 'package:parshant_app/views/onBoardingScreen/log_in_screen.dart';
// import 'package:parshant_app/widgets/widgets.dart';
//
// class OtpScreen extends StatefulWidget {
//   final String verificationId;
//   final String phoneNumber;
//
//   OtpScreen({super.key, required this.verificationId, required this.phoneNumber});
//
//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> otpTextField = List.generate(6, (index) => TextEditingController());
//   final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(focusNodes[0]); // Pehle box pe focus
//     });
//   }
//
//   @override
//   void dispose() {
//     for (var controller in otpTextField) {
//       controller.dispose();
//     }
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//             child: Text(
//               "OTP Page",
//               style: AppTextStyles.fontSize25(color: Colors.white),
//             )),
//         toolbarHeight: 50,
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 10),
//           Text("Enter your OTP here", style: AppTextStyles.fontSize25()),
//           const SizedBox(height: 20),
//           Form(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(6, (index) {
//                 return enterOtpTextField(context, otpTextField[index], focusNodes[index], index);
//               }),
//             ),
//           ),
//           const SizedBox(height: 30),
//           Center(
//             child: CustomButton(
//                 onPressed: () async {
//                   String smsCode = otpTextField.map((controller) => controller.text).join();
//                   print("smsCode $smsCode yhe h ");
//
//                   try {
//                     AuthCredential credential = PhoneAuthProvider.credential(
//                       verificationId: widget.verificationId,
//                       smsCode: smsCode,
//                     );
//
//                     UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//                     print("OTP sahi hai!");
//
//                     await FirebaseAuth.instance.currentUser!.delete();
//                     List<String> userdata = await FirebaseFindUserNumber.userDataFind(widget.phoneNumber);
//
//                     if (userdata.isNotEmpty) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LogInScreen1(
//                                 phoneNumber: userdata[0].trim(),
//                                 password: userdata[1].trim(),
//                               )));
//                     }
//                   } catch (e) {
//                     print("OTP galat hai ya koi error aayi: $e");
//                   }
//                 },
//                 backgroundColour: Colors.blue,
//                 minimumSize: const Size(300, 50),
//                 childWidget: Text("Confirm", style: AppTextStyles.fontSize20(color: Colors.white))),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget enterOtpTextField(BuildContext context, TextEditingController controller, FocusNode focusNode, int index) {
//     return SizedBox(
//       height: 50,
//       width: 44,
//       child: TextField(
//         controller: controller,
//         focusNode: focusNode,
//         onChanged: (value) {
//           if (value.length == 1 && index < 5) {
//             FocusScope.of(context).requestFocus(focusNodes[index + 1]); // Agle box pe shift ho
//           }
//         },
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
//         ),
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//       ),
//     );
//   }
// }
