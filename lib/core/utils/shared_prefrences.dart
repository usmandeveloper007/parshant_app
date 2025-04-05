import 'package:flutter/material.dart';
import 'package:parshant_app/core/constants/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferencesHelper {
  static const String UserID = "UUID";

  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> storeValue(String id) async {
    var prefes = await _getInstance();

    String? existingUId = prefes.getString(UserID);

    if (existingUId == null) {
      await prefes.setString(UserID, id);
    } else {
      print('UID already exists , no need to store again');
    }
  }

  static Future<String?> getValue() async {
    var prefes = await _getInstance();

    return prefes.getString(UserID);
  }

  // next ab hum isko clear krege ..

  static Future<void> clearValue(BuildContext context) async {
    var prefes = await SharedPreferences.getInstance();
    await prefes.clear();
    print("clear");

    // next work ho ga direct log_out page pe ..
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInScreen1()));
  }

  /// Save MobileNumber
  static Future<void> setMobileNumber(String mobileNumber) async {
    final prefs = await _getInstance();
    await prefs.setString(StringConstants.spUserMobileNumber, mobileNumber);
  }

  /// Get MobileNumber
  static Future<String?> getMobileNumber() async {
    final prefs = await _getInstance();
    return prefs.getString(StringConstants.spUserMobileNumber);
  }

  /// Save Password
  static Future<void> setPassword(String password) async {
    final prefs = await _getInstance();
    await prefs.setString(StringConstants.spUserPassword, password);
  }

  /// Get Password
  static Future<String?> getPassword() async {
    final prefs = await _getInstance();
    return prefs.getString(StringConstants.spUserPassword);
  }
}

