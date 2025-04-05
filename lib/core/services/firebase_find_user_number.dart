import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parshant_app/core/services/firebase_service_instance.dart';

class FirebaseFindUserNumber {
  static Future<bool> checkuserNumber(String phoneNumber) async {
    FirebaseFirestore firestore = FirebaseServiceInstance.instance.firestore;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .where("phoneNumber", isEqualTo: phoneNumber)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }



  static Future<List<String>> userDataFind(String phoneNumber) async {
    FirebaseFirestore firestore = FirebaseServiceInstance.instance.firestore;
    List<String> userFind = [];

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .where("phoneNumber", isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var docData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Data ko list me add karna
        userFind.add(docData["phoneNumber"] ?? "");
        userFind.add(docData["Password"] ?? "");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }

    return userFind;
  }
}

