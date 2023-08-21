import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_infos.dart';


class AppData {
  static final AppData _instance = AppData._privateConstructor();
  AppData._privateConstructor();
  static AppData get instance => _instance;

  User? currentUser;
  UserInfos? userInfos;

  Future<void> _getUserData(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        final userData = snapshot.data()!;
        userInfos= UserInfos(
            uid: currentUser!.uid,
            firstName: userData['first_name'],
            lastName: userData['last_name'],
            picUrl: userData['pic_url'],
            user_role: userData['user_role'],
            userType: userData['userType'],
            region: userData['region'],
        );
      } else {
        print("User with UID $uid not found.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> setCurrentUser(User user) async {
    currentUser = user;
    _getUserData(currentUser!.uid);
  }
}
