import 'package:firebase_auth/firebase_auth.dart';

class AppData {
  static final AppData _instance = AppData._privateConstructor();
  AppData._privateConstructor();
  static AppData get instance => _instance;
  User? currentUser;
  static User? staticUser;
  void setCurrentUser(User user) {
    currentUser = user;
  }
}
