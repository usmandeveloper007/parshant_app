import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServiceInstance {

  // yhe private constructor ho gya
  FirebaseServiceInstance._();
  static final FirebaseServiceInstance _instance = FirebaseServiceInstance._();
  static FirebaseServiceInstance get instance => _instance;
  // yhe firestore instance
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  // Firebase Auth instance
  FirebaseAuth get auth => FirebaseAuth.instance;

}
