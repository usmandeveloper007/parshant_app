import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:parshant_app/core/utils/shared_prefrences.dart';

import 'server_time_fetch.dart';

class FirebaseNumber {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>> fetchBet() async {
    try {
      String? id = await SharedPreferencesHelper.getValue();

      id!.trim();

      int currentTimeStamp = await fetchServerTimeIST();

      DateTime sevenDaysAgo =
          DateTime.fromMillisecondsSinceEpoch(currentTimeStamp)
              .subtract(const Duration(days: 8));

      Timestamp sevenDaysAgoTimestampAgo = Timestamp.fromDate(sevenDaysAgo);

      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .doc(id)
          .collection("myBets")
          .where("betDate", isGreaterThanOrEqualTo: sevenDaysAgoTimestampAgo)
          .orderBy("betDate", descending: true)
          .get();
      List<Map<String, dynamic>> fetchNumber = [];

      querySnapshot.docs.forEach((doc) {
        fetchNumber.add(doc.data() as Map<String, dynamic>);
      });

      print("Data fetched successfully");
      return fetchNumber;
    } catch (e) {
      print("Error fetching data: $e");
      throw Exception("Data not fetched: $e");
    }
  }

  // hume sirf recent ko fetch krna h yha se okay done h

  static Future<Map<String, dynamic>> recentFetchBet() async {
    try {
      String? id = await SharedPreferencesHelper.getValue();

      id!.trim();

      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .doc(id)
          .collection("myBets")
          .orderBy("betDate", descending: true)
          .limit(1)
          .get();
      Map<String, dynamic> fetchNumber = {};

      fetchNumber = querySnapshot.docs.first.data() as Map<String, dynamic>;

      print("Data fetched successfully");
      return fetchNumber;
    } catch (e) {
      print("Error fetching data: $e");
      throw Exception("Data not fetched: $e");
    }
  }


}

