import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/utils.dart';

class FirestoreService {
  static Future<void> fetchFromCacheAndSync() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var dbClass = DatabaseHelper.instance;

    try {
      // Fetch data from Firestore's 'chnageGamesData' collection
      QuerySnapshot snapshot =
          await firestore.collection('chnageGamesData').get();

      if (snapshot.docs.isEmpty) {
        print("❌ Cache empty, data fetch failed.");
        return;
      }

      print("✅ Cache data fetched successfully: ${snapshot.docs.length} docs");

      // Fetch local data from SQLite
      List<Map<String, dynamic>> localData = await dbClass.fetchData2();

      if (localData.isEmpty) {
        print("❌ SQLite is empty.");
        return;
      }

      // Convert Firestore data to a list of maps
      List<Map<String, dynamic>> firestoreList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("✅ Firestore List Data: $firestoreList");

      // Convert Firestore's isChange value to int (1 for true, 0 for false)
      int newUpdate = firestoreList[0]["isChange"] == true ? 1 : 0;
      print("New Update from Firestore: $newUpdate");

      // Get the current isChange value from SQLite
      int databaseNewUpdate = localData[0]["isChange"];
      print("Current Update in SQLite: $databaseNewUpdate");

      // Check if an update is needed
      if (newUpdate == databaseNewUpdate) {
        print("✅ No update needed. Data is already in sync.");
        return;
      }

      // Clear the existing data in the 'gamesData' table
      await dbClass.clearTableData(tableName: "gamesData");
      print("✅ 'gamesData' table cleared successfully.");

      // Fetch new data from Firestore's 'gamesData' collection
      QuerySnapshot querySnapshot = await firestore
          .collection("gamesData")
          .orderBy("timeresult", descending: false)
          .get();

      // Insert new data into SQLite
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> game = doc.data() as Map<String, dynamic>;
        Timestamp timestamp = game["timeresult"];
        int millis = timestamp.millisecondsSinceEpoch;
        dbClass.addNotes(
          betDate: millis,
          gameName: game["GameName"]?.toString() ?? "ashu",
          betStartTime: game["Bet Start Time"]?.toString() ?? "ashu",
          betCloseTime: game["Bet Close Time"]?.toString() ?? "ashu",
          lastResult: game["Last Result"]?.toString() ?? "ashu",
          resultTime: game["Result Time"]?.toString() ?? "ashu",
          afterResult: game["afterResult"] == true ? 1 : 0,
          changeSystem: game["changeSystem"] == true ? 1 : 0,
        );
      }
      // aur yha fetch bhi tho krna padega bhaii
      dbClass.fetchData();

      dbClass.updateChnageValue(newUpdate);
      print("✅ New data inserted into SQLite successfully.");
    } catch (e) {
      print("❌ Error syncing data: $e");
    }
  }
}

