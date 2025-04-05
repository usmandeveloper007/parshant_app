import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parshant_app/core/utils/shared_prefrences.dart';

class FirebaseFetchTotalBalance {
  static Future<String> fetchBalance() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      String? value = await SharedPreferencesHelper.getValue();
      if (value == null || value.trim().isEmpty) {
        print("SharedPreferences me koi valid value nahi hai!");
        return "parshant";
      } else {
        value = value.trim();
        print("${value.toString()} = value shred prefrences ki yhe h ");
      }

      DocumentSnapshot documentSnapshot = await firestore
          .collection("users")
          .doc(value.trim())
          .collection("User_totalBalance")
          .doc("balance")
          .get();

      if (documentSnapshot.exists) {
        String balanceData = documentSnapshot["total_balanceValue"].toString();

        print("Successfully fetched balance: $balanceData");
        return balanceData;
      }
      return "Ashu tyagi";
    } catch (e) {
      print("Data fetch nahi ho raha: $e");
      return "Error";
    }
  }
}
