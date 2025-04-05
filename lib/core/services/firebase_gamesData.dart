import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:parshant_app/core/utils/database/database_helper.dart';

class FormatedDate {
  static String formattedDateTime(dynamic timestamp) {
    DateTime dateTime;

    if (timestamp is Timestamp) {
      dateTime = timestamp
          .toDate(); // Firestore Timestamp ko DateTime me convert karein
    } else if (timestamp is int) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(
          timestamp); // SQLite integer ko DateTime me convert karein
    } else {
      return "Invalid Date"; // Agar koi aur type ho toh error handle karein
    }

    return DateFormat("dd-MM-yyyy").format(dateTime).toString();
  }
}

class SaveData {
  static Future<List<Map<String, dynamic>>> syncFirebaseToSQLite() async {
    DatabaseHelper dbClass = DatabaseHelper.instance;
    await dbClass.getDb();

    var data = await dbClass.fetchData();
    var data2 = await dbClass.fetchData2();

    if (data.isNotEmpty && data2.isNotEmpty) {
      print("✅ SQLite me pehle se data hai, Firebase fetch nahi hoga.");

      // ✅ Update hone ke baad data wapas fetch karo taaki sure ho ki update ho gaya
      var updatedData = await dbClass.fetchData();

      return updatedData; // ✅ Sirf pehle table ka data return kar rahe hain
    }

    print(
        "🔄 SQLite khali hai, Firebase se data fetch karna shuru kar rahe hain...");

    FirebaseFirestore fireStore = FirebaseFirestore.instance;

    try {
      // Pehle collection se data fetch karo
      QuerySnapshot querySnapshot = await fireStore
          .collection("gamesData")
          .orderBy("timeresult", descending: false)
          .get();

      // 2nd collection se data fetch karo
      QuerySnapshot querySnapshot2 =
          await fireStore.collection("chnageGamesData").get();

      List<Map<String, dynamic>> gamesList = [];

      // Pehle table ke liye data insert karo
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> game = doc.data() as Map<String, dynamic>;
        Timestamp timestamp = game["timeresult"];
        int millis = timestamp.millisecondsSinceEpoch;
        print("millis: $millis");
        // ✅ Firebase ka data SQLite me insert karo aur await karo
        dbClass.addNotes(
          gameName: game["GameName"]?.toString() ?? "ashu",
          betStartTime: game["Bet Start Time"]?.toString() ?? "ashu",
          betCloseTime: game["Bet Close Time"]?.toString() ?? "ashu",
          lastResult: game["Last Result"]?.toString() ?? "ashu",
          resultTime: game["Result Time"]?.toString() ?? "ashu",
          afterResult: game["afterResult"] == true ? 1 : 0,
          changeSystem: game["changeSystem"] == true ? 1 : 0,
          betDate: millis,
        );

        gamesList.add(game);
      }

      // 2nd table ke liye data insert karo
      for (var doc in querySnapshot2.docs) {
        Map<String, dynamic> game = doc.data() as Map<String, dynamic>;

        // ✅ Firebase ka data SQLite me insert karo aur await karo
        dbClass.addNotes2(
          isChange: game["isChange"] == true ? 1 : 0,
        );
      }

      print("✅ Firebase se SQLite me data insert ho gaya!");

      // ✅ Ab SQLite se data fetch karo, taaki sure ho ki data insert ho chuka hai
      return await dbClass.fetchData(); // Sirf pehle table ka data return karo
    } catch (e) {
      print("❌ Firebase to SQLite Sync Error: $e");
      return [];
    }
  }
}

