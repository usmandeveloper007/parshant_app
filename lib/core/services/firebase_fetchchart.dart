import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChart {
  static Future<List<dynamic>> fetchChart() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      DocumentSnapshot snapshot =
          await firestore.collection("chartData").doc("gameResult").get();

      if (snapshot.exists) {
        var gameData = snapshot.data()as Map<String, dynamic>;
        List<dynamic> gamesResult = gameData["data"];
        gamesResult.sort((a, b) {
          Timestamp timestampA = a['Date']; // Access the Timestamp
          Timestamp timestampB = b['Date']; // Access the Timestamp
          DateTime dateA = timestampA.toDate(); // Convert Timestamp to DateTime
          DateTime dateB = timestampB.toDate(); // Convert Timestamp to DateTime
          return dateB.compareTo(dateA); // For descending order
        });
        return gamesResult;
      } else {
        print("data is not exist");
        return [];
      }
    } catch (e) {
      print("e : $e");
      return [];
    }
  }
}


