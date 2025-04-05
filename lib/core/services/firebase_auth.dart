import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parshant_app/core/services/firebase_service_instance.dart';
import 'package:parshant_app/core/utils/shared_prefrences.dart';
import 'package:parshant_app/views/auth/log_in_screen.dart';
import 'package:parshant_app/widgets/custom_flushbaar.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseServiceInstance.instance.auth;

  static final FirebaseFirestore _firebaseFirestore =
      FirebaseServiceInstance.instance.firestore;

  // Log In method

  static Future<bool> loginWithEmailPassword({
    required String loginEmail,
    required String loginPassword,
    required BuildContext context,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: loginEmail.trim(),
        password: loginPassword.trim(),
      );

      if (credential.user != null) {
        await SharedPreferencesHelper.storeValue(credential.user!.uid);
        await SharedPreferencesHelper.setMobileNumber(loginEmail.split('@')[0]);
        await SharedPreferencesHelper.setPassword(loginPassword);
        CustomFlushBar.showFlushBar(
          message: "Log In Successful",
          context: context,
          backgroundColor: Colors.green,
        );
        return true; // ✅ Login success
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = 'Login failed. Please enter valid details.';
      if (e.code == 'user-not-found')
        errorMsg = 'No user found with this email.';
      if (e.code == 'wrong-password')
        errorMsg = 'Incorrect password. Try again.';
      if (e.code == 'network-request-failed')
        errorMsg = 'No internet connection.';

      CustomFlushBar.showFlushBar(message: errorMsg, context: context);
    } catch (e) {
      CustomFlushBar.showFlushBar(
          message: 'An error occurred: $e', context: context);
    }
    return false; //  Login failed
  }

  // register with Phone use email okay Done .....

  static Future<void> registerUser({
    required BuildContext context,
    required String phoneNumber,
    required String password,
    required String name,
  }) async {
    try {
      var credential = await _auth.createUserWithEmailAndPassword(
        email: phoneNumber,
        password: password,
      );

      var userId = credential.user!.uid;

      await _firebaseFirestore.collection("users").doc(userId).set({
        "Name": name,
        "phoneNumber": phoneNumber,
        "Password": password,
      });

      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('User_totalBalance')
          .doc("balance")
          .set({'total_balanceValue': 0.0.toDouble()});

      // context.mounted check karte hain
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
        );

        CustomFlushBar.showFlushBar(
          message: 'Registration Successful!',
          context: context,
          backgroundColor: Colors.green,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        switch (e.code) {
          case 'email-already-in-use':
            CustomFlushBar.showFlushBar(
              message: 'PhoneNumber already exists. Please use another.',
              context: context,
            );
            break;
          case 'invalid-email':
            CustomFlushBar.showFlushBar(
              message: 'Invalid number. Please try again.',
              context: context,
            );
            break;
          case 'network-request-failed':
            CustomFlushBar.showFlushBar(
              message:
                  'No internet connection. Check your network and try again.',
              context: context,
            );
            break;
          case 'operation-not-allowed':
            CustomFlushBar.showFlushBar(
              message: 'phone/password accounts are not enabled.',
              context: context,
            );
            break;
          default:
            CustomFlushBar.showFlushBar(
              message: 'An unexpected error occurred. Try again.',
              context: context,
            );
        }
      }
    } catch (e) {
      if (context.mounted) {
        CustomFlushBar.showFlushBar(
          message: 'Something went wrong. Please try again later.',
          context: context,
        );
      }
    }
  }
}


