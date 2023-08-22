import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AppData {
  static final AppData _instance = AppData._privateConstructor();

  AppData._privateConstructor();

  static AppData get instance => _instance;

  User? currentUser;

  Future<void> setCurrentUser(User user) async {
    currentUser = user;
  }
}
