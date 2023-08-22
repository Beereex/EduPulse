import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_infos.dart';


class AppData {
  static final AppData _instance = AppData._privateConstructor();
  AppData._privateConstructor();
  static AppData get instance => _instance;

  User? currentUser;
  UserInfos? userInfos;

  Future<void> getUserData() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).get();

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
        print("User with UID ${currentUser?.uid} not found.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> setCurrentUser(User user) async {
    currentUser = user;
  }

  void updateUserProfile(String uid, String newPicUrl, String newFirstName, String newLastName) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'pic_url': newPicUrl,
        'first_name': newFirstName,
        'last_name': newLastName,
      });
      print('User profile updated successfully');
      _updateUserInfos(
        firstName: newFirstName,
        lastName: newLastName,
        picUrl: newPicUrl,
      );
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  void _updateUserInfos({
    String? firstName,
    String? lastName,
    String? picUrl,
    // ... other fields you want to update ...
  }) {
    if (firstName != null) userInfos!.firstName = firstName;
    if (lastName != null) userInfos!.lastName = lastName;
    if (picUrl != null) userInfos!.picUrl = picUrl;
    // ... update other fields ...
  }

}
