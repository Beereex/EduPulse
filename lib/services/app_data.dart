import 'package:firebase_auth/firebase_auth.dart';

class AppData {
  static final AppData _instance = AppData._privateConstructor();

  // Private constructor to prevent multiple instances of the class
  AppData._privateConstructor();

  // Singleton instance
  static AppData get instance => _instance;

  // User information
  User? currentUser; // You can use your own User class or FirebaseUser

  // Other app-wide data can be added here

  // Method to set the current user
  void setCurrentUser(User user) {
    currentUser = user;
  }
}
