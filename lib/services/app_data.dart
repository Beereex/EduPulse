import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/extended_user.dart';

class AppData {
  static final AppData _instance = AppData._privateConstructor();
  AppData._privateConstructor();
  static AppData get instance => _instance;

  User? currentUser;
  ExtendedUser? extendedUser; // Placeholder for extended user information

  Future<void> setCurrentUser(User user) async {
    currentUser = user;
    await fetchExtendedUserData(user.uid); // Fetch extended user data from Firestore
  }

  Future<void> fetchExtendedUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        currentUser = currentUser.fromFirestore(userDoc.data()!);
      }
    } catch (e) {
      print("Error fetching extended user data: $e");
    }
  }
}
