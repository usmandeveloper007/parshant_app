import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parshant_app/core/services/firebase_number_add.dart';
import 'package:parshant_app/core/services/firebase_service_instance.dart';
import 'package:parshant_app/models/mybets_model.dart';
import '../utils/utils.dart';
import 'mybets_fetchfrom_database.dart';

class MyBetsFirebaseToDatabase {
  static final DatabaseHelper dbClass = DatabaseHelper.instance;

  static Future<List<MyBet>> syncFirebaseToSQLite() async {
    try {
      await dbClass.getDb();

      var localData = await MYBetFetchFromDataBase.fetchDataFromDatabase();
      if (localData.isNotEmpty) {
        print("✅ SQLite me data hai, Firebase fetch nahi hoga.");
        return localData;
      }

      print("🔄 Firebase se data fetch kar rahe hain...");
      FirebaseFirestore fireStore = FirebaseServiceInstance.instance.firestore;
      List<Map<String, dynamic>> firebaseData = await FirebaseNumber.fetchBet();

      String? userId = await SharedPreferencesHelper.getValue();
      if (userId == null || userId.trim().isEmpty) {
        print("❌ Error: User ID null ya empty hai!");
        return [];
      }

      for (var data in firebaseData) {
        if (!data.containsKey("numbers") || data["numbers"] == null) {
          print("❌ Error: Firebase se 'numbers' missing hai.");
          continue;
        }

        String jsonString = jsonEncode(data["numbers"]);
        Timestamp milliseconds = data["betDate"];
        int betTimestamp = milliseconds.millisecondsSinceEpoch;

        dbClass.addMyBets(
          userId: userId.trim(),
          resultDate: data["date"],
          betDate: betTimestamp,
          gameName: data["gameName"],
          status: data["status"],
          numbers: jsonString,
          totalAmount: data["totalAmount"],
        );
      }

      print("✅ Firebase data successfully SQLite me sync ho gaya!");
      return await MYBetFetchFromDataBase.fetchDataFromDatabase();
    } catch (e) {
      print("❌ Firebase to SQLite Sync Error: $e");
      return [];
    }
  }

  static Future<void> addData() async {
    try {
      Map<String, dynamic> recentBet = await FirebaseNumber.recentFetchBet();

      if (recentBet.isEmpty) {
        print("❌ Error: Recent bet data empty hai.");
        return;
      }

      String? userId = await SharedPreferencesHelper.getValue();
      if (userId == null || userId.trim().isEmpty) {
        print("❌ Error: User ID null ya empty hai.");
        return;
      }

      if (!recentBet.containsKey("numbers") || recentBet["numbers"] == null) {
        print("❌ Error: 'numbers' missing hai.");
        return;
      }

      String jsonString = jsonEncode(recentBet["numbers"]);
      Timestamp milliseconds = recentBet["betDate"];
      int betTimestamp = milliseconds.millisecondsSinceEpoch;

       dbClass.addMyBets(
        userId: userId.trim(),
        resultDate: recentBet["date"],
        betDate: betTimestamp,
        gameName: recentBet["gameName"],
        status: recentBet["status"],
        numbers: jsonString,
        totalAmount: recentBet["totalAmount"],
      );

      print("✅ Recent bet successfully added to SQLite.");
    } catch (e) {
      print("❌ Error in addData: $e");
    }
  }
}
